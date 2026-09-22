# Meridian Systems

Custom computer & smart-home e-commerce platform, plus internal tooling for Field
Technicians, Engineering Supervisors, Warehouse, Finance, Management, System
Administration, and a Customer Portal.

This repo is organized as a **modular monolith**: one codebase, clearly separated
domains, so each department's module can be built and reviewed independently without
needing a microservices split on day one.

## Repository structure

```
meridian-systems/
├── apps/
│   ├── web-storefront/      # Customer-facing site: catalog, smart-home configurator, cart
│   └── web-internal/        # Staff dashboards: Field Tech, Supervisor, Warehouse,
│                             #   Finance, Management, SysAdmin (role-gated views of the
│                             #   same app — see docs/rbac.md)
├── modules/                 # Domain/business logic, framework-agnostic where possible
│   ├── auth-rbac/           # Authentication, roles, granular permissions
│   ├── catalog/             # Products, components, configurations
│   ├── orders/               # Orders, order items, the "Shared Order Detail" model
│   ├── inventory/           # Stock levels, reservations, warehouses/locations
│   ├── jobs/                 # Field jobs/installs, the "Shared Job Detail" model
│   ├── finance/               # Invoices, payments, refunds, reconciliation
│   ├── users-admin/          # User directory, role/permission management, audit log
│   └── notifications/        # Email/SMS/in-app notification dispatch
├── docs/
│   ├── requirements/         # One file per module — see Requirements Elicitation Prompt
│   ├── sdlc-build-prompt.md
│   ├── module-workflows-screen-spec.md
│   └── branching-strategy.md
└── .github/                  # Issue templates, PR template, CI, CODEOWNERS
```

## Where each Figma module lane maps to code

| Figma lane | Primary module(s) | Primary app |
|---|---|---|
| Field Technician | `jobs`, `catalog` | `apps/web-internal` |
| Engineering Supervisor | `jobs`, `users-admin` | `apps/web-internal` |
| Warehouse | `inventory`, `jobs` | `apps/web-internal` |
| Finance | `finance`, `orders` | `apps/web-internal` |
| Management | all (read/report layer) | `apps/web-internal` |
| System Administration | `auth-rbac`, `users-admin` | `apps/web-internal` |
| Customer Portal | `orders`, `catalog`, `finance` (customer-facing subset) | `apps/web-storefront` |

## Getting started

1. Read `docs/branching-strategy.md` before opening your first branch.
2. Pick up requirements for your module from `docs/requirements/<module>.md` (generated
   via the Requirements Elicitation Prompt) before writing code — don't design from a
   blank page.
3. Check `.github/CODEOWNERS` to see who reviews changes to each module.
4. Every PR must pass CI (`.github/workflows/ci.yml`) and get sign-off from the module's
   code owner before merging to `develop`.

## Status

This repo is scaffolding only at this stage — see `docs/sdlc-build-prompt.md` for the
build order (auth → orders → warehouse visibility → finance invoicing → field jobs →
management dashboard → notifications/integrations).
