# P3.1 runtime-parity gate

The `1.0.0-draft` documents establish the target public boundary; they are not
an assertion that the current runtime is already byte-for-byte compatible.
Before a stable SDK release, the platform must close each of these gates.

| Contract decision | Current runtime observation | Required closure |
| --- | --- | --- |
| `corelink_device_id` is the public device field | Device responses currently serialize the persistence attribute `id` | Serialize the canonical public name while retaining the same UUID value; add response compatibility tests. |
| `corelink_device_id` is the command device field | Command responses currently serialize `device_id` | Apply the canonical name at the public boundary and test list/get/create. |
| Provider routing is not a public request concern | Command creation currently requires `provider` | Select a supported connector through CoreLink-owned policy or expose an explicitly versioned neutral selector; never expose provider internals. |
| Problem Details is the error media type | FastAPI defaults currently return `{ "detail": ... }` | Add a correlation-safe exception handler and contract tests for 400/401/403/404/409. |
| `/api/v1` is stable public surface | Runtime routes include administration and internal callbacks under the same prefix | Classify routes and prevent unreviewed routes from entering the public document or generated clients. |

No TypeScript or Python package may be promoted beyond prerelease until these
items, a contract-diff check and generated-client compatibility tests are
green. This gate preserves current consumers while the public boundary is
normalized.
