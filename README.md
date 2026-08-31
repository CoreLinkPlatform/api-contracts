# CoreLink API Contracts

[![Contract: 1.0.0-draft](https://img.shields.io/badge/public%20contract-1.0.0--draft-blue)](https://github.com/CoreLinkPlatform/api-contracts/releases)
[![Contract compatibility](https://github.com/CoreLinkPlatform/api-contracts/actions/workflows/contract-compatibility.yml/badge.svg?branch=main)](https://github.com/CoreLinkPlatform/api-contracts/actions/workflows/contract-compatibility.yml)
[![Maturity: Draft](https://img.shields.io/badge/maturity-draft-orange)](https://github.com/CoreLinkPlatform/.github/blob/main/REPOSITORY_MATURITY.md)
[![OpenAPI](https://img.shields.io/badge/OpenAPI-v1-6BA539)](openapi/corelink-public-v1.yaml)
[![AsyncAPI](https://img.shields.io/badge/AsyncAPI-events-2D8CFF)](asyncapi/corelink-events-v1.yaml)

Versioned, implementation-independent contracts for CoreLink APIs and events. This repository is the normative machine-readable handoff boundary between the Platform runtime and Console, SDKs, CLI, mock server, MCP server and external integrations.

## Contents

| Path | Intended contract |
| --- | --- |
| `openapi/corelink-public-v1.yaml` | Partner/product-facing public API |
| `openapi/corelink-admin-v1.yaml` | Privileged administrative API |
| `openapi/corelink-internal-v1.yaml` | Internal service contract; never expose as public API |
| `asyncapi/corelink-events-v1.yaml` | Event channels/payloads |
| `schemas/` | Reusable JSON Schemas for device, command, event envelope and errors |
| `postman/` | Versioned collection/environment/examples |
| `docs/compatibility-policy.md` | Compatibility/versioning rules |
| `docs/compatibility-matrix.md` | Consumer/release compatibility inventory |
| `docs/runtime-parity.md` | Runtime parity boundary/evidence expectations |
| `docs/terminology.md` | Shared public-contract vocabulary |

## Current public baseline

The immutable `v1.0.0-draft` baseline defines the reviewed public Device + Command slice and canonical event envelope. It is intentionally narrower than the private runtime and Console product surface.

Broader Asset/binding/telemetry/location/alerts, partner credential/webhook/usage/operations and full event schema work remains owned by the corresponding API-02/API-03/API-04 backlog and runtime acceptance gates.

A contract tag is reproducibility evidence; it is not by itself a runtime/SDK/Stable-support claim.

See [CHANGELOG.md](CHANGELOG.md), [compatibility policy](docs/compatibility-policy.md), [compatibility matrix](docs/compatibility-matrix.md) and [runtime parity](docs/runtime-parity.md).

## Contract rules

- Public device identity is `corelink_device_id`; provider/integration IDs remain implementation details.
- Model CoreLink resources, not raw provider payloads.
- Keep public, admin and internal audiences in separate documents.
- Define authentication, tenant scope, authorization failures, pagination, idempotency and problem responses for every operation.
- Preserve provider-neutral semantics for Console/SDK/CLI/MCP consumers.
- Breaking changes require an explicit versioned contract and coordinated migration/release decision.

## Consumer responsibilities

- **Platform** implements/accepts runtime behavior; merged code alone is not parity evidence.
- **Console** may isolate missing read models in an adapter, but fallbacks are not normative API contracts.
- **TypeScript/Python SDKs** are generated prerelease consumers and must retain immutable contract provenance before supported publication.
- **Java/CLI/mock/MCP** remain Scaffold/Planned until their own implementation/release gates pass.
- **developer-docs** explains use of this contract without copying/forking normative schemas.

## Before merging a contract change

1. Confirm product/runtime ownership and the primary Product Epic/implementation issue.
2. Validate OpenAPI/AsyncAPI syntax and references.
3. Add representative request, response, authorization and error examples.
4. Assess backward compatibility and migration impact.
5. Reconcile affected Platform, Console, SDK, mock/MCP/CLI, developer-docs and website claims.
6. Run the contract compatibility/parity checks required by the current maturity gate.

## Human documentation

Use [`CoreLinkPlatform/developer-docs`](https://github.com/CoreLinkPlatform/developer-docs) for tutorials, concepts, operational guidance and runnable developer journeys. This repository remains the schema/compatibility source of truth.