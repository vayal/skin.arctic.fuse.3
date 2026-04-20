# Phase 07 Validation Report — Stabilization and Freeze

Phase doc: [phase-07-stabilization-and-freeze.md](./phase-07-stabilization-and-freeze.md)

Primary sources: [Skin Vision Blueprint v0](../skin-vision-blueprint-v0.md), [Screen-by-Screen Build Contract](../screen-by-screen-build-contract.md), [D-015](../d015-addon-required-lists-contract.md), [D-038](../d038-legacy-property-ledger.md), [inventory journeys](../../inventory/journeys/), [appendix-verification-checklists.md](./appendix-verification-checklists.md), [appendix-traceability-matrix.md](./appendix-traceability-matrix.md), [kodi-ui-verification-matrix.md](./kodi-ui-verification-matrix.md)

**Execution environment:** repository static analysis and documentation reconciliation only; **Kodi UI was not executed** in this pass (no live session, screenshots, or `kodi.log` excerpts captured).

---

## 1. Overall outcome

| Result | Value |
|--------|--------|
| **Freeze-ready** | **No** |
| **Phase 07 README status** | **blocked** — see §8 and §9 |

**Reason (summary):** End-to-end journey validation and several checklist items require **runtime evidence in Kodi**; none was produced in this environment. Prerequisite runtime gaps from [phase-03-validation-report.md](./phase-03-validation-report.md) (addendum checklist items 1–4) remain **open** (empty evidence table).

---

## 2. Stabilization by journey / surface

### 2.1 Browse to Play ([browse-to-play.md](../../inventory/journeys/browse-to-play.md))

| Step | Static / doc evidence | Runtime |
|------|------------------------|---------|
| Home entry, switcher | [1080i/Home.xml](../../1080i/Home.xml), [1080i/Includes_Home.xml](../../1080i/Includes_Home.xml), [shortcuts/skinvariables-startup.json](../../shortcuts/skinvariables-startup.json) — Velocity spotlight + hub toggles wired per [kodi-ui-verification-matrix.md](./kodi-ui-verification-matrix.md) §2–4 | **Not executed** |
| Hub rows / spotlight | [1080i/Includes_Hubs.xml](../../1080i/Includes_Hubs.xml) — `list_id` + `plugin://plugin.video.velocity2/?action=list&…&page=1` for spotlight; no `TMDbHelper` in this file (verified grep) | **Not executed** |
| Actions / OSD | [1080i/Includes_Actions.xml](../../1080i/Includes_Actions.xml), [1080i/Includes_OSD.xml](../../1080i/Includes_OSD.xml) | **Not executed** |
| Post-play / paths | [1080i/Includes_Paths.xml](../../1080i/Includes_Paths.xml) | **Not executed** |

### 2.2 Search to Play ([search-to-play.md](../../inventory/journeys/search-to-play.md))

| Step | Static / doc evidence | Runtime |
|------|------------------------|---------|
| Search window + discover | [1080i/Custom_1105_Search.xml](../../1080i/Custom_1105_Search.xml), [1080i/Includes_Search.xml](../../1080i/Includes_Search.xml) — Velocity discover onload via `TMDbHelper.UserDiscover.FolderPath` **property key** (documented **keep-temporary** in [D-038](../d038-legacy-property-ledger.md) §4) | **Not executed** |
| Combined widgets / generator | [1080i/script-skinvariables-generator-overrides.xml](../../1080i/script-skinvariables-generator-overrides.xml) — Velocity `list_id` rows for 1101/1102 per [kodi-ui-verification-matrix.md](./kodi-ui-verification-matrix.md) §4 | **Not executed** |

### 2.3 Info and Related ([info-and-related.md](../../inventory/journeys/info-and-related.md))

| Step | Static / doc evidence | Runtime |
|------|------------------------|---------|
| Full details | [1080i/DialogVideoInfo.xml](../../1080i/DialogVideoInfo.xml), [1080i/Includes_DialogInfo.xml](../../1080i/Includes_DialogInfo.xml) | **Not executed** |
| Plot / custom plot | Phase 04 removed `Custom_1113_Dialog_Plot.xml`; plot escalation paths per prior phase reports | **Not executed** |
| Context menu (D-021) | [1080i/Dialog_DialogContextMenu.xml](../../1080i/Dialog_DialogContextMenu.xml) — `has_menu` = `false`; header uses `TMDbHelper.ListItem.base_*` when `$EXP[Exp_AllowExpandedContextMenu]` (documented in D-038 §4) | **Not executed** |
| Writer/director view (`DialogView` + crew items) | [1080i/Dialog_DialogView.xml](../../1080i/Dialog_DialogView.xml) includes `DialogInfo_CrewItems` → `DialogInfo_CrewItem` still uses `Window(Home).Property(TMDbHelper.ListItem.*)` in [1080i/Includes_DialogInfo.xml](../../1080i/Includes_DialogInfo.xml) — **documented** in D-038 §4 Phase 07 table | **Not executed** |

### 2.4 Home / Series / Movies hubs

Static alignment: hub wiring and contract IDs are documented in [kodi-ui-verification-matrix.md](./kodi-ui-verification-matrix.md) §4–5 and [screen-by-screen-build-contract.md](../screen-by-screen-build-contract.md) §2. **Runtime** navigation (load rows, play, info) — **not executed**.

**Doc drift (informational):** [d003-view-mode-matrix.md](../d003-view-mode-matrix.md) §1 `HomeSwitcher.*` column does not match the implemented hub map in [kodi-ui-verification-matrix.md](./kodi-ui-verification-matrix.md) §3 (e.g. D-003 lists `HS-home` as `HomeSwitcher.1101` and `HS-movies` as `HomeSwitcher.1103`; the skin uses **Series** = `1101`, **Movies** = `1102`, **Home** = `Home` window). Treat D-003 as mode philosophy; use the verification matrix for window IDs until D-003 is corrected in a doc-only pass.

### 2.5 Provider mini-hubs

Static: provider rows and `plugin://` patterns are described in [kodi-ui-verification-matrix.md](./kodi-ui-verification-matrix.md) and build contract §2. **Runtime** drill-in — **not executed** (same gap as Phase 03 addendum items 1–4).

### 2.6 Details / OSD / search (summary)

- **Details:** Helper-named crew property bindings remain for **writer/director** `DialogView` path (D-038 §4).
- **OSD:** `TMDbHelper.Player.CropImage` still passed in [1080i/Includes_OSD.xml](../../1080i/Includes_OSD.xml) (D-038 §4).
- **Search:** Velocity routing with approved **keep-temporary** discover property keys (D-038 §4).

### 2.7 Pagination and empty-state

| Check | Static result | Evidence |
|-------|----------------|----------|
| Spotlight non-paginated (no next-page artifact in hero) | **Pass (static)** — spotlight uses `page=1` and empty `limit` on Omega binding with server-side cap note in [1080i/Includes_Hubs.xml](../../1080i/Includes_Hubs.xml) | Comments + `Hub_Velocity_Spotlight_NonPaginated` |
| In-row cap 10 vs build contract §1 | **Not verified** — generator overrides use `[1080i/script-skinvariables-generator-overrides.xml](../../1080i/script-skinvariables-generator-overrides.xml)` with empty `limit` on many rows; contract says max 10 in-row before “Next Page”; **requires runtime or addon confirmation** | [screen-by-screen-build-contract.md](../screen-by-screen-build-contract.md) §1 |
| Row header → full list | **Partial (static)** — `Defs_BrowseLimitedLists` in [1080i/Includes_Defaults.xml](../../1080i/Includes_Defaults.xml) (`never`/`auto` browse) | Needs Kodi behavior check |
| Full list 40/page | **Not verified (runtime)** — D-015 requires addon payload; skin does not encode `40` in all paths | [d015-addon-required-lists-contract.md](../d015-addon-required-lists-contract.md) |
| Empty state copy | **Not verified (runtime)** — build contract expects “No items available” behavior | — |

---

## 3. D-021 (context menu policy)

| Check | Result | Evidence |
|-------|--------|----------|
| Skin-expanded tray removed (`has_menu` false) | **Pass (static)** | [1080i/Dialog_DialogContextMenu.xml](../../1080i/Dialog_DialogContextMenu.xml) line 37 `has_menu` → `false`; consistent with [phase-04-validation-report.md](./phase-04-validation-report.md) |
| Residual `TMDbHelper` in header/poster for dialog chrome | **Documented** — not D-021 “expanded items”; listed in D-038 §4 Phase 07 table | D-038 |

---

## 4. D-038 (exception discipline)

| Check | Result | Notes |
|-------|--------|--------|
| Residual symbols mapped to ledger / §4 | **Pass (documentation)** — open ledger rows reconciled; §4 expanded with Phase 07 table (crew strip, context header, OSD crop, background blur, shortcut generator) | [doc/d038-legacy-property-ledger.md](../d038-legacy-property-ledger.md) |
| No *undocumented* new hits without follow-up | **Pass** — generator + `skinvariables-shortcut-config.json` helper URLs now have ledger rows + §4 | Same file |
| Rename `TMDbHelper.UserDiscover.FolderPath` | **Deferred** (explicitly post–Phase 07 rename slice) | D-038 §3 table + §4 |

---

## 5. Traceability (D-003, D-015, D-021, D-038)

| Decision | Closure evidence (this repo) |
|----------|-------------------------------|
| **D-003** | View modes and hub IDs: [d003-view-mode-matrix.md](../d003-view-mode-matrix.md), [kodi-ui-verification-matrix.md](./kodi-ui-verification-matrix.md) §2–3; **runtime lock** not re-validated in Phase 07 |
| **D-015** | Contract: [d015-addon-required-lists-contract.md](../d015-addon-required-lists-contract.md); skin wiring spot-check: Includes_Hubs, generator overrides; **addon payload** not exercised here |
| **D-021** | Phase 04 report + static context menu XML; Phase 07 §3 |
| **D-038** | Ledger + §4; Phase 07 reconciliation edits | [d038-legacy-property-ledger.md](../d038-legacy-property-ledger.md) |

---

## 6. Appendix verification checklists — pass/fail

Source: [appendix-verification-checklists.md](./appendix-verification-checklists.md)

### §1 Contract wiring

| Item | Result | Evidence |
|------|--------|----------|
| Required D-015 contract families exist in wiring | **Pass (static spot-check)** | Generator overrides + Includes_Hubs `list_id` values; see [kodi-ui-verification-matrix.md](./kodi-ui-verification-matrix.md) §4 |
| Route naming / pagination payload | **Fail (runtime)** — addon must return `items/page/has_more/next_page` per D-015; not validated here | [d015-addon-required-lists-contract.md](../d015-addon-required-lists-contract.md) |

### §2 Hub and mini-hub UX

| Item | Result | Evidence |
|------|--------|----------|
| Spotlight routes | **Pass (static)** | Includes_Hubs, startup JSON |
| Provider / genre | **Not executed (runtime)** | — |

### §3 Paging and list behavior

| Item | Result | Evidence |
|------|--------|----------|
| In-row cap / header / full list / 40 / spotlight / empty | **Partial** — §2.7; **fail** for full product verification without Kodi | §2.7 |

### §4 Details and OSD

| Item | Result | Evidence |
|------|--------|----------|
| Details, OSD, pause strip | **Not executed (runtime)** | — |

### §5 Context and removal policy

| Item | Result | Evidence |
|------|--------|----------|
| D-021 | **Pass (static)** | §3 |
| Removed PVR/weather/wiki/crew surfaces unreachable via skin XML | **Pass (static grep)** — no `ActivateWindow(1161|weather|…)` / script-wikipedia matches in tracked `xml`/`json` sweep for this pass | Phase 04/06 reports; grep (see §7.1) |
| Broader PVR via Kodi core | **Out of scope** — Phase 04 residual note | [phase-04-validation-report.md](./phase-04-validation-report.md) §Residual |

### §6 Metadata rendering

| Item | Result | Evidence |
|------|--------|----------|
| Image-only rows, spotlight fields, labels | **Not executed (runtime)** | [phase-05-validation-report.md](./phase-05-validation-report.md) static pass |

### §7 Residual dependency

| Item | Result | Evidence |
|------|--------|----------|
| Undeclared helper references | **Pass (discipline)** — remaining symbols documented in D-038 §4 + ledger rows | §4, D-038 |
| Shortcut editor / generator helper URLs | **Documented** as legacy generator presets | D-038 §2 new rows |

### §8 Freeze readiness

| Item | Result | Evidence |
|------|--------|----------|
| Phases 01–07 accepted | **Fail** — Phase 07 acceptance requires runtime closure of journey tests; not met | §1 |
| Traceability matrix complete | **Pass (docs)** | [appendix-traceability-matrix.md](./appendix-traceability-matrix.md) updated |
| No unresolved P0/P1 blockers | **Fail** — P1: missing runtime evidence; see §9 | §9 |
| Temporary exceptions have rationale + follow-up | **Pass (docs)** | D-038 §4 |

---

## 7. Static checks (supplementary)

### 7.1 Removed surfaces — grep (xml + json under repo)

Pattern sweep: `ActivateWindow(1113|1141|1120|1161|weather|Weather|script.wikipedia)` — **no matches** in `.xml`/`.json` (this pass).

### 7.2 Prerequisite reports — carried runtime gaps

| Source | Gap |
|--------|-----|
| [phase-03-validation-report.md](./phase-03-validation-report.md) §Runtime addendum | Items 1–4 **fail** (not executed); evidence table empty |
| [phase-04-validation-report.md](./phase-04-validation-report.md) §Residual | Hub/OSD/context **runtime** not executed |
| [phase-05-validation-report.md](./phase-05-validation-report.md) | Metadata **runtime** deferred to matrix |

---

## 8. Freeze checklist result (aggregate)

**Result: FAIL**

- **Static** portions of the freeze and policy checks are partially satisfied (§6–§7).
- **End-to-end** and **addon-contract runtime** requirements are **not** satisfied in this environment.

---

## 9. Unresolved blockers (P0/P1) and owning phase

Use this list for remediation before marking Phase 07 **completed**.

| Priority | Criterion / blocker | Evidence | Owning phase / follow-up |
|----------|----------------------|----------|---------------------------|
| **P1** | **Browse / hub / provider / OSD journeys** not validated in Kodi | §2; Phase 03 addendum empty table | **Phase 07** (re-run validation in Kodi) — capture evidence per [kodi-ui-verification-matrix.md](./kodi-ui-verification-matrix.md) |
| **P1** | **Search-to-play** and **info-and-related** journeys not validated in Kodi | §2 | **Phase 07** (operator session) |
| **P1** | **Pagination / empty-state / full-list 40** behavior not confirmed against D-015 at runtime | §2.7 | **Phase 02** (addon contract) + **Phase 07** (UI verification) |
| **P2** | D-003 vs kodi matrix hub ID wording for Movies (`1102` vs `1103` in D-003 table) | §2.4 | **Phase 01** doc hygiene (optional) |

**Minimal blocker report (guardrail format)**

1. **Scope:** Phase 07 — stabilization and freeze  
2. **Blocker:** No Kodi runtime evidence for mandatory journey and paging checks.  
3. **Evidence:** This report §1–§2; Phase 03 validation report addendum (empty operator table).  
4. **Needed decision:** Run manual QA in Kodi and attach evidence to Phase 03 addendum or this report, or accept intentional “blocked” freeze.  
5. **Safe fallback:** None for freeze; **do not** mark package freeze-ready until evidence exists.

---

## 10. Handoff

- **Roadmap README:** Phase 07 set to **blocked** with link to this report.  
- **Re-run:** After operator evidence is attached, update §2 runtime columns, §6–§8, §1 overall outcome, and README to **completed** only if all gates pass.
