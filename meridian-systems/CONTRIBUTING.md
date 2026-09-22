# Contributing

## Before you write code

1. Confirm the requirement exists in `docs/requirements/<module>.md`. If it doesn't,
   add it there first (or flag it in the module's Open Questions section) — don't design
   in code review.
2. Confirm which module(s) your change touches, using the mapping table in `README.md`.
3. If your change touches a **shared screen/model** (Job Detail, Order Detail, Record
   Detail), tag the code owners of every module that consumes it, not just your own —
   see `docs/module-workflows-screen-spec.md` for what's shared.

## Opening a PR

- Use a branch name following `docs/branching-strategy.md`.
- Fill out the PR template completely — an empty "Testing" section will get your PR
  sent back.
- Link the requirement ID(s) your change satisfies.
- Keep PRs scoped to one module/feature where possible. A PR that touches five modules
  at once is hard to review and harder to roll back.

## Review & merge

- At least one code owner approval required (see `.github/CODEOWNERS`).
- CI must be green.
- Squash-merge into `develop`. Release branches handle promotion to `main`.

## Definition of done (applies to every PR)

- [ ] Meets the linked requirement's acceptance criteria
- [ ] Unit tests added/updated
- [ ] Role-based access explicitly tested (can users *without* the right permission
      reach this feature?)
- [ ] Empty/loading/error states handled, matching the Master Tuning Checklist in
      `docs/module-workflows-screen-spec.md`
- [ ] No secrets, credentials, or customer data committed
