# Kodi UI verification matrix (Velocity skin fork)

**Purpose:** One place to test the real Kodi UI against **what the repo actually wires**, while noting where **roadmap / contract docs** still differ. Use this for manual QA passes; update this file when rows or toggles change.

**Prerequisites:** `plugin.video.velocity2` installed and signed in as needed; skin reloaded after edits; optional debug log for skin errors.

---

## 1) Which “plan” applies to what

| Layer | Document | Use for UI verification |
|--------|-----------|-------------------------|
| **Skin bootstrap & switcher** | [phase-03-skin-core-plumbing-migration.md](./phase-03-skin-core-plumbing-migration.md), [phase-03-validation-report.md](./phase-03-validation-report.md) | Default hubs on, names, Velocity paths, optional hub toggles cleared |
| **Inventory / traceability** | [inventory/01-home-and-hubs.md](./inventory/01-home-and-hubs.md), [appendix-traceability-matrix.md](./appendix-traceability-matrix.md) | Structural IDs (`HomeSwitcher.*`, hub windows) |
| **Product / addon contract names** | [screen-by-screen-build-contract.md](../screen-by-screen-build-contract.md) | **Target** UX and named feeds (e.g. `series_spotlight_trending`) — **not** yet 1:1 with skin XML paths today |
| **Roadmap status** | [README.md](./README.md) | Phase table — **note:** README lists Phase 03 as `blocked` while [phase-03-validation-report.md](./phase-03-validation-report.md) records acceptance pass; reconcile before treating Phase 03 as closed |

**Rule of thumb:** For “does the skin do what we shipped?” verify against **§2–§5** below (code-backed). For “does the addon eventually match the long-form contract?” track **screen-by-screen** separately and map `smart_list` / `list` types to those contract IDs in addon docs.

---

## 2) Top bar (main switcher) — Kodi checks

**Skin:** `1080i/Includes_Home.xml` (`Home_Switcher_Horz` / `Home_Switcher_Right_Buttons`).

| # | UI element | Window / behavior | Default after bootstrap | Verify in Kodi |
|---|------------|---------------------|-------------------------|----------------|
| 1 | **Search** (magnifier) | Opens search flow; visibility `!Skin.HasSetting(HomeSwitcher.DisableSearch)` | Visible | Icon left of text hubs; hidden if setting disables search |
| 2 | **Home** | `home` — always first text hub | Always shown | Label from `Skin.String(HomeSwitcher.Home.Name)` (upstream default unless changed) |
| 3 | **Series** | `ReplaceWindow(1101)` when `HomeSwitcher.1101.Toggle` set | On | Label **Series**; opens hub **1101** |
| 4 | **Movies** | `ReplaceWindow(1102)` when `HomeSwitcher.1102.Toggle` set | On | Label **Movies**; opens hub **1102** |
| 5 | **Hub slots 1103 / 1104** | Same pattern | **Off** (toggle cleared on init + each reload in startup rules) | Should **not** appear unless toggles re-enabled (skin settings / guided restore) |
| 6 | **Calendar / Up Next** | `ReplaceWindow(1106)` when toggle set | **Off** by default | When enabled: icon on right; hub **1106** |
| 7 | **Live TV** | `ReplaceWindow(1107)` when toggle set **and** `System.HasPVRAddon + PVR.HasTVChannels` | **Off** by default | May stay hidden if no PVR/channels even if toggle on |
| 8 | **Add-ons** | `ReplaceWindow(1108)` when toggle set | **Off** by default | When enabled: icon; click on hub may route to `ActivateWindow(addonbrowser)` per control logic |
| 9 | **Skin settings** | Settings control at end of right strip | Always | Opens home switcher / skin configuration as designed |

**Bootstrap source:** `shortcuts/skinvariables-startup.json` — first run sets `1101`/`1102` toggles, clears `1103`–`1108`, sets `LoopBack`, Velocity spotlight + shortcut paths; **every reload** also reapplies `1101`/`1102` toggles + names + shortcut paths and resets `1103`–`1108` toggles (lines ~49–59).

---

## 3) Hub window IDs (quick reference)

| ID | Roadmap / inventory name | Startup labels (when enabled) |
|----|---------------------------|-------------------------------|
| `Home` | Home | — |
| `1101` | Series hub | `Skin.String(HomeSwitcher.1101.Name)` → **Series** |
| `1102` | Movies hub | **Movies** |
| `1103` | Optional hub | cleared by default |
| `1104` | Optional hub | cleared by default |
| `1106` | Calendar / Up Next style mini-hub | toggle cleared by default |
| `1107` | PVR / Live TV | toggle cleared by default |
| `1108` | Add-ons | toggle cleared by default |

**View modes:** Empty `HomeSwitcher.<id>.Mode` is filled on first need — `1101`/`1102`/`1103`/`1104`/`1106` default **Standard**; `1107`/`1108` default **Wall** (`skinvariables-startup.json`).

---

## 4) Standard-mode widget rows (actual URLs in repo)

**Source:** `1080i/script-skinvariables-generator-overrides.xml` (overrides generator includes). Layout: `List_Landscape_Row` for these rows unless you switch hub mode in UI.

### 4.1 Home (`skinvariables-homewidgets-standard`)

| Order | Row label | Content URL |
|------:|-----------|-------------|
| 1 | Continue Watching | `plugin://plugin.video.velocity2/?action=smart_list&type=continue_watching` |
| 2 | Recently Watched | `…&type=recently_watched` |
| 3 | New Episodes | `…&type=new_episodes` |
| 4 | In Progress Movies | `…&type=in_progress_movies` |
| 5 | Discover | `…&action=discover` |
| 6 | Velocity Home | `…&action=home` |

**Kodi check:** From Home, focus widget stack — row titles and opening each row should hit Velocity with the query above.

**Spotlight / hero:** Driven by `Skin.String(HomeSwitcher.Home.Spotlight.*)` set in startup to Velocity `action=home` (separate from the stacked rows).

### 4.2 Series hub 1101 (`skinvariables-1101widgets-standard`)

| Order | Row label | `type=` |
|------:|-----------|---------|
| 1 | Continue Watching | `continue_watching` |
| 2 | New Episodes | `new_episodes` |
| 3 | Active Shows | `active_shows` |
| 4 | Up Next | `up_next` |
| 5 | Recently Watched | `recently_watched` |
| 6 | Discover | *(action=discover)* |

### 4.3 Movies hub 1102 (`skinvariables-1102widgets-standard`)

| Order | Row label | `type=` / action |
|------:|-----------|------------------|
| 1 | In Progress | `in_progress_movies` |
| 2 | Recently Watched | `recently_watched` |
| 3 | Continue Watching | `continue_watching` |
| 4 | Recent | `recent` |
| 5 | Discover | `discover` |
| 6 | Velocity Home | `home` |

### 4.4 Submenu strip (1101 / 1102)

Overrides define **`skinvariables-1101submenu-staticitems`** and **`skinvariables-1102submenu-staticitems`** (Velocity shortcuts). Quick check:

- **1101:** Continue Watching, New Episodes  
- **1102:** Continue Watching, Recently Watched  

---

## 5) Alignment gaps to log while testing (not blockers for “does it load?”)

| Topic | Plan / contract doc | Current skin behavior |
|--------|---------------------|------------------------|
| Feed naming | [screen-by-screen-build-contract.md](../screen-by-screen-build-contract.md) uses IDs like `series_spotlight_trending`, `home_spotlight_mixed` | Skin uses **Velocity** `smart_list` / `discover` / `home` — map in addon reference docs |
| Row set / order | Contract tables describe spotlight + in-progress tabs + provider rows + genres | **1101/1102/Home** rows match **overrides** (§4), not every contract row yet |
| “Mini-hubs” | Contract: per **streaming provider** roster | **1106–1108** in skin are **calendar/up next**, **PVR**, **addons** — different concept; treat contract mini-hub section as **future** unless product says otherwise |
| Optional hubs | Phase 03: default off | Still **implemented** if user sets toggles — OK, but QA should note if 1103/1104 reappear unexpectedly |

---

## 6) Minimal pass/fail checklist (copy for tickets)

- [ ] Top bar: Search (if enabled) + Home + **Series** + **Movies**; no 1103/1104/1106–1108 on clean profile after skin init  
- [ ] Home: six standard rows (§4.1) populate or show empty state; spotlight opens Velocity home path  
- [ ] 1101: six rows (§4.2); submenu two items  
- [ ] 1102: six rows (§4.3); submenu two items  
- [ ] No missing textures in log for submenu icons (e.g. `resume.png` if referenced elsewhere)  
- [ ] Document Phase 03 **blocked vs completed** in [README.md](./README.md) once team agrees with [phase-03-validation-report.md](./phase-03-validation-report.md)

---

## 7) Related files (for maintainers)

| Concern | File |
|---------|------|
| Switcher layout, focus, right icons | `1080i/Includes_Home.xml` |
| Hub widget / submenu XML | `1080i/script-skinvariables-generator-overrides.xml` |
| Bootstrap + skin strings | `shortcuts/skinvariables-startup.json` |
| Include order (overrides before generator) | `1080i/Includes.xml` |
| Home shortcut list parity | `shortcuts/skinvariables-shortcut-homewidgets.json` (should match Home rows) |
