# Phase 4 — Freeze and runtime verification

**Parent:** [ROADMAP_MASTER.md](../ROADMAP_MASTER.md)
**Template:** [PHASE_TEMPLATE.md](./PHASE_TEMPLATE.md)

## Phase metadata

| Field | Value |
|-------|-------|
| Phase status | blocked |
| Owner | TBD |
| Last updated | 2026-04-24 |
| In scope | Kodi runtime verification, freeze gate evidence, and pass/fail decision |
| Out of scope | New feature implementation and broad refactors |

## Objective

Close freeze with reproducible runtime evidence proving list and non-list behavior matches accepted phase baselines.

## Inputs / references

- [Phase 0](./phase-00-historic-implementation-audit.md)
- [Phase 1](./phase-01-contract-and-ia-baseline.md)
- [Phase 2](./phase-02-list-implementation-alignment.md)
- [Phase 3](./phase-03-non-list-surfaces-implementation.md)
- [D-038 ledger](../context/d038-legacy-properties-and-mapping.md)
- [traceability-by-topic.md](../traceability-by-topic.md)

## Runtime evidence scope

| Scope | Required evidence |
|------|-------------------|
| Browse-to-play | Home/Series/Movies flow evidence incl. spotlight and widgets |
| Search-to-play | Search entry, tabs, query flow, result-to-play |
| Info-and-related | Info action behavior, context behavior, details transitions |
| D-015 runtime | `items/page/has_more/next_page`, cap/next/header/full-list behavior |
| Non-list policy | OSD behavior, removals, D-021 effects, D-038 exception behavior |

## Work items

| ID | Work item | Implemented | Verified | Evidence / notes |
|----|-----------|-------------|----------|------------------|
| P4.1 | Validate browse-to-play journey and capture evidence | - [ ] | - [ ] | |
| P4.2 | Validate search-to-play journey and capture evidence | - [ ] | - [ ] | |
| P4.3 | Validate info-and-related journey and capture evidence | - [ ] | - [ ] | |
| P4.4 | Validate D-015 runtime pagination/empty-state behavior | - [ ] | - [ ] | |
| P4.5 | Validate D-003/D-021/D-038 runtime policy conformance | - [ ] | - [ ] | |
| P4.6 | Run full operator checklist and freeze matrix | - [ ] | - [ ] | |
| P4.7 | Record freeze decision with blocker list (if any) | - [ ] | - [ ] | |

## Execution checklist

- [ ] Confirm test environment prerequisites (plugin installed, skin reloaded, logging available)
- [ ] Run journey flows in deterministic order and capture reproducible notes
- [ ] Capture evidence for each failing criterion (not just pass cases)
- [ ] Map each failure to owner phase (2/3/5) with remediation notes
- [ ] Re-run only affected slices after fixes

## Verification checklist

### Contract and list behavior

- [ ] All required contract families resolve at runtime
- [ ] Pagination payload shape is valid at runtime
- [ ] Spotlight remains non-paginated
- [ ] Full-list page size behavior is correct

### UI behavior and policy

- [ ] Home switcher/hubs match accepted policy
- [ ] Details and OSD transitions match target behavior
- [ ] D-021 context removals are effective
- [ ] Declared D-038 exceptions are accurate and no undeclared helper dependency appears

### Freeze readiness

- [ ] No unresolved freeze-critical blocker remains
- [ ] Deferred items are logged with owning phase and next action
- [ ] Freeze decision is explicit (`ready` or `not-ready`)

## Evidence log template

| Area | Result | Evidence link/note | Owner phase if failed |
|------|--------|--------------------|-----------------------|
| Browse-to-play | | | |
| Search-to-play | | | |
| Info-and-related | | | |
| D-015 runtime | | | |
| Non-list policy | | | |

## Blockers / risks

- Phase remains blocked until Kodi runtime evidence exists.
- Static audits can mask runtime focus and navigation failures.
- Weak evidence discipline creates retest loops and ambiguous freeze decisions.

## Exit criteria

- [ ] P4.1-P4.7 complete and evidence-linked
- [ ] Mandatory journey and matrix checks are complete
- [ ] Every failure has owner, remediation, and retest condition
- [ ] Freeze decision is recorded in roadmap status

## Handoff

If freeze is `ready`, update [ROADMAP_MASTER.md](../ROADMAP_MASTER.md) and activate [Phase 5](./phase-05-debt-cleanup-and-policy-closure.md). If freeze is `not-ready`, route issues back to [Phase 2](./phase-02-list-implementation-alignment.md) and/or [Phase 3](./phase-03-non-list-surfaces-implementation.md).
