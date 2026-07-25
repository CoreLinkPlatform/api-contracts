#!/usr/bin/env ruby
# frozen_string_literal: true

# Small dependency-free contract lint. It catches incomplete operations before
# a full OpenAPI/AsyncAPI validator is introduced in the contract toolchain.

require "json"
require "yaml"

PUBLIC_SPEC = "openapi/corelink-public-v1.yaml"
OPERATIONS = %w[get put post patch delete head options].freeze

spec = YAML.safe_load(File.read(PUBLIC_SPEC), permitted_classes: [], aliases: false)
errors = []
paths = spec.fetch("paths", {})
errors << "public contract must declare paths" if paths.empty?

paths.each do |path, path_item|
  OPERATIONS.each do |method|
    operation = path_item[method]
    next unless operation

    location = "#{method.upcase} #{path}"
    errors << "#{location}: missing operationId" if operation["operationId"].to_s.empty?
    errors << "#{location}: missing x-corelink-stability" if operation["x-corelink-stability"].to_s.empty?
    errors << "#{location}: missing responses" if operation.fetch("responses", {}).empty?
  end
end

%w[
  postman/corelink-public-v1.postman_collection.json
  postman/corelink-public-v1.postman_environment.json
].each do |path|
  JSON.parse(File.read(path))
rescue JSON::ParserError => error
  errors << "#{path}: invalid JSON (#{error.message})"
end

if errors.empty?
  puts "Contract lint passed."
else
  warn errors.join("\n")
  exit 1
end

