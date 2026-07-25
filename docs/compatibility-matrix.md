# Contract compatibility matrix

This matrix records the contract version and verification boundary for each
consumer. A draft tag is immutable, but it is not a production support claim.

| Surface | Contract source | Version | Compatibility gate | Current status |
| --- | --- | --- | --- | --- |
| Public HTTP API | `openapi/corelink-public-v1.yaml` | `1.0.0-draft` | OpenAPI syntax + public diff checker | Draft reviewed; runtime parity is a separate gate |
| Admin HTTP API | `openapi/corelink-admin-v1.yaml` | `1.0.0-draft` | OpenAPI syntax + authorization review | Internal draft; not a public release |
| Internal HTTP API | `openapi/corelink-internal-v1.yaml` | `1.0.0-draft` | OpenAPI syntax + service ownership review | Internal draft; not a public release |
| Events | `asyncapi/corelink-events-v1.yaml` | `1.0.0-draft` | AsyncAPI validation + event envelope review | Draft; delivery/replay evidence remains platform-owned |
| Python/TypeScript/Java SDKs | Generated or hand-written consumers | N/A | Contract version pinned per release | No stable SDK release claim for this draft |
| CLI, mock server and MCP server | Consumer repositories | N/A | Runtime parity and examples | Must consume a reviewed tag before beta |

## Release rules

1. Each released row must point to an immutable Git tag.
2. Additive changes within the same major version require a new minor or patch
   tag and a changelog entry.
3. Breaking changes require a new major contract document and migration notes.
4. A contract tag is not a runtime release until the corresponding consumer
   parity checks and operational evidence are attached to the release record.

