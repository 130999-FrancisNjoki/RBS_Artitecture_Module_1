# Requirements Elicitation Prompt — Meridian Systems

A prompt you can hand to an AI assistant, or run yourself as a stakeholder interview script, to pull complete requirements out of each module and out of the system as a whole before Development starts. Pairs with the earlier **SDLC Build Prompt** and the **Module Workflows Screen-by-Screen Guide** — this doc is what feeds §3 (Requirements Gathering) of that SDLC.

---

## How to use this

- **With an AI assistant:** paste the "Master Prompt" block below, then paste in one module's screen list (from the Screen-by-Screen Guide) at a time. The AI will interview-style draft requirements and flag open questions — treat the output as a first draft to validate with the actual department, not a finished spec.
- **With real stakeholders:** use the module question banks in Part B as an interview script. Bring the relevant Figma lane up on screen while you ask.
- **Either way:** run Part C (System-Wide Requirements) once, separately from any single module — it's cross-cutting and belongs to the whole platform, not one department.
- Output everything into one running document per module (Functional / Non-Functional / Data / Integration / Business Rules / Acceptance Criteria / Open Questions) so it slots directly into an SRS (Software Requirements Specification) later.

---

## Part A — Master Prompt (paste this to an AI assistant)

```
You are helping me build a formal requirements specification for one module of a
multi-department business system (Meridian Systems — custom computer & smart-home
e-commerce, plus internal tooling for Field Technicians, Engineering Supervisors,
Warehouse, Finance, Management, System Administration, and a Customer Portal).

I will give you:
1. The module name and its screen flow (dashboard through personal profile)
2. Any context I already know about how this department works today

Your job:
1. Ask me clarifying questions, one topic at a time, until you have enough to draft
   requirements — don't guess at business rules I haven't confirmed.
2. Once you have enough, produce a draft requirements section with these headings:
   - Functional Requirements (numbered, one testable statement each — "the system shall...")
   - Non-Functional Requirements (performance, usability, availability specific to this module)
   - Data Requirements (what this module reads/writes, and from where)
   - Integration Requirements (other modules or external tools this module must talk to)
   - Business Rules (constraints/logic specific to this department's workflow)
   - Acceptance Criteria (how we'll know a built feature satisfies the requirement)
   - Open Questions (anything you're still unsure about — don't silently assume)
3. Flag anything that conflicts with another module's requirements I've shared with you,
   especially around shared screens (Job Detail, Order Detail, Record Detail).
4. Keep every functional requirement testable and atomic — one behavior per line item,
   not a paragraph of mixed behaviors.

Module: [MODULE NAME]
Screen flow: [PASTE SCREEN LIST]
What I already know: [PASTE ANY CONTEXT]

Start by asking me your first round of clarifying questions.
```

---

## Part B — Per-module question banks

Use these to go deeper than the master prompt alone will, screen by screen.

### Field Technician
- What triggers a job appearing in "My Jobs" — manual assignment, auto-assignment by location/skill, or both?
- Can a technician see jobs they're *not* assigned to (e.g. team-wide visibility) or only their own?
- What's the minimum info required before a job can be marked "Complete" — photo, signature, parts used, all three?
- What happens if a technician can't complete a job (missing part, customer not present)? Is there a "block/pause" state?
- Is offline data entry required, and if so, how does it sync once back online?
- What's logged for time/labor — start/stop timestamps, or a manual entry?

### Engineering Supervisor
- Can a supervisor edit a job's details directly, or only reassign/approve?
- What triggers an escalation (overdue job, technician flags an issue, customer complaint)?
- Is scheduling manual (drag-and-drop) or does it suggest assignments based on technician availability/skill/location?
- What does "reject completion" actually do — reopen the job for the same technician, or reassign it?
- Do supervisors need visibility into technicians outside their own team?

### Warehouse
- Is inventory tracked at the SKU level, the component level (for custom builds), or both?
- When a job is created, does stock get reserved automatically, or does warehouse staff manually reserve it?
- What happens when reserved stock isn't enough to fulfill a job — backorder, substitute part, block the job?
- Is there a physical scanning step (barcode/QR), and what hardware does it need to support?
- How are returns/reconciliation triggered — end of job, end of day, or per-transaction?
- Who gets notified on a low-stock alert, and at what threshold?

### Finance
- What exactly makes an order "ready to bill" — job completion, customer sign-off, or a manual finance review?
- Does the system generate invoices automatically, or does someone in Finance trigger it manually per order?
- What payment methods must be supported (matches storefront: card, PayPal, Apple/Google Pay, financing)?
- How are partial payments, deposits, or installment plans (e.g. Affirm) represented in the record?
- What's the refund approval process — does it need Management sign-off above a dollar threshold?
- What accounting system, if any, does this need to integrate with or export to?
- What tax rules apply (single region, multi-state, international)?

### Management
- Which KPIs are must-have on day one vs. nice-to-have later (revenue, job completion rate, inventory turnover, customer satisfaction)?
- What counts as something requiring executive approval (discount thresholds, refund amounts, staffing changes)?
- Does Management need real-time data, or is a daily/weekly refresh acceptable?
- Who besides Management can see the executive dashboard — is it Management-only, or shared read access with department heads?
- What's the expected drill-down depth — summary → department → individual record, or deeper?

### System Administration
- Who can create/edit roles and permissions — is this restricted to a single super-admin, or delegated?
- Are permissions role-based only, or do individual users ever need one-off overrides?
- What must the audit log capture — every field change, or just key actions (role changes, deletions, logins)?
- How long are audit logs retained, and is that driven by a compliance requirement?
- What's the process for deactivating a user (immediate lockout vs. grace period), and does it differ for terminated employees vs. temporary suspensions?
- Does this module manage integrations/API keys, or is that out of scope?

### Customer Portal
- Can a customer see internal cost/margin data anywhere, even indirectly (e.g. inferred from a discount shown)? Confirm what's explicitly hidden.
- What's the appointment scheduling logic — fixed slots, technician availability pulled live, or manual confirmation?
- What support channels does "Completion/Support" need to expose — ticket form only, live chat, phone number, all three?
- Can customers reorder/duplicate a past configuration exactly, or does pricing/availability need to be re-validated at reorder time?
- What notifications does a customer receive automatically (order status changes, invoice due, appointment reminder), and via what channel (email/SMS/in-app)?

---

## Part C — Full system requirements (cross-cutting, for the SDLC as a whole)

Run this once the module-level requirements above are drafted — this is what turns seven module specs into one coherent system requirements document.

### 1. Functional (system-wide)
- Authentication and session management (login, password reset, session timeout, multi-device)
- Role-based access control model — confirm it's additive/granular permissions, not fixed roles (see System Administration section above)
- Shared-record behavior: exact field-level visibility differences across the three shared screens (Job Detail, Order Detail, Record Detail) per role
- Notification system: what events trigger notifications, to whom, via which channel
- Search/filtering behavior expected across list screens (My Jobs, Team Jobs, Orders for Billing, Users, etc.)

### 2. Non-functional
- **Performance:** acceptable load time per screen type (dashboard vs. detail vs. report); expected concurrent user count at launch and at 12 months
- **Scalability:** expected growth in orders/jobs/users over year one — does the architecture need to handle 10x without a rewrite?
- **Availability:** required uptime; is any downtime acceptable for maintenance, and when (e.g. overnight)?
- **Security:** data encryption at rest/in transit, password policy, session security, PCI compliance if handling card data directly vs. via processor
- **Usability:** device/browser support matrix (especially mobile for Field Technician and Warehouse)
- **Accessibility:** any compliance target (WCAG level) required for the customer-facing portal
- **Auditability:** what must be provably logged for compliance or dispute resolution

### 3. Data
- System of record for each entity (orders, inventory, invoices) — is this system the source of truth, or does it sync from/to an existing tool (accounting software, existing inventory system)?
- Data retention policy per entity type (how long are completed jobs, old invoices, audit logs kept?)
- Backup/recovery expectations (RPO/RTO if you want to get formal about it)

### 4. Integration
- Payment processors (Stripe, PayPal, Affirm, etc.)
- Accounting/ERP software
- Shipping/carrier APIs (for Warehouse)
- Communication channels (email/SMS provider)
- Any existing internal tools that must feed data in or receive data out during a transition period

### 5. Constraints & assumptions
- Budget and timeline ceilings
- Existing tools/systems that must be kept, replaced, or bridged
- Team size/skillset available for development
- Regulatory/compliance obligations specific to your industry or region

### 6. Acceptance criteria (system-level)
- Definition of "launch-ready" for each module (tie back to the Definition of Done pattern from the SDLC prompt)
- Sign-off requirement: which named stakeholder per department must approve their module's requirements before Design begins

### 7. Risks & open questions log
- Running list of anything flagged "Open Questions" across all seven module sections — review this list at the start of every sprint until it's empty

---

## Suggested output format

For each module, save the AI's draft output (or your interview notes) as:
```
/requirements/field-technician.md
/requirements/engineering-supervisor.md
/requirements/warehouse.md
/requirements/finance.md
/requirements/management.md
/requirements/system-administration.md
/requirements/customer-portal.md
/requirements/system-wide.md
```
Each following the same section order (Functional / Non-Functional / Data / Integration / Business Rules / Acceptance Criteria / Open Questions) so they can be merged into one SRS without reformatting later.
