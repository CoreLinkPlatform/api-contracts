# Changelog

All notable contract releases are recorded here. Contract tags are immutable;
corrections require a new patch tag and must not be moved in place.

## [1.0.0-draft] - 2026-07-25

Initial reviewed draft for the proven Device and Command public slice.

### Added

- canonical public device and command identifiers;
- tenant-scoped device listing, lookup, creation and command operations;
- `application/problem+json` error responses with correlation IDs;
- canonical event envelope and device lifecycle event definitions;
- compatibility policy and public OpenAPI compatibility gate.

### Explicitly not released

Tenant provisioning, partner credentials, webhooks, telemetry, billing and
privileged administration remain outside this draft until their contracts and
runtime parity evidence are reviewed.

