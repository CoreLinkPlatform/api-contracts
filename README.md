# CoreLink API Contracts

Versioned, implementation-independent contracts for CoreLink APIs and events.
This repository is the handoff boundary between the platform runtime and every
SDK, CLI, mock server, MCP server and external integration.

## Contents

| Path | Intended contract |
| --- | --- |
| `openapi/corelink-public-v1.yaml` | Partner and product-facing API |
| `openapi/corelink-admin-v1.yaml` | Privileged administrative API |
| `openapi/corelink-internal-v1.yaml` | Internal service contract; never expose as public API |
| `asyncapi/corelink-events-v1.yaml` | Published event channels and payloads |
| `schemas/` | Reusable JSON Schemas for device, command, event envelope and errors |
| `postman/` | Versioned collection, sandbox environment and runnable examples |
| `docs/terminology.md` | Shared public-contract vocabulary |

## Current status

P3.1 introduces a reviewed `1.0.0-draft` public contract for the proven Device
and Command slice, plus a canonical event envelope. It is intentionally a
small boundary: tenant provisioning, integration callbacks and privileged
administration remain out of public v1 until they have their own reviewed
contract. SDKs and the mock server may consume this draft only in prerelease
channels; it is not a release claim until runtime parity and CI checks land.

The immutable baseline tag is `v1.0.0-draft`. See the
[changelog](CHANGELOG.md) and [compatibility matrix](docs/compatibility-matrix.md)
for the exact release boundary and consumer status.

## Contract rules

- Public device identity is `corelink_device_id`; integration IDs remain
  internal implementation details.
- Model CoreLink resources, not raw integration-provider payloads.
- Keep public, admin and internal audiences in separate documents.
- Define authentication, tenant scope, authorization failures, pagination,
  idempotency and problem responses for every operation.
- Make breaking changes through an explicit versioned contract and coordinated
  platform/SDK release.

Read [the compatibility policy](docs/compatibility-policy.md) before changing a
public operation.

## Before merging a contract change

1. Check that the change matches the CoreLink ownership boundaries in the
   [`platform` architecture](https://github.com/CoreLinkPlatform/platform/tree/main/docs/architecture).
2. Validate syntax and references with the chosen OpenAPI/AsyncAPI validator.
3. Add representative request, response and error examples.
4. Update affected SDK, mock-server, developer-docs and website references in
   the same delivery plan.
5. Let the contract-compatibility workflow classify the public diff. It rejects
   breaking v1 changes; publish a new major document with migration guidance
   for any such change.
