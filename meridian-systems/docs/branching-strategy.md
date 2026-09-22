# Branching Strategy

Simple trunk-based flow, adapted for multiple modules being built in parallel by
different people/teams.

## Branches

- **`main`** — always production-ready. Protected: no direct pushes, requires PR + passing
  CI + code owner approval.
- **`develop`** — integration branch. Where module branches merge before a release.
  Protected: requires PR + passing CI.
- **`feature/<module>-<short-description>`** — one branch per unit of work.
  Examples:
  - `feature/auth-rbac-permission-matrix`
  - `feature/jobs-complete-job-screen`
  - `feature/finance-invoice-generation`
  - `feature/warehouse-stock-reservation`
- **`release/<version>`** — cut from `develop` when preparing a staged rollout
  (see the SDLC prompt: roll out by department, not all at once).
- **`hotfix/<short-description>`** — cut from `main` for urgent production fixes,
  merged back into both `main` and `develop`.

## Naming convention for module prefixes

Use these prefixes consistently in branch names, commit messages, and PR titles so
history stays searchable by module:

| Prefix | Module |
|---|---|
| `auth-` | auth-rbac |
| `catalog-` | catalog |
| `orders-` | orders |
| `inventory-` | inventory |
| `jobs-` | jobs |
| `finance-` | finance |
| `admin-` | users-admin |
| `notify-` | notifications |
| `storefront-` | apps/web-storefront (UI-only changes) |
| `internal-` | apps/web-internal (UI-only changes) |

## Workflow

1. Branch from `develop`: `git checkout -b feature/jobs-complete-job-screen develop`
2. Commit in small, atomic steps. Reference the requirements doc line item if applicable,
   e.g. `jobs: implement completion checklist (REQ-FT-014)`
3. Open a PR into `develop` using the PR template. Tag the module's code owner as reviewer.
4. CI must pass (lint, unit tests, integration tests — see `ci.yml`).
5. Squash-merge into `develop` once approved.
6. Periodically cut a `release/x.x` branch from `develop`, deploy to staging, get UAT
   sign-off from the relevant department (per the SDLC prompt's staged rollout), then
   merge to `main` and tag the release.

## Commit message convention

```
<module>: <short imperative description> [<requirement-id if applicable>]

Examples:
  finance: add refund approval threshold check (REQ-FIN-009)
  jobs: fix offline sync losing completion photos
  admin: add granular permission editor UI
```
