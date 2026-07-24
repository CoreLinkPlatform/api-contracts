#!/usr/bin/env ruby
# frozen_string_literal: true

# A deliberately dependency-free public-contract gate. It compares the public
# OpenAPI document with a base revision and rejects removals or narrowing
# changes within a major version. A breaking change belongs in a new versioned
# document (for example corelink-public-v2.yaml), not behind an allow-list.

require "yaml"

abort "usage: #{$PROGRAM_NAME} BASE_SPEC CANDIDATE_SPEC" unless ARGV.length == 2

def load_spec(path)
  source = File.read(path)
  return nil if source.strip.empty?

  YAML.safe_load(source, permitted_classes: [], aliases: false) || {}
rescue Psych::Exception => error
  abort "invalid YAML in #{path}: #{error.message}"
end

def dereference(spec, value)
  return value unless value.is_a?(Hash) && value["$ref"]

  pointer = value.fetch("$ref")
  return value unless pointer.start_with?("#/")

  pointer.delete_prefix("#/").split("/").reduce(spec) { |node, key| node.fetch(key) }
rescue KeyError
  value
end

def schema_changes(base_spec, candidate_spec, base_schema, candidate_schema, location, changes)
  base_schema = dereference(base_spec, base_schema || {})
  candidate_schema = dereference(candidate_spec, candidate_schema || {})
  return unless base_schema.is_a?(Hash) && candidate_schema.is_a?(Hash)

  base_type = base_schema["type"]
  candidate_type = candidate_schema["type"]
  if base_type && candidate_type && base_type != candidate_type
    changes << "#{location}: type changed from #{base_type} to #{candidate_type}"
  end

  base_enum = Array(base_schema["enum"])
  candidate_enum = Array(candidate_schema["enum"])
  removed_values = base_enum - candidate_enum
  changes << "#{location}: enum values removed (#{removed_values.join(", ")})" unless removed_values.empty?

  base_required = Array(base_schema["required"])
  candidate_required = Array(candidate_schema["required"])
  added_required = candidate_required - base_required
  changes << "#{location}: fields made required (#{added_required.join(", ")})" unless added_required.empty?

  base_properties = base_schema.fetch("properties", {})
  candidate_properties = candidate_schema.fetch("properties", {})
  base_properties.each do |name, property|
    if !candidate_properties.key?(name)
      changes << "#{location}: response/request property removed (#{name})"
    else
      schema_changes(base_spec, candidate_spec, property, candidate_properties[name], "#{location}.#{name}", changes)
    end
  end

  schema_changes(base_spec, candidate_spec, base_schema["items"], candidate_schema["items"], "#{location}[]", changes) if base_schema["items"]
end

def content_schemas(spec, response_or_request)
  resolved = dereference(spec, response_or_request || {})
  resolved.fetch("content", {}).transform_values { |media| dereference(spec, media)["schema"] }
end

base_spec = load_spec(ARGV[0])
candidate_spec = load_spec(ARGV[1])
if base_spec.nil?
  warn "Base public contract is empty; compatibility comparison starts after this initial version is merged."
  exit 0
end
abort "candidate public contract is empty" if candidate_spec.nil?

base_major = base_spec.dig("info", "version").to_s.split(".").first
candidate_major = candidate_spec.dig("info", "version").to_s.split(".").first
abort "both contracts must declare info.version" if base_major.empty? || candidate_major.empty?

changes = []
base_paths = base_spec.fetch("paths", {})
candidate_paths = candidate_spec.fetch("paths", {})
base_paths.each do |path, base_path_item|
  candidate_path_item = candidate_paths[path]
  unless candidate_path_item
    changes << "path removed: #{path}"
    next
  end

  %w[get put post patch delete head options].each do |method|
    base_operation = base_path_item[method]
    next unless base_operation

    candidate_operation = candidate_path_item[method]
    unless candidate_operation
      changes << "operation removed: #{method.upcase} #{path}"
      next
    end

    base_parameters = Array(base_path_item["parameters"]) + Array(base_operation["parameters"])
    candidate_parameters = Array(candidate_path_item["parameters"]) + Array(candidate_operation["parameters"])
    base_parameters.each do |parameter|
      parameter = dereference(base_spec, parameter)
      identifier = [parameter["name"], parameter["in"]]
      candidate = candidate_parameters.map { |item| dereference(candidate_spec, item) }.find { |item| [item["name"], item["in"]] == identifier }
      if candidate.nil?
        changes << "parameter removed: #{method.upcase} #{path} #{identifier.join(" in ")}"
      elsif !parameter["required"] && candidate["required"]
        changes << "parameter made required: #{method.upcase} #{path} #{identifier.first}"
      else
        schema_changes(base_spec, candidate_spec, parameter["schema"], candidate["schema"], "#{method.upcase} #{path} parameter #{identifier.first}", changes)
      end
    end

    base_request = content_schemas(base_spec, base_operation["requestBody"])
    candidate_request = content_schemas(candidate_spec, candidate_operation["requestBody"])
    base_request.each do |media_type, schema|
      if !candidate_request.key?(media_type)
        changes << "request media type removed: #{method.upcase} #{path} #{media_type}"
      else
        schema_changes(base_spec, candidate_spec, schema, candidate_request[media_type], "#{method.upcase} #{path} request #{media_type}", changes)
      end
    end

    base_operation.fetch("responses", {}).each do |status, base_response|
      next unless status.match?(/^2/)
      candidate_response = candidate_operation.fetch("responses", {})[status]
      unless candidate_response
        changes << "success response removed: #{method.upcase} #{path} #{status}"
        next
      end
      content_schemas(base_spec, base_response).each do |media_type, schema|
        candidate_schema = content_schemas(candidate_spec, candidate_response)[media_type]
        if candidate_schema.nil?
          changes << "success response media type removed: #{method.upcase} #{path} #{status} #{media_type}"
        else
          schema_changes(base_spec, candidate_spec, schema, candidate_schema, "#{method.upcase} #{path} #{status} #{media_type}", changes)
        end
      end
    end
  end
end

if changes.empty?
  puts "Public OpenAPI compatibility check passed."
  exit 0
end

if candidate_major.to_i > base_major.to_i
  warn "Breaking changes are permitted because contract major changed from #{base_major} to #{candidate_major}."
  changes.each { |change| warn "  - #{change}" }
  exit 0
end

warn "Breaking public OpenAPI changes require a new major contract (found #{base_major} -> #{candidate_major}):"
changes.each { |change| warn "  - #{change}" }
exit 1
