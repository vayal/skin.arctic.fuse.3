# Phase 0 — Historic implementation audit

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

## Objective

Legacy roadmap phases **01–06** were marked complete and their markdown playbooks **removed** (2026-04). Phase **0** re-establishes **evidence-backed confidence** that the repo today still matches those claims: decisions (D-003, D-015, D-021, D-038), inventories, and touch files — **without** repeating full implementation work.

This phase does **not** add product scope. It produces a signed audit trail (checkboxes + optional notes in this file or linked status notes).

---

## References (read first)

| Kind | Document |
|------|----------|
| Current product intent | [skin vision blueprint v1](./skin-vision-blueprint-v1.md) |
| List target / status | [LIST_CONTRACTS_TARGET](./LIST_CONTRACTS_TARGET.md) · [LIST_IMPLEMENTATION_STATUS](./LIST_IMPLEMENTATION_STATUS.md) |
| Non-list | [nonlist-surfaces-index](./nonlist-surfaces-index.md) |
| Legacy narrative (partially outdated) | [skin vision blueprint v0](../archive/skin-vision-blueprint-v0.md) |
| Ledger | [D-038](../context/d038-legacy-properties-and-mapping.md) |
| Topic index | [traceability-by-topic.md](../traceability-by-topic.md) |
| Kodi engine (generic) | [kodi/00_README.md](../kodi/00_README.md) |

---

## Decision → legacy phase mapping (audit map)

| Decision | Scope | Legacy phase(s) | Primary references |
|----------|--------|-----------------|---------------------|
| D-003 | View mode locking per surface | 01, 05, 07* | [d003-view-mode-matrix](./d003-view-mode-matrix.md), [nonlist hub](./nonlist-surfaces-index.md) |
| D-015 | List contract families | 01, 02, 03, 07* | [LIST_CONTRACTS_TARGET](./LIST_CONTRACTS_TARGET.md), [LIST_IMPLEMENTATION_STATUS](./LIST_IMPLEMENTATION_STATUS.md) |
| D-021 | Context menu policy | 01, 04, 07* | [nonlist details/OSD target](./nonlist-details-osd-context-target.md), [D-038](../context/d038-legacy-properties-and-mapping.md) |
| D-038 | Legacy property migration | 01, 03, 04, 05, 06, 07* | [D-038](../context/d038-legacy-properties-and-mapping.md) |

\*Legacy “07” verification is executed in [phase-01](./phase-01-freeze-and-runtime-verification.md); this table is for **mapping** only.

---

## D-038 batch → legacy phase → primary touch files

| D-038 batch | Intent | Legacy phase | Primary touch files (verify still consistent) |
|-------------|--------|--------------|--------------------------------------------------|
| A | remove-first approved surfaces | 04 | `Dialog_DialogContextMenu.xml`, `Custom_1141_OSD_Cast.xml`, `Dialog_DialogPVRInfo.xml`, `DialogPVR*`, `Settings.xml`, `Includes_SkinSettings.xml`, `script-wikipedia.xml`, `Custom_1120_Dialog_SelectCrew.xml`, `Custom_1118_Dialog_Settings.xml`, `Custom_1113_Dialog_Plot.xml` |
| B | control-plane replacement | 03 | `Includes_Paths.xml`, `Includes_Actions.xml`, `Includes_DialogInfo.xml`, `DialogVideoInfo.xml`, `Dialog_DialogPlot.xml`, `Custom_1114_Dialog_CustomPlot.xml`, `Custom_1193_VideoOSDInfo.xml`, `Includes_Search.xml`, `Custom_1105_Search.xml` |
| B.1 | fork default IA bootstrap | 03 | `shortcuts/skinvariables-startup.json`, `1080i/Home.xml`, `1080i/Includes_Home.xml`, `1080i/Includes_Hubs.xml` |
| C | metadata/rendering replacement | 05 | `Includes_Images.xml`, `Includes_Labels.xml`, `Includes_Info.xml`, `Includes_Overlay.xml`, `Includes_Views*`, `Includes_Widgets.xml`, `Includes_Lists.xml`, `Home.xml`, `Includes_Home.xml`, trailer/view/options/favourites/infooption dialogs |
| D | deferred exceptions cleanup | 06 | `Custom_1105_Search.xml`, `Dialog_DialogWeather.xml`, `Includes_Weather.xml`, `Custom_1180_Dialog_Bumper.xml` (scope per D-038) |

---

## Inventories ↔ legacy phase (spot-check targets)

| Inventory | Use | Legacy phase(s) |
|-----------|-----|-----------------|
| [surface-inventory-home-hubs](./surface-inventory-home-hubs.md) | Hub rows, modes | 03, 05, 07* |
| [surface-inventory-search-discovery](./surface-inventory-search-discovery.md) | Search/discover | 02, 03, 07* |
| [surface-inventory-dialogs-info-context](./surface-inventory-dialogs-info-context.md) | Details/context | 04, 05, 07* |
| [surface-inventory-osd-playback](./surface-inventory-osd-playback.md) | OSD / playback | 03, 04, 07* |
| [surface-inventory-actions-paths-background](./surface-inventory-actions-paths-background.md) | Actions/paths | 03, 05, 06 |

---

## Phase 02 addon evidence (fixtures)

Phase **02** on the addon side used sample contract-family payloads. Skin-repo pointer (path may differ on your machine):

- Addon fixture source (external): `plugin.video.velocity2` repo `plans/phase02-fixtures/contract-family-fixtures.json`
- Families covered: Home (`home_spotlight_mixed`, `home_in_progress_*`), Series/Movies hub contracts, `provider_{provider_id}_{media}_*`, `genre_global_{genre}`, search (`search_movies`, `search_tvshows`) with `query`, `media_type`, `page`, `sort`
- Pagination: first page includes `items/page/has_more/next_page`; terminal page omits `next_page`; spotlights non-paginated

**Audit:** | Implemented (fixtures still valid) | Verified (re-run against addon) |
|--------------------------------------|--------------------------------|
| - [ ] | - [ ] |

---

## Audit checklist — legacy phases 01–06 (historic accuracy)

For each row: **Implemented** = tree + docs still align with the phase claim. **Verified** = you re-checked (spot-read + `rg`/inventory pass) and noted date/init in a status file or below.

### Legacy Phase 01 — Preflight and contract lock

| Item | Implemented | Verified |
|------|-------------|----------|
| D-003 / D-015 / D-021 / D-038 decisions recorded and still primary refs | - [ ] | - [ ] |
| No contradictory “frozen” docs superseding target without archive note | - [ ] | - [ ] |

### Legacy Phase 02 — Addon contracts

| Item | Implemented | Verified |
|------|-------------|----------|
| LIST target + addon theory alignment still documented | - [ ] | - [ ] |
| Fixture / contract family expectations still match addon (spot-check) | - [ ] | - [ ] |

### Legacy Phase 03 — Skin core plumbing

| Item | Implemented | Verified |
|------|-------------|----------|
| Batch B + B.1 files still Velocity-oriented per Includes_Paths / Actions | - [ ] | - [ ] |
| Hub wiring (`Includes_Hubs.xml`, startup JSON) matches inventory 01 | - [ ] | - [ ] |

### Legacy Phase 04 — Removals and policy

| Item | Implemented | Verified |
|------|-------------|----------|
| Batch A removal scope still holds (unreachable removed surfaces) | - [ ] | - [ ] |
| D-021 policy still reflected in details/context targets | - [ ] | - [ ] |

### Legacy Phase 05 — Metadata and rendering

| Item | Implemented | Verified |
|------|-------------|----------|
| Batch C includes still avoid undeclared helper-only branches per D-038 | - [ ] | - [ ] |
| Image-only row / spotlight intent still matches blueprint v1 where applicable | - [ ] | - [ ] |

### Legacy Phase 06 — Deferred exceptions

| Item | Implemented | Verified |
|------|-------------|----------|
| Batch D scope documented; weather/search residuals match D-038 | - [ ] | - [ ] |
| No silent expansion of deferred exceptions without ledger update | - [ ] | - [ ] |

---

## Phase 0 exit criteria

- [ ] All sections above have **Implemented** checked where true, or a written exception with owner
- [ ] **Verified** checked only with date + method (e.g. “2026-04-24, rg + read of Includes_Search.xml”)
- [ ] Gaps promoted to [phase-01](./phase-01-freeze-and-runtime-verification.md) or [phase-02](./phase-02-legacy-helper-and-d038-debt.md) as appropriate

---

## Audit notes (freeform)

*(Add dated findings here.)*
