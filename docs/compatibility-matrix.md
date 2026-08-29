# Contract compatibility matrix

This matrix records the contract version and verification boundary for major consumers. A draft tag is immutable/reproducible, but it is not a production-support claim.

| Surface | Contract source | Version | Compatibility gate | Current status |
| --- | --- | --- | --- | --- |
| Public HTTP API | `openapi/corelink-public-v1.yaml` | `1.0.0-draft` | OpenAPI syntax + public diff + runtime parity | Draft reviewed Device/Command slice; broader v1 expansion remains gated |
| Admin HTTP API | `openapi/corelink-admin-v1.yaml` | `1.0.0-draft` | OpenAPI syntax + authorization review | Internal/admin draft; not a public release |
| Internal HTTP API | `openapi/corelink-internal-v1.yaml` | `1.0.0-draft` | OpenAPI syntax + service ownership review | Internal draft; not a public release |
| Events | `asyncapi/corelink-events-v1.yaml` | `1.0.0-draft` | AsyncAPI validation + event/runtime evidence | Canonical draft boundary; full delivery/replay/webhook acceptance remains gated |
| CoreLink Console | Public/admin operations consumed through the Platform API | Console 0.1.x Alpha | Console adapter/runtime/API compatibility + tenant/auth acceptance | Alpha; asset/geofence collection read-model gaps are documented in the Console repository |
| TypeScript SDK | Generated public-contract consumer | `0.1.0-draft` metadata | Tagged provenance + build + mock/sandbox/runtime conformance | Prerelease Alpha; no Stable package claim |
| Python SDK | Generated public-contract consumer | `0.1.0.dev0` metadata | License/support decision + tagged provenance + conformance | Prerelease Alpha; no Stable package claim |
| Java SDK | Future generated/ergonomic consumer | N/A | Generation + behavior + signed release/conformance | Scaffold/Planned |
| CLI | Public/operator contract consumer | N/A | Security boundary + supported commands + package/conformance | Scaffold/Planned |
| Mock server | Normative contract simulation | N/A | Contract-pinned deterministic scenarios + packaged conformance | Scaffold/Planned |
| MCP server | Public contract/docs tool consumer | N/A | MCP security boundary + contract-pinned tools + conformance | Scaffold/Planned |
| Developer documentation | Human-facing guidance | v1 Alpha docs | Version/link/example checks against declared contract/tool maturity | Alpha; may document draft/planned surfaces only with explicit maturity |

## Release rules

1. Each released consumer must point to immutable source/contract provenance appropriate to its maturity.
2. Additive compatible contract changes require version/changelog updates under the compatibility policy.
3. Breaking public changes require a new major contract boundary plus migration guidance.
4. A contract tag is not a runtime release until corresponding parity/operational evidence is attached.
5. Console/demo/UI completeness does not prove a missing live public read model.
6. Generated SDK code does not prove runtime parity or supported package publication.
