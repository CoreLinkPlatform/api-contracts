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
| `postman/` | Collections, environments and runnable examples |
| `docs/terminology.md` | Shared public-contract vocabulary |

## Current status

The repository structure and JSON Schemas are present, but the OpenAPI and
AsyncAPI specification files are currently empty. They are not usable as
generated-client or mock-server inputs yet. Do not publish an SDK or claim API
compatibility until a reviewed, versioned specification exists.

## Contract rules

- Public device identity is `corelink_device_id`; integration IDs remain
  internal implementation details.
- Model CoreLink resources, not raw Traccar, OpenRemote or Keycloak payloads.
- Keep public, admin and internal audiences in separate documents.
- Define authentication, tenant scope, authorization failures, pagination,
  idempotency and problem responses for every operation.
- Make breaking changes through an explicit versioned contract and coordinated
  platform/SDK release.

## Before merging a contract change

1. Check that the change matches the CoreLink ownership boundaries in the
   [`platform` architecture](https://github.com/CoreLinkPlatform/platform/tree/main/docs/architecture).
2. Validate syntax and references with the chosen OpenAPI/AsyncAPI validator.
3. Add representative request, response and error examples.
4. Update affected SDK, mock-server, developer-docs and website references in
   the same delivery plan.
