# Master Build Prompt — Meridian Systems Platform

Use this as a standing brief. Paste it (in full or by phase) into an AI assistant, hand it to a dev team, or use it yourself to keep the project anchored as requirements grow. It's written so it still makes sense after six months of changes — update the **Current State** block at the top each time scope shifts, and leave the rest as the constitution of the project.

---

## How to use this prompt

- Treat the **SDLC phases** below as a loop, not a straight line. Every new department request or feature re-enters at Requirements, not at Development.
- Before asking for new work, paste the **Current State** section so the assistant/team isn't designing from a blank page.
- Each phase ends with a **"Definition of done"** — don't move to the next phase until those boxes are genuinely checked, even under deadline pressure.

---

## Current State (update this before every new work session)

```
Product: Meridian Systems — custom computer & smart-home e-commerce platform
Stage: [e.g. "public site + smart-home configurator live; no backend/auth yet"]
Live components: [list — e.g. marketing site, smart-home builder, cart UI (front-end only)]
In progress: [list]
Not started: [list]
Known constraints: [budget, timeline, team size, existing tools/ERP/CRM in use]
```

---

## 1. Project charter (fill in once, revisit quarterly)

**Business goal:** Sell custom computer builds and smart-home devices online, while giving internal teams (Field Engineers, Finance, Warehouse, Management) one shared system of record instead of separate spreadsheets/tools.

**Primary users and what "success" looks like for each:**

| Role | What they need from the system | What failure looks like today |
|---|---|---|
| Customers | Browse, configure, order, track | (baseline — already partly built) |
| Field Engineers | See assigned jobs/installs, update job status, log parts used, access build specs on-site (often mobile, sometimes offline) | Paper job sheets, no visibility into what customer ordered |
| Finance | Invoicing, payment status, refunds, revenue reporting, tax handling | Manual reconciliation between Shopify-style exports and accounting software |
| Warehouse | Real-time stock levels, pick lists, low-stock alerts, receiving, shipping labels | Overselling out-of-stock items, no single inventory source of truth |
| Management | Cross-department dashboards, approvals, staff/user administration, forecasting | No single view; reports assembled by hand from each department |

**Non-negotiables:**
- Role-based access — a Field Engineer must never see Finance data, and vice versa, unless explicitly granted.
- The system must be extensible: new product lines, roles, or workflows should be addable without rearchitecting.
- Every order/job must be traceable end-to-end: quote → order → build/install → invoice → after-sale service.

---

## 2. SDLC methodology to follow

Use an **iterative (Agile-influenced) SDLC** — not pure waterfall — because requirements will keep expanding as departments start using the system and discover new needs. Structure:

1. **Requirements & discovery** (per feature/epic, not just once at the start)
2. **Design** (data model + UX + API contract, reviewed before code)
3. **Development** (small, shippable increments — e.g. "warehouse can view stock" before "warehouse can auto-reorder")
4. **Testing** (unit, integration, and role-based access testing — see §6)
5. **Deployment** (staged: internal/staff rollout before customer-facing changes go live)
6. **Maintenance & feedback loop** (structured intake from each department, not ad hoc Slack messages)

Run phases 1–4 as short cycles (2–4 weeks) per feature area, rather than trying to design the whole platform before building anything.

---

## 3. Requirements gathering — ask these questions per department before designing anything

**Field Engineers**
- Will they use a phone, tablet, or laptop in the field? Is offline access required (e.g. spotty signal at install sites)?
- Do they need to update job status themselves, or just view assignments?
- Do they need access to the customer's original configurator selections (so they know exactly what was ordered)?
- Do they log time, parts consumed, or photos of completed work?

**Finance**
- What accounting software do they already use (QuickBooks, Xero, NetSuite, etc.)? Does this need to integrate/export, or be the system of record itself?
- What payment processors are in use (Stripe, PayPal, Affirm — matches the footer badges already on the site)?
- Do they need automated invoice generation, tax calculation by region, or refund workflows?
- What reports do they run monthly/quarterly today, and in what format?

**Warehouse**
- Is inventory tracked by SKU, by component (for custom builds), or both?
- Do custom PC builds consume from a shared parts inventory that needs to decrement per order?
- Barcode/QR scanning needed? Any existing warehouse hardware to integrate with?
- How are shipping labels currently generated (manual, carrier API, third-party like ShipStation)?

**Management**
- What KPIs matter most (revenue, order volume, build turnaround time, inventory turnover)?
- Do they need to approve anything before it happens (large discounts, custom quotes, refunds over a threshold)?
- Who administers user accounts and role permissions — IT, management, or both?

**Definition of done for this phase:** every question above has a documented answer, and each department has confirmed (in writing) that the summary of their workflow is accurate.

---

## 4. System design

**4.1 Roles and permissions model**
Design role-based access control (RBAC) from day one, even if only two roles exist at launch:
```
Customer        → storefront, own orders/account only
Field Engineer  → assigned jobs, build specs, job status updates, parts logging
Warehouse       → inventory, stock adjustments, pick/pack/ship
Finance         → invoices, payments, refunds, financial reports
Management      → cross-department dashboards, user administration, approvals, all reports
```
Keep permissions additive and granular (e.g. `orders:view`, `orders:refund`, `inventory:adjust`) rather than hardcoding five fixed roles — this is what makes the system extensible as new departments or sub-roles appear.

**4.2 Core data model (starting point — expand as needed)**
- `customers`, `orders`, `order_items`, `configurations` (captures smart-home/PC builder selections)
- `products`, `components`, `inventory_levels`, `warehouses/locations`
- `jobs` (field installs/service — linked to `orders`, assigned to `field_engineers`)
- `invoices`, `payments`, `refunds` (linked to `orders`)
- `users`, `roles`, `permissions`
- `audit_log` (who changed what, when — critical once multiple departments touch the same order)

**4.3 Architecture direction**
- Decide early: monolith-with-modules vs. microservices. For a team this size, a **modular monolith** (single codebase, clearly separated domains: catalog, orders, inventory, jobs, finance) is usually the right call — it's easier to maintain and still lets you split services out later if one area (e.g. inventory) needs to scale independently.
- Expose an internal API layer between front-end and business logic even if there's only one front-end today — this is what lets you add a Field Engineer mobile app or a Warehouse handheld-scanner app later without rebuilding the backend.
- The existing storefront/configurator becomes the **customer-facing client**; plan for a separate **internal dashboard client** (could be a different set of routes/views in the same app, gated by role) for staff.

**Definition of done:** a reviewed ER diagram, a role/permission matrix, and a one-page architecture diagram exist before any backend code is written.

---

## 5. Development approach

Build in this order so each increment is independently useful:
1. Auth + roles (nobody can build real features safely without this)
2. Order/configuration persistence (save what the storefront already collects)
3. Warehouse: inventory visibility (read-only dashboard first, adjustments second)
4. Finance: invoice generation tied to orders
5. Field Engineer: job assignment + status updates
6. Management: cross-department dashboard (this naturally comes last — it reads from everything above)
7. Notifications/integrations (email, SMS, accounting export, shipping carriers) — layer in once the core loop works

Each increment should be demoable to the relevant department before moving to the next.

---

## 6. Testing

- **Unit tests** for business logic (pricing, inventory decrement, permission checks).
- **Integration tests** for cross-department flows (an order placed → appears in warehouse pick list → generates a finance invoice → creates a field job if installation is required).
- **Role-based access testing** — explicitly test that each role *cannot* see/do what it shouldn't, not just that it can do what it should.
- **User acceptance testing (UAT)** with one real person from each department before wider rollout — they will find gaps a spec never anticipated.

---

## 7. Deployment

- Stand up a staging environment that mirrors production; roll out internal-facing features (warehouse, finance, field engineer tools) there first since mistakes there don't touch customers.
- Roll out by department, not all at once — e.g. Warehouse goes live on the new system while Finance still uses their current process for a sprint, so failures are isolated and reversible.
- Keep a rollback plan for each release.

---

## 8. Maintenance & growth loop

- Set up a lightweight, structured intake for feature requests per department (a form or ticket type per department is enough) instead of ad hoc requests — this is what keeps the "expanding requirements" from turning into scope chaos.
- Revisit the **Current State** block at the top of this document every sprint.
- Re-run the relevant part of §3 (Requirements) whenever a department asks for something outside its original scope, rather than bolting it directly onto Development.

---

## Quick-start version (if you want a shorter prompt to hand to an AI assistant right now)

> Build a modular, role-based internal system on top of the existing Meridian Systems storefront and smart-home configurator. Users include Customers, Field Engineers, Finance, Warehouse, and Management, each with distinct permissions (define granular permissions, not just five fixed roles). Start with authentication and an order/configuration data model, then add read-only dashboards per department before adding write actions (inventory adjustments, invoice generation, job status updates). Design the data model and API layer so new roles, product lines, or departments can be added later without a rewrite. Follow an iterative SDLC: gather that department's requirements, design its data/permissions, build the smallest useful increment, test role-based access explicitly, then deploy to that department alone before moving to the next.
