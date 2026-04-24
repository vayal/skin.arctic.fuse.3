# D-038 Legacy Property Ledger

Purpose:
- Track `TMDbHelper.*` / `TMDBHelper.*` and other legacy property-model references.
- Decide per reference: `remove`, `replace`, `keep-temporary`.
- Document replacement path or exception rationale.

Status:
- Complete file-level sweep (decision-ready) for `1080i/`.

Decision legend:
- `remove`: delete usage; no replacement needed.
- `replace`: swap to velocity/native contract.
- `keep-temporary`: retained for compatibility until explicit follow-up.

---

## 1) Sweep summary

Detected legacy surfaces:
- 46 files with `TMDbHelper.*` / `TMDBHelper.*` references.
- 11 files with `Exp_TMDbHelper*` / `Exp_TMDBHelper*` expression references.
- 3 files with explicit `plugin.video.themoviedb.helper` addon-id references.

Default transfer policy used in this ledger:
- `replace`: active UX path still needed but must move to Velocity/native contracts.
- `remove`: deprecated/helper-era path or explicitly removed by blueprint decisions.
- `keep-temporary`: allowed only when active UX depends on it and no safe immediate replacement exists.

---

## 2) Complete file-level ledger

| File | TMDb refs | Legacy role | Proposed decision | Transfer plan / note | Status |
|---|---:|---|---|---|---|
| `1080i/Includes_Images.xml` | 152 | artwork/status/blur/property-heavy rendering | replace | rebind image/status/blur variables to Velocity/native list item fields; remove helper widget container property coupling | locked-batch-c |
| `1080i/Includes_Labels.xml` | 130 | metadata text labels (director/writer/network/status) | replace | map labels to Velocity/native properties; remove helper-only label branches and helper addon-id label checks | locked-batch-c |
| `1080i/Includes_Paths.xml` | 77 | path/query/monitor/ID contract hub | replace | replace helper monitor/tmdb-id properties with Velocity route and canonical IDs; drop helper-null routing remnants | locked-batch-b |
| `1080i/Includes_Actions.xml` | — | action dispatch + scheme color actions | replace/remove | Phase 06: `Action_Skin_LegacyBlurDataToggle_Onclick` (noop); scheme onclick uses `Skin.HasSetting(TMDbHelper.EnableBlur)` instead of `Exp_TMDbHelper_IsBlur` | phase-06-partial |
| `1080i/Includes_DialogInfo.xml` | 49 | details/person/crew rails and dialogs | remove/replace | remove helper-heavy person/crew rails; keep only curated full-details content bound to Velocity contracts | phase-07-reconciled-partial — `DialogInfo_CrewItem` still binds `Window(Home).Property(TMDbHelper.ListItem.*)`; used from `Dialog_DialogView.xml` writer/director modes (see §4) |
| `1080i/Includes_Overlay.xml` | 30 | overlay labels/images tied to helper properties | replace | rebind overlays to native/Velocity item properties; prune helper-only overlays | locked-batch-c |
| `1080i/Includes_Info.xml` | 20 | info panel fields and helper-expression-gated UI | replace | migrate info fields/guards to Velocity/native expressions | locked-batch-c |
| `1080i/Dialog_DialogCustom.xml` | 19 | custom dialog router with helper expression gates | replace/remove | remove helper-only dialog branches; keep only retained settings/actions routes | phase-07-reconciled-partial — legacy blur/TMDbHelper-labeled controls remain for CustomDialog skin-settings shells; not Velocity list routing |
| `1080i/Includes_Hubs.xml` | 0 | hub visibility/metadata expressions | replace | remove helper-expression dependencies in hub widgets/spotlight logic | phase-07-verified — no `TMDbHelper`/`Exp_TMDbHelper` substrings in current `1080i/Includes_Hubs.xml` |
| `1080i/Dialog_DialogContextMenu.xml` | 12 | expanded context menu item visibility and metadata | remove | D-021 locked: remove expanded skin items and helper property guards; rely on addon context items | phase-07-verified — `has_menu` forced `false` (D-021); header/poster still read `TMDbHelper.ListItem.base_*` when `$EXP[Exp_AllowExpandedContextMenu]` (see §4) |
| `1080i/Includes_Views_Combined.xml` | 5 | combined view labels/info bindings | replace | map to native/Velocity labels; remove helper aliases | locked-batch-c |
| `1080i/Includes_Widgets.xml` | 4 | widget info bindings | replace | migrate widget info fields to Velocity/native properties | locked-batch-c |
| `1080i/Includes_Expressions.xml` | 4 | core helper expressions (`Exp_TMDbHelper_*`) | replace/keep-temporary | replace expressions where possible; keep temporary only with explicit per-expression reason | phase-07-reconciled — **keep-temporary** (see §4): maps legacy `Skin.HasSetting(TMDbHelper.*)` bool namespace |
| `1080i/Custom_1141_OSD_Cast.xml` | 4 | OSD cast helper paths/properties | remove | aligned with removal of OSD cast dialog | locked-batch-a |
| `1080i/Settings.xml` | 3* | helper addon settings entry | remove | remove `plugin.video.themoviedb.helper` settings link | locked-batch-a |
| `1080i/Dialog_DialogPVRInfo.xml` | 2 | helper-based info actions in PVR path | remove | aligned with full PVR removal decision | locked-batch-a |
| `1080i/Dialog_DialogPlot.xml` | 2 | helper mode/path in plot/details bridge | replace/remove | simplify to full-details flow only | locked-batch-b |
| `1080i/Custom_1193_VideoOSDInfo.xml` | 2 | playback info bridge helper fields | replace | keep overlay->details flow; bind to Velocity/native metadata | locked-batch-b |
| `1080i/Includes_Search.xml` | 1 | discover path via `Window(Home).Property(TMDbHelper.UserDiscover.FolderPath)` | keep-temporary/replace | paired with `Custom_1105_Search.xml`; Velocity discover path; rename key deferred | keep-temporary |
| `1080i/Includes_SkinSettings.xml` | 2* | helper settings and helper addon-id visibility | remove | remove helper settings entries while preserving non-helper UX settings | phase-07-reconciled-partial — main `Settings.xml` helper addon-id rows removed (Phase 04); **Details** block still shows TMDbHelper-labeled service toggle + ratings entries gated by `$EXP[Exp_TMDbHelper_IsData]` |
| `1080i/Home.xml` | 2 | home expressions bound to helper info | replace | map to native/Velocity properties | locked-batch-c |
| `1080i/Custom_1140_OSD_Playlist.xml` | 0 | helper-linked playlist fields | remove | aligned with playlist OSD removal | phase-07-verified — no `TMDbHelper` substring in current file (ledger count stale) |
| `1080i/Custom_1105_Search.xml` | 2 | helper-named discover property key | keep-temporary/replace | Velocity `plugin://plugin.video.velocity2/?action=discover` onload; rename deferred (Batch D: no rename in Phase 06) | keep-temporary |
| `1080i/Custom_1114_Dialog_CustomPlot.xml` | 1 | helper path in custom plot dialog | remove/replace | simplify custom plot path to full-details model | locked-batch-b |
| `1080i/DialogVideoInfo.xml` | 1 | helper expression/property guard in details dialog | replace | map remaining guard to Velocity/native expression | locked-batch-b |
| `1080i/script-wikipedia.xml` | 1 | helper base-title dependency for wiki | remove | Wiki flow removed from context strategy | locked-batch-a |
| `1080i/MyWeather.xml` | — | helper property branch in weather screen | remove | file deleted; routes severed (Phase 06) | removed |
| `1080i/Includes_Views.xml` | 1 | helper label in views | replace | migrate to non-helper label variable | locked-batch-c |
| `1080i/Includes_Views_List.xml` | 1 | helper-bound list view field | replace | migrate to native/Velocity label/property | locked-batch-c |
| `1080i/Includes_Views_Row.xml` | 1 | helper-bound row view field | replace | migrate to native/Velocity label/property | locked-batch-c |
| `1080i/Includes_Home.xml` | 1 | helper field in home include | replace | remove helper label/property dependencies in home shell | locked-batch-c |
| `1080i/Includes_Views_Wall.xml` | 1 | helper-bound wall view field | replace | migrate to native/Velocity label/property | locked-batch-c |
| `1080i/Includes_Lists.xml` | 1 | helper property in list include | replace | bind to velocity/native equivalent | locked-batch-c |
| `1080i/DialogPVRChannelGuide.xml` | 1 | helper field in PVR guide | remove | aligned with PVR removal | locked-batch-a |
| `1080i/DialogPVRGuideSearch.xml` | 1 | helper field in PVR guide search | remove | aligned with PVR removal | locked-batch-a |
| `1080i/DialogPVRChannelsOSD.xml` | 1 | helper field in PVR OSD | remove | aligned with PVR removal | locked-batch-a |
| `1080i/Custom_1171_Dialog_Views.xml` | 1 | helper field in views dialog | replace | migrate to non-helper view metadata | locked-batch-c |
| `1080i/Custom_1170_Dialog_Options.xml` | 1 | helper field in options dialog | replace | migrate to non-helper metadata | locked-batch-c |
| `1080i/Custom_1160_Dialog_Favourites.xml` | 1 | helper field in favourites dialog | replace | migrate to non-helper metadata | locked-batch-c |
| `1080i/Custom_1161_Dialog_Weather.xml` | — | helper field in weather dialog | remove | file deleted; `ActivateWindow(1161)` / weather shortcuts removed (Phase 06) | removed |
| `1080i/Custom_1122_Dialog_SelectTrailer.xml` | 1 | helper trailer metadata in selector | replace | keep trailer UX; bind to velocity/native fields | locked-batch-c |
| `1080i/Custom_1123_Dialog_Trailer.xml` | 1 | helper trailer metadata | replace | retain trailer dialog for future use; rebind to velocity/native fields | locked-batch-c |
| `1080i/Custom_1120_Dialog_SelectCrew.xml` | 1 | helper crew metadata | remove | aligned with person/crew rail removal | locked-batch-a |
| `1080i/Custom_1113_Dialog_Plot.xml` | 1 | helper plot metadata | replace/remove | simplify first to align with no-small-dialog model, then remove if no remaining dependency | locked-batch-a |
| `1080i/Custom_1118_Dialog_Settings.xml` | 1 | helper-linked settings branch | remove/replace | remove helper-only branch; keep generic settings routing | locked-batch-a |
| `1080i/Custom_1172_Dialog_InfoOptions.xml` | 1 | helper field in info options dialog | replace | map options to retained details model | locked-batch-c |
| `1080i/Custom_1180_Dialog_Bumper.xml` | 1 | `TMDbHelper.ContextMenu` onload | keep-temporary/replace | no behavioral change Phase 06; replace when bumper flow is redesigned | keep-temporary |
| `1080i/Includes_OSD.xml` | 2 | helper references in OSD include | replace/remove | retain only normal OSD controls with non-helper bindings | phase-07-reconciled-partial — `TMDbHelper.Player.CropImage` passed as crop logo param (see §4) |
| `shortcuts/skinvariables-shortcut-config.json` | — | shortcut editor preset nodes | keep-temporary | `plugin://plugin.video.themoviedb.helper/*` paths; gated by addon presence | phase-07-documented — legacy SkinShortcuts editor presets (see §4) |
| `shortcuts/generator/data/setup/search_path.xml` | — | generator search templates | keep-temporary | helper `plugin://plugin.video.themoviedb.helper` URLs in XML values | phase-07-documented — generator data (see §4) |
| `shortcuts/generator/data/setup/widgets_row.xml` | — | generator widget templates | keep-temporary | helper recommendation/discover URLs in templates | phase-07-documented — generator data (see §4) |

\* `Settings.xml` no longer includes explicit `plugin.video.themoviedb.helper` addon-id references (Phase 04). `Includes_SkinSettings.xml` may still reference helper **expression** names (`Exp_TMDbHelper_*`) for visibility gating.

Notes:
- Counts are from automated grep sweep and represent helper/property string occurrences.
- `Includes_Images.xml` and other files with helper expressions are covered in the same file row (no separate duplicate rows).

---

## 3) Implementation transfer batches (planning-ready)

### Batch A decisions (locked)

- `Dialog_DialogContextMenu.xml` -> remove
- `Custom_1141_OSD_Cast.xml` -> remove
- PVR family (`Dialog_DialogPVRInfo.xml`, `DialogPVR*`) -> remove
- helper addon settings entries in `Settings.xml` and `Includes_SkinSettings.xml` -> remove
- helper-only crew/wikipedia surfaces (`script-wikipedia.xml`, `Custom_1120_Dialog_SelectCrew.xml`) -> remove
- `Custom_1118_Dialog_Settings.xml` helper-only branch -> remove helper-only branch, keep generic settings routing
- `Custom_1113_Dialog_Plot.xml` -> simplify first, then remove if no remaining dependency

Batch A (remove-first, low risk):
- `Dialog_DialogContextMenu.xml`
- `Custom_1141_OSD_Cast.xml`
- PVR family (`Dialog_DialogPVRInfo.xml`, `DialogPVR*`)
- helper addon settings entries in `Settings.xml` and `Includes_SkinSettings.xml`
- helper-only crew/wikipedia surfaces (`script-wikipedia.xml`, `Custom_1120_Dialog_SelectCrew.xml`)

Batch B (replace core contracts):
- `Includes_Paths.xml`
- `Includes_Actions.xml`
- `Includes_DialogInfo.xml`
- `DialogVideoInfo.xml`, `Dialog_DialogPlot.xml`, `Custom_1114_Dialog_CustomPlot.xml`
- `Custom_1193_VideoOSDInfo.xml`

### Batch B decisions (locked)

- `Includes_Paths.xml` -> replace helper monitor/tmdb-id property plumbing with Velocity/native canonical ID/routing contracts.
- `Includes_Actions.xml` -> keep minimal dispatch only; remove helper service/blur/rating toggles.
- `Includes_DialogInfo.xml` -> replace/remove helper-heavy details rails; retain curated full-details content only.
- `DialogVideoInfo.xml` -> replace remaining helper guards with Velocity/native expressions.
- `Dialog_DialogPlot.xml` -> simplify to full-details flow and remove helper mode/path dependencies.
- `Custom_1114_Dialog_CustomPlot.xml` -> simplify/remove helper path usage aligned to full-details flow.
- `Custom_1193_VideoOSDInfo.xml` -> replace helper-linked metadata while preserving overlay->details behavior.
- `Includes_Search.xml` -> replace helper search guards/properties while preserving combined search UX.
- `Custom_1105_Search.xml` -> keep helper-named key temporarily (B9A), but keep Velocity-target routing and plan later rename.

Batch C (metadata/rendering migration):
- `Includes_Images.xml`
- `Includes_Labels.xml`
- `Includes_Info.xml`
- `Includes_Overlay.xml`
- remaining `Includes_Views*`, `Includes_Widgets.xml`, `Includes_Lists.xml`, `Home.xml`

### Batch C decisions (locked)

- `Includes_Images.xml` -> replace helper image/blur/status dependencies with Velocity/native metadata fields.
- `Includes_Labels.xml` -> replace helper-derived labels with Velocity/native payload fields.
- `Includes_Info.xml` -> replace helper expression-gated fields with Velocity/native expressions/properties.
- `Includes_Overlay.xml` -> replace helper-bound overlay labels/artwork bindings.
- `Includes_Views*` (`Includes_Views.xml`, `Includes_Views_List.xml`, `Includes_Views_Row.xml`, `Includes_Views_Wall.xml`, `Includes_Views_Combined.xml`) -> replace helper aliases/label sources.
- `Includes_Widgets.xml` -> replace helper widget info bindings.
- `Includes_Lists.xml` -> replace helper list property usage.
- `Home.xml` and `Includes_Home.xml` -> replace remaining helper-bound home labels/properties.
- `Custom_1171_Dialog_Views.xml`, `Custom_1170_Dialog_Options.xml`, `Custom_1160_Dialog_Favourites.xml`, `Custom_1172_Dialog_InfoOptions.xml` -> replace helper metadata dependencies.
- Trailer dialogs retained for future use:
  - `Custom_1122_Dialog_SelectTrailer.xml` -> replace to Velocity/native trailer fields.
  - `Custom_1123_Dialog_Trailer.xml` -> replace to Velocity/native trailer fields.

Batch D (deferred/keep-temporary review):
- Weather and bumper surfaces (`MyWeather.xml`, `Custom_1161_Dialog_Weather.xml`, `Custom_1180_Dialog_Bumper.xml`)
- `Custom_1105_Search.xml` helper-named property key rename (if still desired after functional parity).

### Batch D decisions (locked)

- `Custom_1105_Search.xml` -> keep-temporary helper-named key for now; keep Velocity routing; rename in later cleanup if needed.
- `MyWeather.xml` -> remove (never used in target fork).
- `Custom_1161_Dialog_Weather.xml` -> remove (never used in target fork).
- `Custom_1180_Dialog_Bumper.xml` -> keep-temporary for now; replace when bumper flow is touched.

---

## 4) Exception policy

Allowed `keep-temporary` only when all are true:
- replacing now would break active UX.
- no safe native/Velocity replacement available in this phase.
- clear follow-up task exists with owner and target milestone.

No undocumented exceptions.

### Phase 03 Batch B active-path temporary exceptions (documented for Phase 06 cleanup)

**Resolved in Phase 03 completion:** dead `DialogInfo_*` video widget rails (`DialogInfo_VideoWidgets` / `DialogInfo_PersonWidgets` / `DialogInfo_CrewWidget` / `DialogInfo_VideoDetails`), the unmounted `DialogInfo_GalleryWidget` tree, and dependent `DialogInfo_VideoFanartContent` / `DialogInfo_PersonImageContent` stubs were removed from `1080i/Includes_DialogInfo.xml`; unused `Path_VideoInfo_*` / `Path_FromWriter` / `Path_FromDirector` variables were removed from `1080i/Includes_Paths.xml` after grep showed no remaining references.

| File | Residual helper symbol(s) | Inactivity proof in current UX (Home/Series/Movies/provider/search/details/OSD bridge) | Cleanup target |
|---|---|---|---|
| `1080i/Includes_Actions.xml` | (resolved) | Scheme actions still optional (skin customization). | **Done (Phase 06):** legacy noop include renamed to `Action_Skin_LegacyBlurDataToggle_Onclick`; scheme `onclick` blur branches use `Skin.HasSetting(TMDbHelper.EnableBlur)` instead of `$EXP[Exp_TMDbHelper_IsBlur]`. |
| `1080i/Includes_Search.xml` + `1080i/Custom_1105_Search.xml` | `TMDbHelper.UserDiscover.FolderPath` (+ `.Name` label in `Custom_1105_Search`) | Explicitly approved temporary key exception for combined search discover wiring; route target is Velocity (`plugin://plugin.video.velocity2/?action=discover`). | **Still deferred:** rename helper-named Home property keys to a neutral namespace — target post-Phase-07 rename slice (no rename in Phase 07 validation-only pass). |

### Phase 06 Batch D — approved `keep-temporary` symbols (exception list)

| Symbol / surface | Location | Rationale | Follow-up |
|---|---|---|---|
| `TMDbHelper.UserDiscover.FolderPath`, `TMDbHelper.UserDiscover.FolderPath.Name` | `Custom_1105_Search.xml` onload | Combined discover wiring; Velocity path | Rename keys when Batch D follow-up scheduled |
| `Window(Home).Property(TMDbHelper.UserDiscover.FolderPath)` | `Includes_Search.xml` discover content | Consumer of same property | Same rename as row above |
| `TMDbHelper.ContextMenu` | `Custom_1180_Dialog_Bumper.xml` onload | Bumper flow unchanged Phase 06 | Replace when bumper flow is touched |
| `Skin.HasSetting(TMDbHelper.EnableBlur)` | `Includes_Actions.xml` scheme onclick | Legacy skin.bool name; inline guard replaces expression name only in scheme block | Migrate bool namespace in Phase 07 if settings keys are renamed |

### Phase 07 — additional documented `keep-temporary` / residual symbols

| Symbol / surface | Location | Rationale | Follow-up |
|---|---|---|---|
| `Window(Home).Property(TMDbHelper.ListItem.base_label)` / `base_poster` | `Dialog_DialogContextMenu.xml` | Dialog chrome only; D-021 tray list remains disabled (`has_menu` false) | Replace with neutral property names when context dialog model is redesigned |
| `DialogInfo_CrewItem` → `TMDbHelper.ListItem.{type}.{n}.*` | `Includes_DialogInfo.xml` | Writer/director crew strip in `Dialog_DialogView.xml` | Replace with Velocity/native person list handoff (Phase 05 follow-up or dedicated slice) |
| `$EXP[Exp_TMDbHelper_IsBlur]` | `Includes_Background.xml` | FlixArt / blur quadrants vs flat background | Collapse to neutral bool or Velocity art policy when background stack is migrated |
| `TMDbHelper.Player.CropImage` | `Includes_OSD.xml` | OSD crop logo param | Bind to native `VideoPlayer` / ListItem art when crop path is available |
| TMDbHelper preset nodes + `plugin://plugin.video.themoviedb.helper/*` | `shortcuts/skinvariables-shortcut-config.json` | Shortcut editor library; rules gate on helper addon presence | Remove or replace with Velocity nodes when shortcut editor is forked |
| Helper URLs in generator templates | `shortcuts/generator/data/setup/search_path.xml`, `widgets_row.xml`, etc. | Upstream SkinVariables generator data | Audit active hub widget generation vs `script-skinvariables-generator-overrides.xml`; replace templates if still referenced |

---

## 5) Completion criteria for D-038

D-038 can move from `modify` to `accept` when:
- every active helper property usage is represented in this ledger,
- all entries are marked `remove` or `replace`, except explicitly justified `keep-temporary`,
- replacements/exceptions are implemented and trace-linked.

