# Feedback after completion of phases 1 to 7

## Purpose

This document captures post-phase validation findings, ownership (skin vs addon), implementation plan, and current execution progress.

---

## Issue ownership and fix approach

### 1) Menu items spacing and submenu removal
- **Observed**: Top menu spacing is too wide and submenus are still present.
- **Owner**: Skin
- **Primary files**: `1080i/Includes_Home.xml`
- **Fix approach**: Tighten menu object geometry and remove submenu entry points from home navigation.

### 2) Home and Series spotlight empty/inaccessible
- **Observed**: No hero background/title/plot; spotlight controls not reachable.
- **Owner**: Primarily skin, with addon validation checkpoints.
- **Evidence**: Kodi log shows `provider_netflix_show_spotlight` returning items (`-- items: 20`).
- **Primary files**: `1080i/Includes_Hubs.xml`, `1080i/Home.xml`
- **Fix approach**: Validate spotlight feeder container + focus chain + button actions.

### 3) Home widgets not stacked with tabs (`In ProgressNo results`)
- **Observed**: Tabs/stack behavior not matching contract; label concatenation with no-results.
- **Owner**: Skin
- **Primary files**: `1080i/script-skinvariables-generator-overrides.xml`, `1080i/Includes_Widgets.xml`, `1080i/Home.xml`
- **Fix approach**: Correct tab metadata bindings and guard label/no-results rendering.

### 4) Series metadata anomalies (repeated air date, invalid rating block, `unknown`)
- **Observed**: Repeated date fields and rating rendering issues.
- **Owner**: Both skin and addon
- **Primary files**:
  - Skin: `1080i/Includes_Info.xml`
  - Addon: `velocity_v2/lib/client/builder.py`
- **Fix approach**: De-duplicate info rendering paths in skin and normalize payload field handling in addon.

### 5) Provider icons aspect + provider hub structure mismatch
- **Observed**: Provider icons appear landscape instead of square; provider hub flow does not match contract structure.
- **Owner**: Both
- **Primary files**:
  - Skin layout/routing: series provider row templates and hub routing
  - Addon contracts/payload: `velocity_v2/lib/daemon/phase02_contracts.py`, `velocity_v2/lib/client/builder.py`
- **Fix approach**: Enforce square provider presentation and contract-compliant provider mini-hub routing.

---

## Execution order

1. Fix Step 1 parser/focus/texture blockers.
2. Fix menu spacing/submenu contract mismatch.
3. Fix spotlight navigation/data binding.
4. Fix tabs/widgets stack and label concatenation.
5. Fix series metadata formatting and provider hub behavior.

---

## Progress update

### Completed: Step 1 (blocking technical errors)

- **Expression parser issue fixed**
  - File: `1080i/Includes_Info.xml`
  - Updated malformed boolean grouping in rating visibility condition to valid Kodi condition syntax.

- **Invalid forced focus fixed**
  - File: `1080i/Includes_Actions.xml`
  - Guarded onload `SetFocus(500)` alarm with `Control.IsVisible(500)` to avoid focus errors when control is unavailable.

- **Missing tiled blur texture errors fixed**
  - File: `1080i/Includes_Background.xml`
  - Removed `-tiled.jpg` suffix expansion and now uses `$VAR[Image_Background]` directly.

### Completed: Step 2 (menu spacing + submenu removal)

- **Removed submenu activation from home navigation**
  - File: `1080i/Includes_Home.xml`
  - Replaced `ActivateWindow(1181)` entry points with `noop` in:
    - `Home_Horz_Movement` (`onup`, `oninfo`)
    - `Home_Vert_Movement` (`onleft`, `oninfo`)

- **Tightened menu geometry to reduce excessive item spacing**
  - File: `1080i/Includes_Home.xml`
  - Updated horizontal menu dimensions:
    - `Home_Object` width: `560 -> 360`
    - `Home_Focus_Faker` left/width: `-480/480 -> -320/320`
    - `Home_Spacer` left: `-560 -> -360`

### Next in queue

- Step 3: Spotlight container/focus/action wiring (`1080i/Includes_Hubs.xml`, `1080i/Home.xml`)
- Step 4: Tabs/widgets stack and no-results label behavior
- Step 5: Series metadata formatting and provider mini-hub contract behavior

---

## Notes

- `peripheral.xarcade` log errors are non-blocking for these UX issues.
- Addon routing/contracts exist for spotlight/provider families; remaining work is integration alignment and selected payload normalization.
