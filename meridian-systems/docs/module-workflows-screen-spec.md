# Module Workflows — Screen-by-Screen Structuring Guide

Companion doc to the "Module Workflows — RBAC/MVC" Figma page. Use it to move slide-by-slide through each lane, dashboard through personal profile, and tune each screen against the same checklist so nothing gets designed to a different standard than the rest.

---

## How to use this

1. Every module below ends the same way you asked: **Dashboard → … → Personal Profile.** Personal Profile is added consistently across all seven modules so every user, regardless of role, lands on a familiar pattern for their own account.
2. Each screen has a starter row (Purpose / Key Elements / Primary Actions) — a first pass so you're not staring at a blank slide. Treat it as a draft, not a spec; overwrite freely as you review each slide in Figma.
3. Use the **Master Tuning Checklist** (below) on every single screen before calling it "reviewed." Add a checklist frame/sticky note per slide in Figma if that's easier to track than a doc.
4. Three screens are marked **Shared** — they appear in more than one module's lane. Design these once, with role-conditional sections/visibility states, rather than as separate screens per module. Flag this explicitly in Figma (e.g. a "Shared Component" tag) so nobody duplicates the work.

---

## Master Tuning Checklist (apply to every screen)

- [ ] **Data completeness** — every field/widget shown has a real data source; nothing is a placeholder that will surprise engineering later
- [ ] **Empty state** — what does this screen look like with zero jobs/orders/items?
- [ ] **Loading state** — skeleton, spinner, or nothing?
- [ ] **Error state** — failed fetch, permission denied, stale data
- [ ] **Role/permission edge cases** — what does this exact screen look like for a role with *partial* access (e.g. a Field Technician viewing a job they're not assigned to, if that's even reachable)?
- [ ] **Responsive behavior** — does this screen need to work on a phone (Field Technician, Warehouse floor) vs. desktop (Finance, Management)?
- [ ] **Primary action is unambiguous** — one clear next step, not three competing CTAs
- [ ] **Copy/microcopy** — button labels, empty-state text, confirmation messages drafted, not "Lorem ipsum"
- [ ] **Handoff note** — anything engineering needs to know that isn't visible in the static frame (e.g. "this list paginates after 20 rows")

---

## 1. Field Technician

| # | Screen | Purpose (starter) | Key elements (starter) | Primary actions |
|---|---|---|---|---|
| 1 | Dashboard | Orient the technician to today's work at a glance | Today's assigned jobs count, next job up, urgent/overdue flags, quick stats (jobs completed this week) | Jump to "My Jobs" |
| 2 | My Jobs | List/queue of all assigned jobs | Job list with status, priority, location, scheduled time; filter/sort by status or date | Open a job |
| 3 | **Shared: Job Detail** | Single source of truth for one job | Customer info, configuration summary, job status, notes/history, assigned engineer | Update status, add note |
| 4 | Configuration & Materials | What to install and what's needed to do it | Build/config spec from the customer's order, parts checklist, quantities, special instructions | Confirm materials on hand, flag shortage |
| 5 | Complete Job | Close out the job | Completion checklist, photo upload, customer sign-off, time logged | Submit completion |
| 6 | Personal Profile | Own account | Name/contact, role badge, notification preferences, job history/stats | Edit profile, log out |

**Tuning flags to think about:** offline behavior if signal drops mid-job; whether "Complete Job" can be partially saved and resumed.

---

## 2. Engineering Supervisor

| # | Screen | Purpose (starter) | Key elements (starter) | Primary actions |
|---|---|---|---|---|
| 1 | Dashboard | Team-wide status at a glance | Team workload summary, jobs at risk (overdue/unassigned), completion rate | Jump to Team Jobs |
| 2 | Team Jobs | All jobs across the team | Job list with assignee, status, priority; filter by technician or status | Select a job |
| 3 | **Shared: Job Detail** | Same detail view as Field Technician, with supervisor-level actions surfaced | Same core fields, plus reassignment control, approval controls | Reassign, escalate |
| 4 | Assign & Schedule | Distribute work across the team | Technician availability/calendar, drag-and-drop or select-to-assign, workload balance indicator | Assign job, set schedule |
| 5 | Review/Approve Completion | Quality gate before a job counts as done | Submitted completion details, photos, technician notes, approve/reject control | Approve, send back for rework |
| 6 | Personal Profile | Own account | Same pattern as above, plus team-management preferences | Edit profile, log out |

**Tuning flags:** what happens visually when a job is rejected back to the technician — does it reappear in "My Jobs" with a flag?

---

## 3. Warehouse

| # | Screen | Purpose (starter) | Key elements (starter) | Primary actions |
|---|---|---|---|---|
| 1 | Dashboard | Warehouse status at a glance | Low-stock alerts, pending pick lists, today's shipments/returns | Jump to Job Requirements |
| 2 | Job Requirements | What upcoming jobs need pulled | List of jobs/orders needing materials, required parts per job, due dates | Reserve stock for a job |
| 3 | Inventory/Reservation | Live stock view and holds | Stock levels by SKU/location, reserved vs. available quantity, reorder threshold indicator | Adjust reservation, flag shortage |
| 4 | Stock Issue | Physically releasing parts | Pick list, scan/confirm items issued, quantity confirmation | Confirm issue, print pick slip |
| 5 | Return/Reconciliation | Unused/returned materials and stock counts | Returned items list, reason codes, adjustment to on-hand quantity | Log return, reconcile count |
| 6 | Personal Profile | Own account | Same pattern | Edit profile, log out |

**Tuning flags:** barcode/QR scan flow — is that a camera view within this screen, or a separate handheld device experience this Figma page doesn't need to cover?

---

## 4. Finance

| # | Screen | Purpose (starter) | Key elements (starter) | Primary actions |
|---|---|---|---|---|
| 1 | Dashboard | Financial health at a glance | Outstanding invoices, revenue this period, overdue payments count | Jump to Orders for Billing |
| 2 | Orders for Billing | Orders ready to invoice | List of completed/billable orders, filter by status (unbilled/partially billed/billed) | Select an order to bill |
| 3 | **Shared: Order Detail** | Full order record | Line items, configuration summary, customer info, linked job status, payment history | Generate invoice |
| 4 | Invoice & Payment | Create and track payment | Invoice line items/totals/tax, payment method, payment status, send/download invoice | Send invoice, record payment, issue refund |
| 5 | Reconciliation/Reports | Period-end financial view | Revenue by period/product line, outstanding balances, exportable report | Export report, mark period reconciled |
| 6 | Personal Profile | Own account | Same pattern | Edit profile, log out |

**Tuning flags:** does this need to integrate visually with an existing accounting tool's export format, or is it the system of record itself?

---

## 5. Management

| # | Screen | Purpose (starter) | Key elements (starter) | Primary actions |
|---|---|---|---|---|
| 1 | Executive Dashboard | Cross-department KPIs at a glance | Revenue, order volume, job completion rate, inventory turnover — one summary tile per department | Drill into a department |
| 2 | Operations Drill-down | Department-level detail | Whichever department was selected — jobs, orders, or inventory detail filtered to that view | Select a specific record |
| 3 | **Shared: Record Detail** | Deep-dive into a single order/job/inventory item, sourced from whichever department it came from | Same underlying data as the department's own detail screen, presented read-mostly for oversight | Approve/flag, add executive note |
| 4 | Department Performance | Trend view per department | Time-series charts, comparison to targets, staffing/workload indicators | Change date range, export view |
| 5 | Reports/Decisions | Where approvals and decisions live | Pending approvals queue (large discounts, refunds over threshold, etc.), decision history | Approve, deny, delegate |
| 6 | Personal Profile | Own account | Same pattern | Edit profile, log out |

**Tuning flags:** since "Record Detail" is reused from three other modules' detail screens, decide now which fields are read-only for Management vs. editable — this will shape the shared component's design.

---

## 6. System Administration

| # | Screen | Purpose (starter) | Key elements (starter) | Primary actions |
|---|---|---|---|---|
| 1 | Dashboard | System health/activity at a glance | Active users, recent logins, pending access requests, system alerts | Jump to Users |
| 2 | Users | Full user directory | User list with role, status (active/suspended), last login | Select a user, invite new user |
| 3 | User Access | Per-user access detail | This user's role(s), department, specific granted permissions, account status | Suspend/activate, change role |
| 4 | Roles & Permissions | Define what each role can do | Role list, permission matrix (granular: e.g. `orders:view`, `inventory:adjust`) | Create role, edit permission set |
| 5 | Audit/Settings | Accountability and system config | Audit log (who changed what, when), global settings (branding, notification defaults, integrations) | Filter audit log, update setting |
| 6 | Personal Profile | Own account | Same pattern, likely with elevated security options (2FA, session management) | Edit profile, log out |

**Tuning flags:** this is the module where the granular-permissions model from the earlier build prompt actually gets a UI — make sure "Roles & Permissions" can represent additive permissions, not just five fixed role toggles.

---

## 7. Customer Portal

| # | Screen | Purpose (starter) | Key elements (starter) | Primary actions |
|---|---|---|---|---|
| 1 | Dashboard | Customer's home base | Active order(s) status, upcoming appointment, quick links to configure new products | Jump to Configurations |
| 2 | Configurations | Saved/past product builds | List of saved smart-home/PC configurations, ability to reorder or duplicate a past config | Start new config, edit saved config |
| 3 | **Shared: Order Detail** | Same underlying order record as Finance's view, customer-facing subset | Order line items, status, delivery/install timeline — no internal cost/margin data | Track order, contact support |
| 4 | Invoice/Appointment | Customer-facing billing and scheduling | Invoice/payment status, install appointment date/time, reschedule option | Pay invoice, reschedule appointment |
| 5 | Completion/Support | Post-delivery experience | Job/install completion confirmation, warranty info, support ticket entry point | Open support ticket, leave feedback |
| 6 | Personal Profile | Own account | Contact info, saved payment methods, notification preferences | Edit profile, log out |

**Tuning flags:** confirm exactly which fields from the shared "Order Detail" get hidden for the customer view (cost basis, internal notes, assigned technician's personal info) — this is a security review item, not just a design one.

---

## Shared screens summary (design once, apply role-conditional views)

| Shared screen | Used by | What changes per role |
|---|---|---|
| Job Detail | Field Technician, Engineering Supervisor | Supervisor sees reassignment/approval controls; Technician sees update/complete controls |
| Order Detail | Finance, Customer Portal | Finance sees cost/margin/payment internals; Customer sees status/timeline only |
| Record Detail | Management | Read-mostly wrapper around whichever of the above the record actually is |

---

## Suggested Figma organization

- Keep this page (**Module Workflows — RBAC/MVC**) exactly as you have it — one lane per module.
- Add a small **"Shared Component"** tag/label on the three shared screens in each lane so reviewers immediately know changes there affect other lanes.
- Consider a lightweight status label per slide (Draft / In Review / Tuned / Approved) so progress through the Master Tuning Checklist is visible at a glance without leaving Figma.
