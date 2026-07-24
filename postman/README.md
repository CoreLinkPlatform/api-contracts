# CoreLink Postman Assets

Postman collections, environments and request examples for the versioned
CoreLink public contracts.

## Use in the developer sandbox

Import `corelink-public-v1.postman_collection.json` and
`corelink-public-v1.postman_environment.json`, then set `tenant_id`,
`corelink_device_id` and an access token obtained through the supported CoreLink
authentication flow. The collection contains readiness, successful device,
validation/authentication and idempotent command examples for the resettable
sandbox tenant; it never needs a vendor identifier or direct integration access.

The collection is pinned to the reviewed `1.0.0-draft` contract. It remains a
prerelease reference until the public runtime and sandbox are released together.

## When adding a collection

- Generate from, or verify against, a reviewed non-empty OpenAPI version.
- Keep public, admin and internal requests separate; never ship internal
  endpoints in a partner collection.
- Use environment variables for base URL, OAuth details and tenant/test IDs;
  do not commit secrets or real access tokens.
- Include successful, validation, authorization and idempotency examples.
- Pin the collection to the compatible contract version and update it whenever
  a public operation changes.
