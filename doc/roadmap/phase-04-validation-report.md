# Phase 04 Validation Report

Phase doc reference:

- [Phase 04 - Skin Removal and Policy Enforcement](./phase-04-skin-removal-and-policy-enforcement.md)

Primary sources applied:

- [D-038 Legacy Property Ledger](../d038-legacy-property-ledger.md) (Batch A locked decisions)
- [Skin Vision Blueprint v0](../skin-vision-blueprint-v0.md) (D-021)
- [Screen-by-Screen Build Contract](../screen-by-screen-build-contract.md)

## Removal / policy diff summary by surface

| Surface | Policy / ledger | Change |
|--------|-------------------|--------|
| Expanded context menu | D-021 | `1080i/Dialog_DialogContextMenu.xml`: `has_menu` forced `false`; skin tray items removed; wiki variables removed; scrollbar `onright` targets grouplist `996` only. |
| OSD cast dialog | D-023 / Batch A | Deleted `1080i/Custom_1141_OSD_Cast.xml`. Removed all `1141` window references in listed collateral files + `shortcuts/builtins/skinvariables-closeosd.json`. OSD down chain ends with `noop` when bookmarks/cast chain exhausted; `VideoOSDBookmarks.xml` list `ondown` set to `noop`. |
| PVR dialogs (Batch A list) | D-024 / Batch A | Deleted: `Dialog_DialogPVRInfo.xml`, `DialogPVRInfo.xml`, `Dialog_DialogPVRGuideSearch.xml`, `DialogPVRGuideSearch.xml`, `DialogPVRChannelGuide.xml`, `DialogPVRChannelsOSD.xml`. Removed includes from `1080i/Includes.xml`. Dropped `DialogPVRInfo.xml` from `Defs_AutoScroll` parent condition in `Includes_Defaults.xml`. |
| Helper addon settings | D-036 / Batch A | `Settings.xml`: removed TMDbHelper settings row. `Includes_SkinSettings.xml`: removed helper dependency button and PVR TMDbHelper toggle block. |
| Wikipedia / crew helper windows | Batch A | Deleted `script-wikipedia.xml`, `Custom_1120_Dialog_SelectCrew.xml`. Removed `Path_Wikipedia_*` from `Includes_Paths.xml`. |
| Plot dialog 1113 | Batch A | Deleted `Custom_1113_Dialog_Plot.xml` after removing callers. `Includes_DialogInfo.xml`: removed Wikipedia overflow item, `DialogInfo_VideoButtons_Wikipedia`, music `onup` to `1113`, overflow Wikipedia include. `Dialog_DialogCustom.xml`: removed `Wikipedia` from info-options picker list. |
| Custom settings shell | Batch A | `Custom_1118_Dialog_Settings.xml`: removed `TMDbHelper.ContextMenu` onload. |

### Dead-caller remediation (Phase 04 gate)

Files touched only to sever references to removed windows (not Batch B/C/D scope work):

- `1080i/Includes_Actions.xml`, `Includes_Expressions.xml`, `Includes_Labels.xml`, `Dialog_DialogPlot.xml`, `Dialog_DialogCustom.xml`, `DialogSeekBar.xml`, `VideoOSDBookmarks.xml`, `Custom_1140_OSD_Playlist.xml`, `Includes_DialogInfo.xml`, `Includes_Defaults.xml`, `Includes_Paths.xml`

## Removed / unreachable surfaces (confirmed)

| Item | Status |
|------|--------|
| Window `1141` (OSD cast) | File removed; no remaining `Window.IsActive(1141)` / `Dialog.Close(1141)` in `1080i/` or skin shortcuts builtins. |
| `script-wikipedia.xml` | File removed; no `runscript(script.wikipedia` in `1080i/`. |
| Dialog `1113` (plot) | File removed; no `ActivateWindow(1113)` in repo skin XML. |
| `Custom_1120_Dialog_SelectCrew.xml` | File removed (no callers found pre-removal). |
| PVR XMLs in Batch A touch list | Files deleted; `Includes.xml` no longer includes deleted `_Dialog_*` PVR include files. |

## Traceability (appendix matrix)

- **D-021** → `1080i/Dialog_DialogContextMenu.xml` (no skin-expanded tray; no fallback actions).
- **D-038 Batch A** → deletions and edits above; collateral rows documented in this report.
- **Appendix verification ([appendix-verification-checklists.md](./appendix-verification-checklists.md))**
  - §4 Details/OSD: removals only; core OSD/playlist/bookmarks paths preserved aside from cast removal and `noop` down targets where cast was removed.
  - §5 Context/removal: D-021 enforced statically; wiki/crew/plot dialog paths removed; **PVR**: Batch A dialog files removed — see residual note.
  - §7 Residual dependency: no new `plugin.video.themoviedb.helper` settings entry points in touched settings files; `Includes_Labels.xml` still contains a `Container.PluginName` branch for that addon (pre-existing; not part of Phase 04 touch list).

## Phase 04 checklist (from phase doc)

| Check | Result |
|-------|--------|
| removed context actions inaccessible | **Pass (static)** — tray disabled; items removed. |
| no PVR surfaces reachable in normal UX | **Partial** — listed PVR *skin dialogs* removed; Kodi can still expose PVR via core IA; `Dialog_DialogPVRChannelManager.xml`, `Dialog_DialogPVRGroupManager.xml`, `MyPVR*.xml`, `Includes_Views_PVR.xml` remain. Documented as **residual scope** for operator Kodi session. |
| no wiki/crew helper dialogs reachable | **Pass (static)** — files removed; no wikipedia script calls in `1080i/`. |
| settings open without helper-specific entries | **Pass (static)** — helper row and skin-settings dependency block removed. |
| no dead menu entries to removed windows | **Pass (static)** — `grep` for `1113`, `1141`, deleted `DialogPVR*` filenames, `script-wikipedia` in active skin XML shows no dangling navigation (string `#31113` in views is localize id only). |

## Acceptance criteria (phase doc)

| Criterion | Result |
|-----------|--------|
| all Batch A removals implemented | **Pass** for D-038 Batch A rows tied to Phase 04 touch files + required collateral. |
| D-021 exactly enforced | **Pass** — skin-expanded items removed; no skin fallback; addon/Kodi context list unchanged by this work. |
| no policy regressions in details/OSD/search core UX | **Pass (static)** — intentional removal of cast + small plot window + wiki; details overflow picker updated. |

## Residual / follow-up

1. **PVR (broader than Phase 04 file list):** If product intent is zero PVR anywhere in the fork, a later phase should remove `Includes_Views_PVR.xml`, `MyPVR*.xml`, and remaining `Dialog_DialogPVR*Manager` includes from `Includes.xml`, plus OSD conditions naming `pvrosdguide` / `pvrosdchannels` / `pvrchannelguide`.
2. **Runtime:** Hub/OSD/context journeys were not executed in this environment; validate in Kodi per [kodi-ui-verification-matrix.md](./kodi-ui-verification-matrix.md).

## Blocker report

None. Residual PVR scope is documented above; it does not block Batch A file completion per locked ledger touch list.

## Final Phase 04 result

- Acceptance criteria: **pass** (with documented PVR residual scope).
- Phase status recommendation: **completed**.
- Unresolved blockers: **none**.
