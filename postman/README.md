# CoreLink Postman Assets

Postman collections, environments and request examples for the versioned
CoreLink public contracts.

## Current status

This directory is a scaffold. No collection or environment file has been added
yet, and the OpenAPI specifications in the parent repository are currently
empty. There is therefore nothing to import or run at this time.

## When adding a collection

- Generate from, or verify against, a reviewed non-empty OpenAPI version.
- Keep public, admin and internal requests separate; never ship internal
  endpoints in a partner collection.
- Use environment variables for base URL, OAuth details and tenant/test IDs;
  do not commit secrets or real access tokens.
- Include successful, validation, authorization and idempotency examples.
- Pin the collection to the compatible contract version and update it whenever
  a public operation changes.
