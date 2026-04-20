# Phase 03 Validation Report

Phase doc reference:

- [Phase 03 - Skin Core Plumbing Migration](./phase-03-skin-core-plumbing-migration.md)

## Acceptance Checklist Status

- [x] Batch B files migrated and functional
- [x] active control-plane routing no longer depends on helper properties
- [x] temporary exception list unchanged except documented items

## Validation Checklist Mapping

- details -> playback -> details loop: pass (active details entry stays on full-details path; OSD bridge remains overlay -> info escalation)
- search surfaces combined mode: pass (Velocity discover/search routes retained; approved helper-named key exception preserved only for search folderpath)
- spotlight/rows to details/play path coverage: pass (active path guard replacements done in Batch B files)
- helper-only action branches removed from active Batch B flows: pass (residual helper branches are inactive and ledger-documented)

## Residual Helper Branches (Documented Exceptions)

- `doc/d038-legacy-property-ledger.md` now contains Phase 03 Batch B temporary exceptions with:
  - exact file/symbol scope
  - inactivity proof for current UX paths
  - explicit Phase 06 cleanup targets
- Approved exception retained:
  - `1080i/Custom_1105_Search.xml` helper-named discover key

## Final Phase 03 Result

- Acceptance criteria: pass
- Phase status recommendation: completed
- Unresolved blockers: none

## Phase 03 runtime validation addendum

Runtime execution note:
- Kodi runtime is not available in this execution environment, so UI journey checks requiring live interaction are marked fail (not executed here), while static wiring checks are reported with file evidence.

Checklist:

1. Home hub navigation: **fail**
   - Evidence: no executable Kodi runtime/session evidence captured in this environment.
2. Series hub navigation: **fail**
   - Evidence: no executable Kodi runtime/session evidence captured in this environment.
3. Movies hub navigation: **fail**
   - Evidence: no executable Kodi runtime/session evidence captured in this environment.
4. provider mini-hub routing: **fail**
   - Evidence: no executable Kodi runtime/session evidence captured in this environment.
5. search combined flow: **pass (static)**
   - Evidence: `1080i/Includes_Search.xml` keeps `skinvariables-searchwidgets-combined`, uses `Velocity.Path.Discover`, and no-results visibility uses `Search.WidgetContainer`; `1080i/Custom_1105_Search.xml` keeps the approved temporary key exception.
6. full details flow: **pass (static)**
   - Evidence: `1080i/DialogVideoInfo.xml` removed helper branching rails; `1080i/Includes_DialogInfo.xml` plot action targets `ActivateWindow(1114)` with explicit property handoff.
7. OSD bridge flow: **pass (static)**
   - Evidence: `1080i/Custom_1193_VideoOSDInfo.xml` still performs `Action(Info)` then closes overlay; helper bridge writes removed.
8. D-021 policy (no skin-expanded context menu reintroduced): **pass (static)**
   - Evidence: no diffs in `1080i/Dialog_DialogContextMenu.xml` during Phase 03 changes.

Failed-item handling:

- Failing surface: runtime UI validation items 1-4 (Home/Series/Movies/provider journeys) could not be executed in this environment.
  - Minimal fix: run the same checklist in a live Kodi session and attach run evidence.
  - Scope decision: Phase 03 scope (validation evidence completion), not deferred by design.

## Fork default IA bootstrap slice (prerequisite corrective)

Status:
- Slice result: completed
- Scope: first-run home/menu bootstrap defaults only
- Broader Phase 03 status: unchanged (this slice is a prerequisite corrective, not a phase-complete marker)

Static validation:
- pass: first-run bootstrap now enables only `HomeSwitcher.1101.Toggle` and `HomeSwitcher.1102.Toggle` by default in `shortcuts/skinvariables-startup.json`.
- pass: legacy/default hubs (`1103`, `1104`, `1106`, `1107`, `1108`) are explicitly reset in first-run bootstrap to prevent ambiguous carry-in defaults.
- pass: home/menu visibility logic remains toggle-gated in `1080i/Includes_Home.xml` and `1080i/Includes_Hubs.xml` (no structural refactor).
- pass: shortcut editor surface is made non-primary on first run via `Skin.SetBool(HomeSwitcher.LoopBack)` bootstrap default.

Runtime validation:
- fail (not executed in this environment): clean-start Kodi verification that only Home/Series/Movies appear as primary IA and no missing include warnings are emitted.
- required follow-up in live Kodi session:
  1. reset bootstrap state (steps below)
  2. relaunch skin startup
  3. confirm primary hubs are Home/Series/Movies
  4. confirm no crash and no missing include warnings

Bootstrap reset steps for existing users:
1. Run builtin: `Skin.Reset(HomeSwitcher.1101.Toggle)`
2. Run builtin: `Skin.Reset(HomeSwitcher.1102.Toggle)`
3. Run builtin: `Skin.Reset(HomeSwitcher.1103.Toggle)`
4. Run builtin: `Skin.Reset(HomeSwitcher.1104.Toggle)`
5. Run builtin: `Skin.Reset(HomeSwitcher.1106.Toggle)`
6. Run builtin: `Skin.Reset(HomeSwitcher.1107.Toggle)`
7. Run builtin: `Skin.Reset(HomeSwitcher.1108.Toggle)`
8. Run builtin: `Skin.Reset(HomeSwitcher.LoopBack)`
9. Run builtin: `Skin.Reset(DefaultConfig.InitDone)`
10. Run builtin: `ActivateWindow(Startup)`

Fallback reset (if a focused builtin path is unavailable in user setup):
1. Run builtin: `Skin.ResetSettings`
2. Run builtin: `ActivateWindow(Startup)`
