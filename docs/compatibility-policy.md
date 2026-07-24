# API compatibility policy

`v1` is a public, supported contract. Its canonical source is this repository;
runtime implementation, SDKs, the CLI, documentation and the mock server must
be verified against it before release.

## Compatibility promise

- A `v1` operation, path parameter, required request field, response field or
  documented error code is not removed or changed incompatibly within v1.
- New optional fields, optional query parameters, new enum values and new
  operations are additive changes. Consumers must ignore unknown response
  fields and handle unknown enum values safely.
- New required request fields, tighter validation, changed semantics, response
  type changes and authentication/authorization expansion are breaking.
- Breaking public changes require a new major contract (`v2`), migration
  guidance, a sunset date and compatibility tests. They cannot be hidden behind
  a server flag or an SDK-only change.

## Lifecycle and deprecation

Every public operation declares `x-corelink-stability`. Deprecated operations
remain available for at least 180 days after a dated `Deprecation` response
header and replacement documentation are published. Responses for a deprecated
operation include `Sunset` when a removal date is set.

## Error and tenant rules

All non-success responses use `application/problem+json` and include a safe
`correlation_id`. Public resources use canonical CoreLink IDs only. A caller
must be authorized for the path tenant; an unauthorized caller is never given
integration-provider IDs or raw provider payloads.

## Release gate

Each contract PR must validate syntax and references, classify its diff as
additive or breaking, update examples and record the contract version used by
each generated SDK release. A breaking diff without a new major document fails
the release gate.
