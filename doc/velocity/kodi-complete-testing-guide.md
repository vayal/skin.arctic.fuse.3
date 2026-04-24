# Kodi — Complete manual testing guide (Velocity skin fork)

**Purpose:** Step-by-step manual QA in **Kodi** to verify the skin against the roadmap ([README.md](../next/roadmap/README.md)), close **Phase 07** runtime gaps, and confirm addon/list behavior against [LIST_CONTRACTS_TARGET.md](../target/LIST_CONTRACTS_TARGET.md) / [LIST_IMPLEMENTATION_STATUS.md](../status/LIST_IMPLEMENTATION_STATUS.md) and non-list surfaces in [screen-by-screen-build-contract.md](../target/screen-by-screen-build-contract.md).

**Audience:** Operators running a real Kodi install (target OS matches the skin’s `addon.xml` / `xbmc.gui` dependency).

**Not covered here:** Automated unit tests in other repos; Python addon development. This guide is **UI and integration** validation only.

---

## 1. Prerequisites

| Requirement | Notes |
|-------------|--------|
| Kodi | Version compatible with the skin’s declared `xbmc.gui` API. |
| Skin | This fork installed and **active** (`Settings` → `Interface` → `Skin`). |
| Velocity addon | `plugin.video.velocity2` installed, configured, and signed in if your setup requires it. |
| Network | As needed for lists, playback, and discovery. |
| Optional | `kodi.log` with debug logging for skin/addons when diagnosing missing includes or plugin errors. |

**Reference docs (keep open while testing):**

- Code-backed hub wiring: [kodi-ui-verification-matrix.md](../next/roadmap/kodi-ui-verification-matrix.md)
- Phase 07 stabilization criteria and evidence bucket: [phase-07-stabilization-and-freeze.md](../next/roadmap/phase-07-stabilization-and-freeze.md) (section **Validation status and blockers**)
- Checklist buckets: [appendix-verification-checklists.md](../next/roadmap/appendix-verification-checklists.md)
- Legacy/helper policy: [d038-legacy-property-ledger.md](d038-legacy-property-ledger.md)

---

## 2. How to record evidence (for roadmap reports)

For each major section below, capture at least one of:

- Short **session note** (Kodi version, OS, skin version/commit).
- **Screenshot** paths or filenames stored alongside the repo docs (or a ticket).
- **`kodi.log` excerpt** showing no skin XML errors on navigation (redact paths/tokens).

Paste results into:

- [phase-07-stabilization-and-freeze.md](../next/roadmap/phase-07-stabilization-and-freeze.md) — append operator notes / screenshots / log excerpts under **Validation status and blockers** (Home, Series 1101, Movies 1102, provider drill-in, search, info, D-015 paging).

---

## 3. Clean bootstrap (recommended before a full pass)

Default hub behavior is defined in [shortcuts/skinvariables-startup.json](../../shortcuts/skinvariables-startup.json). For a repeatable test, reset skin hub toggles and re-run startup.

**Option A — focused reset (hub toggles + startup)**

Run these **builtins** in Kodi (e.g. from RunScript, keymap, or a test profile):

1. `Skin.Reset(HomeSwitcher.1101.Toggle)`
2. `Skin.Reset(HomeSwitcher.1102.Toggle)`
3. `Skin.Reset(HomeSwitcher.1103.Toggle)`
4. `Skin.Reset(HomeSwitcher.1104.Toggle)`
5. `Skin.Reset(HomeSwitcher.1106.Toggle)`
6. `Skin.Reset(HomeSwitcher.1107.Toggle)`
7. `Skin.Reset(HomeSwitcher.1108.Toggle)`
8. `Skin.Reset(HomeSwitcher.LoopBack)`
9. `Skin.Reset(DefaultConfig.InitDone)`
10. `ActivateWindow(Startup)`

**Option B — full skin settings reset**

1. `Skin.ResetSettings`
2. `ActivateWindow(Startup)`

After reset, reload the skin if needed. Confirm **Series (1101)** and **Movies (1102)** are on and optional hubs **1103–1108** stay off unless you intentionally enable them.

---

## 4. Roadmap-aligned test suites

### 4.1 Phases 01–02 — Contracts and addon lists (integration)

**Goal:** Lists resolve without Python errors; feeds usable by the skin.

| Step | Action | Pass criteria |
|------|--------|----------------|
| 1 | From Home, open spotlight / hero if visible | Content loads or shows an explicit empty state (no silent failure). |
| 2 | Open Series (1101) and Movies (1102) | Rows load from `plugin://plugin.video.velocity2/...` per [kodi-ui-verification-matrix.md](../next/roadmap/kodi-ui-verification-matrix.md) §4. |
| 3 | **Optional (addon contract):** For any paginated row, open “full list” or next page if the UI exposes it | Response matches [LIST_CONTRACTS_TARGET](../target/LIST_CONTRACTS_TARGET.md): pagination fields where applicable; terminal page has no spurious next step (verify in log or addon debug if available). |

**Failure:** Note addon error in log; remediation may be **addon** (Phase 02) or skin path (Phase 03).

---

### 4.2 Phase 03 — Skin core plumbing (hubs, switcher, bootstrap)

Follow [kodi-ui-verification-matrix.md](../next/roadmap/kodi-ui-verification-matrix.md) **§2–§4** in order.

| Area | What to verify |
|------|----------------|
| Top bar | Search (if not disabled), **Home**, **Series**, **Movies** visible; optional **1103/1104/1106–1108** absent on clean bootstrap. |
| Hub IDs | **Series → window 1101**, **Movies → 1102**; Home remains `Home`. |
| Home rows | In-progress tab strip + poster row; spotlight uses mixed home list (see matrix §4.1). |
| Series / Movies rows | Row counts and labels per matrix §4.2–4.3; submenu strips §4.4. |
| Log | No missing-include or fatal skin parse errors on first navigation. |

**Matrix §6** is a minimal copy-paste checklist for tickets.

---

### 4.3 Phase 04 — Removals and D-021 (policy)

| Step | Action | Pass criteria |
|------|--------|----------------|
| 1 | Context menu on a list item | **No** skin-expanded tray of deprecated items (D-021); Kodi/addon context list behaves normally. |
| 2 | Try old removed entry points | No navigation to deleted custom windows (e.g. weather **1161**, plot **1113**, OSD cast **1141**, wiki/crew dialogs) from normal IA. |
| 3 | Settings | No mandatory dependency on `plugin.video.themoviedb.helper` for core Velocity flows. |

**Note:** Core Kodi PVR windows may still exist at the Kodi level; deprecated skin-only entry points were removed during migration (see git history and D-038).

---

### 4.4 Phase 05 — Metadata and rendering

| Step | Action | Pass criteria |
|------|--------|----------------|
| 1 | Hub row posters | Row cards remain **image-forward**; no unintended giant metadata blocks on every tile (per blueprint). |
| 2 | Spotlight / hero | Title, year, rating, plot strip readable where addon provides data. |
| 3 | Details | Full **DialogVideoInfo** path opens; no regression to deprecated small-plot-only flows for primary actions. |
| 4 | Trailer | If used: play trailer from item; windows **1122/1123** behave without skin XML errors in `kodi.log`. |

---

### 4.5 Phase 06 — Deferred cleanup (weather, search discover)

| Step | Action | Pass criteria |
|------|--------|----------------|
| 1 | Settings hub / power menu | **No** weather entry where Phase 06 removed it; no crash opening former weather shortcuts. |
| 2 | Search (`Custom_1105_Search`) | Opens; **Discover** path resolves to Velocity `action=discover` (see D-038 §4 for helper-named property key exception). |

---

### 4.6 Phase 07 — End-to-end journeys and freeze

Run these **user journeys** (see [surfaces/journeys/](surfaces/journeys/)):

#### A. Browse to play ([browse-to-play.md](surfaces/journeys/browse-to-play.md))

1. **Home** → confirm switcher and spotlight.  
2. **Series (1101)** → pick a row item → **Info** and/or **Play**.  
3. **Movies (1102)** → same.  
4. **Provider icons** (if present on hub) → open provider-scoped browse → return.  
5. **Playback** → OSD visible; play/pause; exit.  
6. Optional: post-play / “next” behavior if enabled.

#### B. Search to play ([search-to-play.md](surfaces/journeys/search-to-play.md))

1. Open **Search** from top bar.  
2. Run a query and/or use **Discover** / combined widgets per your build.  
3. Select a result → **Play** or **Info** → **Play**.

#### C. Info and related ([info-and-related.md](surfaces/journeys/info-and-related.md))

1. From a list or OSD, open **Info** → full details.  
2. Extended plot / custom plot path if still in scope.  
3. Context menu: confirm D-021 behavior (§4.3).  
4. Optional: writer/director drill-down if exposed — note any remaining helper-property-backed UI (documented in [D-038](d038-legacy-property-ledger.md) §4).

#### D. Pagination and empty states ([appendix-verification-checklists.md](../next/roadmap/appendix-verification-checklists.md) §3)

| Check | Pass criteria |
|-------|----------------|
| Spotlight | No “Next Page” style artifact in the hero rail. |
| Paged rows | In-row cap and “show more” / browse behavior match product intent; full list paging (e.g. 40/page) matches **addon** contract. |
| Empty lists | Skin shows expected empty copy (e.g. “No items” / blank row), not a hard error. |

When all Phase 07 criteria are met, update [README.md](../next/roadmap/README.md) Phase 07 row and mark **Validation status and blockers** in [phase-07-stabilization-and-freeze.md](../next/roadmap/phase-07-stabilization-and-freeze.md) accordingly.

---

## 5. Master checklist (appendix verification — full pass)

Use this as a **single-session** or **release** gate. Items reference [appendix-verification-checklists.md](../next/roadmap/appendix-verification-checklists.md).

### §1 Contract wiring

- [ ] Required list families appear in UI (home/series/movies/search as applicable).  
- [ ] Routes use `plugin://plugin.video.velocity2/?action=...` patterns from docs; no invented actions.  
- [ ] Paginated lists: confirm with addon/logs that payload semantics match D-015 where you can observe them.

### §2 Hub and mini-hub UX

- [ ] Home / Series / Movies spotlights load.  
- [ ] Provider row opens expected provider-scoped content (if enabled in product).  
- [ ] Genre / filtered lists open from genre controls (if present).

### §3 Paging and list behavior

- [ ] In-row vs full-list behavior matches expectations.  
- [ ] Full list page size (contract: 40) — **confirm via addon or visible page behavior**.  
- [ ] No erroneous next-page in spotlight.  
- [ ] Empty rows/states acceptable.

### §4 Details and OSD

- [ ] Details opens full flow.  
- [ ] OSD controls work; pause strip shows title + plot as designed.  
- [ ] OSD → full details escalation works.

### §5 Context and removal policy

- [ ] D-021 satisfied (no deprecated skin-expanded context tray).  
- [ ] Removed skin surfaces not reachable (weather/wiki/plot/cast per Phase 04/06).

### §6 Metadata rendering

- [ ] Row cards image-first.  
- [ ] Spotlight metadata fields present when data exists.  
- [ ] Trailers (if used) play without helper-only fallbacks for primary metadata.

### §7 Residual dependency (sanity)

- [ ] Core browse/play/search does not **require** TMDb Helper for Velocity paths.  
- [ ] Any helper-named skin settings or legacy keys behave as documented in D-038 (no surprises).

### §8 Freeze readiness

- [ ] All phases 01–07 accepted **in README** with evidence.  
- [ ] Traceability docs updated.  
- [ ] No open P0/P1 blockers in Phase 07 report.  
- [ ] Temporary exceptions listed in D-038 §4 with follow-up.

---

## 6. Known alignment gaps (log, not always blockers)

See [kodi-ui-verification-matrix.md](../next/roadmap/kodi-ui-verification-matrix.md) **§5**: contract row names vs generator rows, optional library search tabs, and “mini-hub” wording differences. Log discrepancies in your test notes for product/addon backlog.

---

## 7. Quick file index (maintainers)

| Topic | Location |
|-------|-----------|
| Switcher | `1080i/Includes_Home.xml` |
| Hubs / spotlight | `1080i/Includes_Hubs.xml`, `1080i/Home.xml` |
| Generator rows | `1080i/script-skinvariables-generator-overrides.xml` |
| Bootstrap | `shortcuts/skinvariables-startup.json` |
| Search | `1080i/Custom_1105_Search.xml`, `1080i/Includes_Search.xml` |
| Context menu | `1080i/Dialog_DialogContextMenu.xml` |

---

## 8. Related roadmap entries

| Resource | Role |
|----------|------|
| [roadmap/README.md](../next/roadmap/README.md) | Phase status and playbooks |
| [appendix-traceability-matrix.md](../next/roadmap/appendix-traceability-matrix.md) | D-003 / D-015 / D-021 / D-038 mapping |
| [skin-vision-blueprint-v0.md](skin-vision-blueprint-v0.md) | Product vision |
| [contracts/README.md](../contracts/README.md) | List addon **theory** |
| [LIST_CONTRACTS_TARGET.md](../target/LIST_CONTRACTS_TARGET.md) | List **target** (D-015) |
| [LIST_IMPLEMENTATION_STATUS.md](../status/LIST_IMPLEMENTATION_STATUS.md) | List **as-built** status |
| [screen-by-screen-build-contract.md](../target/screen-by-screen-build-contract.md) | Non-list surface target + backlog |
