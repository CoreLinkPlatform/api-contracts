# CoreLink API Contracts Agent Context

This repository is part of the CoreLink product.

## Canonical context

Read the organization source of truth in `CoreLinkPlatform/product-planning`, especially `AGENTS.md`, `PRODUCT_ARCHITECTURE.md`, `GLOSSARY.md`, `STANDARDS.md`, and `architecture/repository-map.yaml`.

## Repository responsibility

`api-contracts` owns normative machine-readable public interface definitions: OpenAPI, AsyncAPI, schemas, compatibility rules, and contract evolution evidence.

## Boundaries

- Contract definitions are normative; implementation convenience must not silently redefine public behavior.
- Do not expose provider-specific models, identifiers, or credentials as CoreLink public domain contracts unless explicitly approved.
- Use canonical terminology and identifiers.
- Breaking changes require explicit compatibility treatment and product-level review.
- Keep implementation details in owning repositories; keep human narrative documentation in `developer-docs`.
