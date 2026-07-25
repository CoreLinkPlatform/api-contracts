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

The public OpenAPI document now contains a reviewed draft for the locally
verified Tenant → Device → Provisioning → Command slice, and AsyncAPI contains
a draft command-event envelope. The admin and internal documents remain
incomplete. These drafts are not stable release
contract and must not be used to publish an SDK or claim full API
compatibility until API-01/API-02 acceptance and cross-repository validation
are complete.

## Contract rules

- Public device identity is `corelink_device_id`; integration IDs remain
  internal implementation details.
- Model CoreLink resources, not raw upstream-provider payloads. Public
  terminology uses neutral CoreLink names and the `tc`/`or` codes only.
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
