# Phase 1 — Freeze & runtime verification

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

Successor to legacy roadmap **Phase 07** (stabilization and freeze). This document holds **implementation detail, status, and verification** for runtime closure — not high-level vision.

---

## In scope

- Runtime verification, operator QA evidence, and freeze decision closure for current skin behavior.
- Reconciliation of observed behavior against roadmap specs (lists/non-list) and D-items.

## Out of scope

- Large feature additions not required to pass freeze criteria.
- Product-policy changes that need separate acceptance (route to Phase 2 or 3).

## Objectives

- Capture **Kodi runtime evidence** for mandatory journeys and D-015 list behavior.
- Close **P1 blockers** listed below with reproducible notes + links (log snippets, screenshots path, PR).
- Align **target** vs **observed** behavior; file gaps under [phase-02](./phase-02-legacy-helper-and-d038-debt.md) when work is required beyond verification.

---

## Validation status and blockers

**Freeze-ready:** No — **no Kodi runtime evidence** yet for mandatory journeys or D-015 paging in this environment.

**Where to work next**

- Operator QA: [kodi-complete-testing guide](../context/kodi-complete-testing-guide.md) (this file § Kodi UI matrix + § Verification checklists)
- Code/property backlog: [phase-02](./phase-02-legacy-helper-and-d038-debt.md), [D-038](../context/d038-legacy-properties-and-mapping.md)
- Contracts: [LIST_CONTRACTS_TARGET](./LIST_CONTRACTS_TARGET.md) + [LIST_IMPLEMENTATION_STATUS](./LIST_IMPLEMENTATION_STATUS.md) + [context README](../context/README.md); [non-list surfaces](./nonlist-surfaces-index.md)

**Topic spine:** [traceability-by-topic.md](../traceability-by-topic.md)

### P1 blockers (close before marking Phase 1 completed)

| Blocker | What to capture |
|--------|------------------|
| Browse / hub / provider / OSD | Evidence per [browse-to-play](../context/journeys/browse-to-play.md) + **§ Kodi UI verification matrix** §2–§5 |
| Search-to-play, info-and-related | [search-to-play](../context/journeys/search-to-play.md), [info-and-related](../context/journeys/info-and-related.md) |
| D-015 at runtime | `items` / `page` / `has_more` / `next_page`; in-row cap vs full list; empty state copy ([LIST_CONTRACTS_TARGET](./LIST_CONTRACTS_TARGET.md)) |

### Static notes (sanity only, not freeze proof)

- **Includes_Hubs.xml:** Velocity `list_id` + `page=1` spotlight wiring; no `TMDbHelper` in this file (repo grep).
- **Search / discover:** `Includes_Search.xml` still uses helper-named **property key** for discover folder path — documented **keep-temporary** in D-038 §4.
- **Residual helper symbols:** still present in multiple includes — tracked in D-038 + [phase-02](./phase-02-legacy-helper-and-d038-debt.md).
- **PVR gating:** deferred product decision → [phase-03](./phase-03-pvr-gating-product-policy.md).

### Program dashboard update

When Phase 1 completes, update the **Phase 1** row in [ROADMAP_MASTER.md](../ROADMAP_MASTER.md).

---

## Inputs and prerequisite checks

- [Skin Vision Blueprint v1](./skin-vision-blueprint-v1.md) — v0 history: [archive](../archive/skin-vision-blueprint-v0.md)
- [Traceability by topic](../traceability-by-topic.md)
- [List theory](../context/README.md) · [list target](./LIST_CONTRACTS_TARGET.md) · [list status](./LIST_IMPLEMENTATION_STATUS.md)
- [Non-list surfaces hub](./nonlist-surfaces-index.md)
- [D-038](../context/d038-legacy-properties-and-mapping.md)
- [Surface inventory hub](../context/surface-inventory-index.md) · [Journeys](../context/journeys/README.md)
- Historic audit complete or in progress: [phase-00](./phase-00-historic-implementation-audit.md)

Checks:

- [ ] Historic phases **01–06** audit either complete ([phase-00](./phase-00-historic-implementation-audit.md)) or explicitly waived with rationale
- [ ] No unresolved blockers carried into final freeze (see **Validation status** above)

---

## Work items — implementation & verification

| ID | Work item | Implemented | Verified | References |
|----|-----------|-------------|----------|------------|
| P1.1 | Browse-to-play journey evidence | - [ ] | - [ ] | [browse-to-play](../context/journeys/browse-to-play.md) |
| P1.2 | Search-to-play journey evidence | - [ ] | - [ ] | [search-to-play](../context/journeys/search-to-play.md) |
| P1.3 | Info-and-related journey evidence | - [ ] | - [ ] | [info-and-related](../context/journeys/info-and-related.md) |
| P1.4 | D-015 runtime pagination / empty states | - [ ] | - [ ] | [LIST_CONTRACTS_TARGET](./LIST_CONTRACTS_TARGET.md), § matrix below |
| P1.5 | Operator checklist (full pass) | - [ ] | - [ ] | § Verification checklists below |
| P1.6 | D-003 / D-015 / D-021 / D-038 closure notes in status or this doc | - [ ] | - [ ] | [phase-00](./phase-00-historic-implementation-audit.md), D-038 |

---

## Step-by-step execution

Prefer validating **by topic** using [traceability-by-topic.md](../traceability-by-topic.md).

1. Validate primary UX flows end-to-end: Home, Series, Movies hubs; provider mini-hubs; details, OSD, search.
2. Validate pagination: in-row cap; header/full-list; full-list 40/page; spotlight non-paginated.
3. Validate context menu and removals: D-021; removed surfaces unreachable.
4. Validate metadata rendering: image-only row cards; spotlight fields; pause strip.
5. Validate D-015 schema vs runtime addon payloads.
6. Reconcile D-038 ledger with observed grep + UI.
7. Update [ROADMAP_MASTER.md](../ROADMAP_MASTER.md) program status and link evidence from this file.

---

## Acceptance criteria (pass / fail)

- [ ] All **P1** blockers cleared with linked evidence
- [ ] Work items **P1.1–P1.6** marked **Verified** where applicable
- [ ] No unresolved P0/P1 blockers for freeze
- [ ] Residual issues promoted to [phase-02](./phase-02-legacy-helper-and-d038-debt.md) with IDs

---

## Abort / rollback guidance

- If freeze checks fail: do not mark freeze-ready; open items in phase-02; rerun affected slices only.

---

## If blocked, stop and report

1. Failed acceptance criterion  
2. Failing surface and repro  
3. Owning remediation phase (1 vs 2 vs 3)

---

# Appendix A — Verification checklists (operator)

Reusable gates; keep unchecked until Kodi evidence exists.

## A.1 Contract wiring

- [ ] all required D-015 contract families exist
- [ ] route naming matches frozen contract IDs/patterns
- [ ] pagination payload includes `items/page/has_more/next_page`
- [ ] `next_page` omitted on terminal page
- [ ] strict IDs and progress fields are present where required

## A.2 Hub and mini-hub UX

- [ ] Home/Series/Movies spotlight routes resolve correctly
- [ ] provider icon row opens provider mini-hub targets
- [ ] provider hub rows use standardized route families
- [ ] genre rows use fixed genre set and open filtered lists

## A.3 Paging and list behavior

- [ ] in-row cap behavior matches contract
- [ ] row header opens full list as defined
- [ ] full list page size is 40
- [ ] no next-page artifact in spotlight feeds
- [ ] empty rows render expected empty-state behavior

## A.4 Details and OSD

- [ ] details action opens full details flow
- [ ] no unintended small info dialog regression
- [ ] OSD normal controls behavior preserved
- [ ] pause strip shows minimal title + plot
- [ ] OSD overlay to full-details escalation works

## A.5 Context and removal policy

- [ ] D-021 policy enforced (skin expanded items removed)
- [ ] removed PVR surfaces are unreachable
- [ ] removed weather surfaces (if in scope) are unreachable
- [ ] removed helper-only wiki/crew surfaces are unreachable

## A.6 Metadata rendering

- [ ] row cards remain image-only
- [ ] spotlight metadata fields render correctly
- [ ] labels render from Velocity/native properties
- [ ] overlays and info panels no longer depend on helper-only branches
- [ ] trailer surfaces (if retained) use non-helper metadata

## A.7 Residual dependency

- [ ] no undeclared `TMDbHelper.*` / `TMDBHelper.*` in approved migrated surfaces
- [ ] no undeclared helper addon-id references in active settings/actions
- [ ] all remaining references documented in D-038

## A.8 Freeze readiness

- [ ] phases 0–1 accepted per ROADMAP_MASTER
- [ ] historic traceability audit complete (phase 0)
- [ ] no unresolved P0/P1 blockers
- [ ] all temporary exceptions have explicit rationale and follow-up

---

# Appendix B — Kodi UI verification matrix (code-backed QA)

**Purpose:** Test real Kodi UI against **what the repo wires**, while noting where **contract docs** still differ. Use for manual QA; update rows when wiring changes.

**Full pass narrative:** [kodi-complete-testing guide](../context/kodi-complete-testing-guide.md)

**Prerequisites:** `plugin.video.velocity2` installed; skin reloaded after edits; optional debug log.

## B.1 Which plan applies

| Layer | Document | Use for UI verification |
|--------|-----------|-------------------------|
| **Skin bootstrap & switcher** | [ROADMAP_MASTER](../ROADMAP_MASTER.md), `shortcuts/skinvariables-startup.json` | Default hubs on, names, Velocity paths |
| **Inventory / traceability** | [surface-inventory-home-hubs](./surface-inventory-home-hubs.md), [phase-00](./phase-00-historic-implementation-audit.md) | Structural IDs (`HomeSwitcher.*`, hub windows) |
| **Product / contract names** | [LIST_CONTRACTS_TARGET](./LIST_CONTRACTS_TARGET.md) | Target `contract_id` / hub rows — not always 1:1 with generator `list_id` labels in XML |
| **As-built lists** | [LIST_IMPLEMENTATION_STATUS](./LIST_IMPLEMENTATION_STATUS.md) | Wiring vs D-015 |

**Rule:** For list contract truth, use [context](../context/README.md) (theory), [LIST_CONTRACTS_TARGET](./LIST_CONTRACTS_TARGET.md) (target), [LIST_IMPLEMENTATION_STATUS](./LIST_IMPLEMENTATION_STATUS.md) (status).

## B.2 Top bar (main switcher) — Kodi checks

**Skin:** `1080i/Includes_Home.xml` (`Home_Switcher_Horz` / `Home_Switcher_Right_Buttons`).

| # | UI element | Window / behavior | Default after bootstrap | Verify in Kodi |
|---|------------|---------------------|-------------------------|----------------|
| 1 | **Search** (magnifier) | Opens search flow; visibility `!Skin.HasSetting(HomeSwitcher.DisableSearch)` | Visible | Icon left of text hubs; hidden if setting disables search |
| 2 | **Home** | `home` — always first text hub | Always shown | Label from `Skin.String(HomeSwitcher.Home.Name)` |
| 3 | **Series** | `ReplaceWindow(1101)` when `HomeSwitcher.1101.Toggle` set | On | Label **Series**; opens hub **1101** |
| 4 | **Movies** | `ReplaceWindow(1102)` when `HomeSwitcher.1102.Toggle` set | On | Label **Movies**; opens hub **1102** |
| 5 | **Hub slots 1103 / 1104** | Same pattern | **Off** (toggle cleared on init + each reload) | Should **not** appear unless toggles re-enabled |
| 6 | **Calendar / Up Next** | `ReplaceWindow(1106)` when toggle set | **Off** by default | When enabled: icon on right; hub **1106** |
| 7 | **Live TV** | `ReplaceWindow(1107)` when toggle set **and** `System.HasPVRAddon + PVR.HasTVChannels` | **Off** by default | May stay hidden if no PVR/channels even if toggle on |
| 8 | **Add-ons** | `ReplaceWindow(1108)` when toggle set | **Off** by default | When enabled: icon; hub routing per control logic |
| 9 | **Skin settings** | Settings control at end of right strip | Always | Opens home switcher / skin configuration |

**Bootstrap source:** `shortcuts/skinvariables-startup.json` — first run sets `1101`/`1102` toggles, clears `1103`–`1108`, sets `LoopBack`, Velocity spotlight + shortcut paths; **every reload** reapplies toggles + names + paths and resets `1103`–`1108` toggles (lines ~49–59).

## B.3 Hub window IDs (quick reference)

| ID | Inventory name | Startup labels (when enabled) |
|----|----------------|------------------------------|
| `Home` | Home | — |
| `1101` | Series hub | `Skin.String(HomeSwitcher.1101.Name)` → **Series** |
| `1102` | Movies hub | **Movies** |
| `1103` | Optional hub | cleared by default |
| `1104` | Optional hub | cleared by default |
| `1106` | Calendar / Up Next style mini-hub | toggle cleared by default |
| `1107` | PVR / Live TV | toggle cleared by default |
| `1108` | Add-ons | toggle cleared by default |
| `1109` | Settings hub (`Custom_1109_Settings.xml`) | toggle-dependent |

**View modes:** `1101`/`1102`/`1103`/`1104`/`1106` default **Standard**; `1107`/`1108` default **Wall** (`skinvariables-startup.json`).

**D-003:** [d003-view-mode-matrix](./d003-view-mode-matrix.md) §1; primary discovery UX is search (`Custom_1105_Search.xml`).

## B.4 Standard-mode widget rows (URLs in repo)

**Source:** `1080i/script-skinvariables-generator-overrides.xml`. Layout: `List_Landscape_Row` unless hub mode changed in UI.

### B.4.1 Home (`skinvariables-homewidgets-standard`)

| Order | Row label | Content / behavior |
|------:|-----------|---------------------|
| 1 | In progress (tab strip) | `plugin://script.skinvariables/?info=get_shortcuts_node&guid=velocity-home-inprogress&menu=homewidgets-inprogress-tabs&…` — landscape row **501** |
| 2 | Poster row (follows tab) | `$INFO[Window.Property(WidgetMeta.501.FolderPath)]` — Velocity lists `home_in_progress_series` / `home_in_progress_movies` per `Velocity.Home.InProgressTab` |

**Kodi check:** Tab strip changes tab; poster row loads `plugin://plugin.video.velocity2/?action=list&list_id=home_in_progress_*&page=1`.

**Spotlight:** `Skin.String(HomeSwitcher.Home.Spotlight.*)` from `skinvariables-startup.json` / `Home.xml` — `plugin://plugin.video.velocity2/?action=list&list_id=home_spotlight_mixed&page=1`.

### B.4.2 Series hub 1101 (`skinvariables-1101widgets-standard`)

| Order | Row label | `list_id` |
|------:|-----------|-----------|
| 1 | In-progress Series | `series_in_progress_shows` |
| 2 | Trending Series | `series_global_trending` |
| 3 | Providers | `series_provider_icons` |
| 4 | Browse by genre | `series_genre_navigation` |

### B.4.3 Movies hub 1102 (`skinvariables-1102widgets-standard`)

| Order | Row label | `list_id` |
|------:|-----------|-----------|
| 1 | In Progress | `movies_in_progress` |
| 2 | Trending | `movies_global_trending` |
| 3 | Providers | `movies_provider_icons` |
| 4 | Browse by genre | `movies_genre_navigation` |

### B.4.4 Submenu strip (1101 / 1102)

- **1101:** Continue Watching, New Episodes  
- **1102:** Continue Watching, Recently Watched  

## B.5 Alignment gaps to log while testing

| Topic | Plan / contract doc | Current skin behavior |
|--------|---------------------|------------------------|
| Feed naming | [LIST_CONTRACTS_TARGET](./LIST_CONTRACTS_TARGET.md) | Hubs use **`action=list` + `list_id=`** per overrides — map contract names to addon `list_id` in reference docs |
| Row set / order | Contract tables may describe older smart-rail sets | **1101/1102/Home** rows match **overrides** (§B.4); reconcile contract when product locks IDs |
| “Mini-hubs” | Contract: per streaming provider roster | **1106–1108** are calendar/up next, PVR, addons — treat contract mini-hub section as **future** unless product says otherwise |
| Optional hubs | Legacy phase 03: default off | Still **implemented** if user enables toggles — OK |
| **Search tabs** | [LIST_CONTRACTS_TARGET](./LIST_CONTRACTS_TARGET.md) + [nonlist search target](./nonlist-search-chrome-target.md) | Base generator may still define **Movies / TV / Music / Artists** `videodb://` / `musicdb://` rows alongside Velocity `execute_search`. **Canonical:** Velocity `execute_search` + Discover — see `Custom_1105_Search.xml` / `Includes_Search.xml` |

## B.6 Minimal pass/fail checklist (copy for tickets)

- [ ] Top bar: Search (if enabled) + Home + **Series** + **Movies**; no 1103/1104/1106–1108 on clean profile after skin init  
- [ ] Home: in-progress tab row + poster row populate or empty state; spotlight uses `home_spotlight_mixed`  
- [ ] 1101: four rows (B.4.2); submenu two items  
- [ ] 1102: four rows (B.4.3); submenu two items  
- [ ] No missing textures in log for submenu icons  

## B.7 Related files (maintainers)

| Concern | File |
|---------|------|
| Switcher layout | `1080i/Includes_Home.xml` |
| Hub widget / submenu XML | `1080i/script-skinvariables-generator-overrides.xml` |
| Bootstrap + skin strings | `shortcuts/skinvariables-startup.json` |
| Include order | `1080i/Includes.xml` |
| Home shortcut list parity | `shortcuts/skinvariables-shortcut-homewidgets.json` |

---

# Appendix C — Agent guardrails

## C.1 Execution boundaries

- Follow [ROADMAP_MASTER](../ROADMAP_MASTER.md) phase order (Phase 0 → 1 → 2 → 3 unless waived).
- Work only on the active phase unless instructed.
- Do not reopen frozen design decisions from [blueprint v0](../archive/skin-vision-blueprint-v0.md), [D-003](./d003-view-mode-matrix.md), [D-015 list target](./LIST_CONTRACTS_TARGET.md), [D-038](../context/d038-legacy-properties-and-mapping.md) without an explicit decision record.

## C.2 Forbidden actions

- Do not invent new route naming families.
- Do not introduce fallback behavior where docs forbid it.
- Do not remove files outside approved batch scope (see [phase-00](./phase-00-historic-implementation-audit.md) D-038 table).
- Do not proceed after blocker without stop/report.
- Do not overwrite canonical docs with summary-only replacements.

## C.3 Required behavior

- Small verifiable slices; validate after each slice.
- Keep [traceability-by-topic](../traceability-by-topic.md) and D-038 aligned when symbols change.
- Preserve temporary exceptions only when documented (D-038).

## C.4 Stop conditions

Stop and report if: required contract field missing from addon outputs; path/action mapping cannot resolve without changing frozen decisions; removal candidate still required by active UX; runtime conflicts with D-item policy.

## C.5 Blocker report format

1. **Scope:** phase + task  
2. **Blocker:** precise failure  
3. **Evidence:** file/symbol/symptom  
4. **Needed decision:** smallest unblock  
5. **Safe fallback:** temporary workaround (if any)

## C.6 Batch discipline (D-038)

- Batch A: remove-first approved surfaces only.  
- Batch B: control-plane replace before cosmetic changes.  
- Batch C: rendering/metadata after core plumbing.  
- Batch D: documented deferred exceptions only.

## C.7 Completion discipline

Phase complete only when: acceptance checklist passes; no unresolved blockers; handoff preconditions satisfied.
