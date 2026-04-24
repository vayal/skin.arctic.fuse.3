# Phase 3 — PVR gating & product policy

**Parent:** [ROADMAP_MASTER.md](../ROADMAP_MASTER.md)

**Template:** [PHASE_TEMPLATE.md](./PHASE_TEMPLATE.md)

## Phase metadata

| Field | Value |
|-------|-------|
| Phase status | planned |
| Owner | TBD |
| Last updated | 2026-04-24 |
| In scope | See objective + work items |
| Out of scope | Anything not listed in work items |

Single **product + skin** thread: Live TV / hub **1107** visibility and routing today depend on `System.HasPVRAddon` + `PVR.HasTVChannels` in **`Includes_Home.xml`** (multiple occurrences). Decide policy, then align XML + docs + optional target row.

---

## Objective

Choose one path and implement it consistently:

1. **Keep** — PVR users see Live TV when addon + channels exist (document in [skin vision v1](./skin-vision-blueprint-v1.md) / non-list hub as intentional).  
2. **Velocity-only** — Remove or replace gating so behavior does not depend on Kodi PVR state (may hide Live TV for PVR users).  
3. **Hybrid** — Hide by default but allow explicit opt-in (document toggles).

---

## References

| Document | Role |
|----------|------|
| [Includes_Home.xml](../../1080i/Includes_Home.xml) | Actual gating (source of truth) |
| [d003 matrix](./d003-view-mode-matrix.md) | Hub IDs incl. 1107 |
| [surface-inventory-home-hubs](./surface-inventory-home-hubs.md) | As-built hub notes |
| [kodi UI matrix §B.2](./phase-01-freeze-and-runtime-verification.md#b2-top-bar-main-switcher--kodi-checks) | QA expectations for Live TV row |

---

## Work items

| ID | Work item | Implemented | Verified | Notes |
|----|-----------|-------------|----------|-------|
| P3.1 | Record **product decision** (keep / Velocity-only / hybrid) in [nonlist hub](./nonlist-surfaces-index.md) or blueprint v1 | - [ ] | - [ ] | |
| P3.2 | Align `Includes_Home.xml` (and any related controls) with decision | - [ ] | - [ ] | |
| P3.3 | Update Phase 1 matrix rows if Live TV behavior changes | - [ ] | - [ ] | [phase-01](./phase-01-freeze-and-runtime-verification.md) |
| P3.4 | Kodi verify: with/without PVR addon, with/without channels | - [ ] | - [ ] | |

---

## Exit criteria

- [ ] P3.1–P3.4 complete and **Verified** under chosen policy
- [ ] [ROADMAP_MASTER](../ROADMAP_MASTER.md) Phase 3 row updated
