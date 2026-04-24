# Phase 07 - Stabilization and Freeze

> **Note (2026-04-24):** This is the **active** roadmap gate. Supporting triage: [master triage](../gap-analysis/master-triage-list.md).

## Validation status and blockers

**Freeze-ready:** No — **no Kodi runtime evidence** yet for mandatory journeys or D-015 paging in this environment.

**Where to work next**

- Operator QA: [kodi-complete-testing guide](../../reference/kodi-complete-testing-guide.md), [kodi-ui-verification-matrix.md](./kodi-ui-verification-matrix.md)
- Code/property backlog: [master triage](../gap-analysis/master-triage-list.md), [D-038](../../reference/d038-legacy-property-ledger.md)
- Contracts: [screen-by-screen-build-contract.md](../../target/screen-by-screen-build-contract.md), [D-015](../../target/d015-addon-required-lists-contract.md)

### P1 blockers (close before marking Phase 07 completed)

| Blocker | What to capture |
|--------|------------------|
| Browse / hub / provider / OSD | Evidence per [browse-to-play](../../inventory/journeys/browse-to-play.md) + matrix §2–§5 |
| Search-to-play, info-and-related | [search-to-play](../../inventory/journeys/search-to-play.md), [info-and-related](../../inventory/journeys/info-and-related.md) |
| D-015 at runtime | `items` / `page` / `has_more` / `next_page`; in-row cap vs full list; empty state copy ([D-015](../../target/d015-addon-required-lists-contract.md), build contract §1) |

### Static notes (sanity only, not freeze proof)

- **Includes_Hubs.xml:** Velocity `list_id` + `page=1` spotlight wiring; no `TMDbHelper` in this file (repo grep).
- **Search / discover:** `Includes_Search.xml` still uses helper-named **property key** for discover folder path — documented **keep-temporary** in D-038 §4.
- **Residual helper symbols:** still present in multiple includes (images, overlay, dialog info, OSD, etc.) — tracked in D-038 + master triage; not the same as “undeclared” if ledger-complete.
- **PVR gating:** `Includes_Home.xml` — `System.HasPVRAddon` + `PVR.HasTVChannels` for Live TV / 1107 (product decision: keep vs Velocity-only).

### Checklists

Use [appendix-verification-checklists.md](./appendix-verification-checklists.md) as the live operator list. After evidence exists, update [README.md](./README.md) Phase 07 row to **completed**.

---

## Scope

Run end-to-end validation, reconcile traceability, and enforce final freeze gate.

## Inputs and Prerequisite Checks

- [Skin Vision Blueprint](../../archive/skin-vision-blueprint-v0.md)
- [Screen-by-Screen Build Contract](../../target/screen-by-screen-build-contract.md)
- [D-015 Addon Required Lists Contract](../../target/d015-addon-required-lists-contract.md)
- [D-038 Legacy Property Ledger](../../reference/d038-legacy-property-ledger.md)
- [Verification Checklists Appendix](./appendix-verification-checklists.md)
- [Traceability Matrix Appendix](./appendix-traceability-matrix.md)
- [Inventory Journeys](../../inventory/journeys/README.md)

Checks:

- Phases **01–06** are treated as **closed in tree**; their markdown playbooks were **deleted** (2026-04-24) — use git history if you need the old step lists.
- [ ] No unresolved blockers carried into Phase 07 (see **Validation status and blockers** above)

## File-Level Touch List

- docs:
  - `doc/next/roadmap/appendix-traceability-matrix.md`
  - `doc/next/roadmap/appendix-verification-checklists.md` (if needed for final evidence links)
  - optional final status note in `doc/skin-vision-blueprint-v0.md` if freeze marker is desired

## Step-by-Step Execution Tasks

1. Validate primary UX flows end-to-end:
   - Home, Series, Movies hubs
   - provider mini-hubs
   - details, OSD, search
2. Validate pagination behavior:
   - in-row cap behavior
   - header/full-list navigation
   - full-list 40/page semantics
3. Validate context menu and removed surfaces policies:
   - D-021 policy enforced
   - removed PVR/weather/context extras not reachable
4. Validate metadata rendering:
   - image-only row cards
   - spotlight fields
   - pause strip behavior
5. Validate contract integrity:
   - D-015 schema assumptions are met by runtime behavior
6. Reconcile D-038 ledger with implementation status.
7. Update traceability appendix with final mapping and evidence pointers.
8. Execute freeze checklist and mark package ready.

## Validation Checklist (Runtime + Static)

- [ ] journey tests pass for browse-to-play, search-to-play, info-and-related
- [ ] no active helper dependency in approved migrated surfaces
- [ ] documented temporary exceptions only
- [ ] roadmap files and appendices internally consistent

## Acceptance Criteria (Pass/Fail)

- [ ] all phase acceptance gates passed
- [ ] traceability complete for D-003, D-015, D-021, D-038
- [ ] freeze checklist complete with no unresolved P0/P1 blockers

## Abort / Rollback Guidance

- If freeze checks fail:
  - do not mark freeze-ready
  - open targeted remediation item against failing phase
  - rerun only affected validation slices

## Common Failure Modes and Detection

- **Failure:** policy drift between docs and runtime behavior  
  **Detect:** cross-check route/action outcomes against screen-by-screen contract.
- **Failure:** undocumented exception remains  
  **Detect:** compare residual helper reference scan against D-038 ledger entries.

## If Blocked, Stop and Report

Report:

1. failed acceptance criterion
2. failing surface and repro
3. upstream phase owning remediation

## Handoff / Closure

When accepted, this roadmap package becomes execution-complete and freeze-ready.

