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
| `1080i/Includes_Images.xml` | 152 | artwork/status/blur/property-heavy rendering | replace | rebind image/status/blur variables to Velocity/native list item fields; remove helper widget container property coupling | open |
| `1080i/Includes_Labels.xml` | 130 | metadata text labels (director/writer/network/status) | replace | map labels to Velocity/native properties; remove helper-only label branches and helper addon-id label checks | open |
| `1080i/Includes_Paths.xml` | 77 | path/query/monitor/ID contract hub | replace | replace helper monitor/tmdb-id properties with Velocity route and canonical IDs; drop helper-null routing remnants | locked-batch-b |
| `1080i/Includes_Actions.xml` | 58 | action dispatch + helper service/blur/rating toggles | replace/remove | keep minimal action dispatch; remove helper service/ratings toggles and helper blur property writes | locked-batch-b |
| `1080i/Includes_DialogInfo.xml` | 49 | details/person/crew rails and dialogs | remove/replace | remove helper-heavy person/crew rails; keep only curated full-details content bound to Velocity contracts | locked-batch-b |
| `1080i/Includes_Overlay.xml` | 30 | overlay labels/images tied to helper properties | replace | rebind overlays to native/Velocity item properties; prune helper-only overlays | open |
| `1080i/Includes_Info.xml` | 20 | info panel fields and helper-expression-gated UI | replace | migrate info fields/guards to Velocity/native expressions | open |
| `1080i/Dialog_DialogCustom.xml` | 19 | custom dialog router with helper expression gates | replace/remove | remove helper-only dialog branches; keep only retained settings/actions routes | open |
| `1080i/Includes_Hubs.xml` | 17 | hub visibility/metadata expressions | replace | remove helper-expression dependencies in hub widgets/spotlight logic | open |
| `1080i/Dialog_DialogContextMenu.xml` | 12 | expanded context menu item visibility and metadata | remove | D-021 locked: remove expanded skin items and helper property guards; rely on addon context items | locked-batch-a |
| `1080i/Includes_Views_Combined.xml` | 5 | combined view labels/info bindings | replace | map to native/Velocity labels; remove helper aliases | open |
| `1080i/Includes_Widgets.xml` | 4 | widget info bindings | replace | migrate widget info fields to Velocity/native properties | open |
| `1080i/Includes_Expressions.xml` | 4 | core helper expressions (`Exp_TMDbHelper_*`) | replace/keep-temporary | replace expressions where possible; keep temporary only with explicit per-expression reason | open |
| `1080i/Custom_1141_OSD_Cast.xml` | 4 | OSD cast helper paths/properties | remove | aligned with removal of OSD cast dialog | locked-batch-a |
| `1080i/Settings.xml` | 3* | helper addon settings entry | remove | remove `plugin.video.themoviedb.helper` settings link | locked-batch-a |
| `1080i/Dialog_DialogPVRInfo.xml` | 2 | helper-based info actions in PVR path | remove | aligned with full PVR removal decision | locked-batch-a |
| `1080i/Dialog_DialogPlot.xml` | 2 | helper mode/path in plot/details bridge | replace/remove | simplify to full-details flow only | locked-batch-b |
| `1080i/Custom_1193_VideoOSDInfo.xml` | 2 | playback info bridge helper fields | replace | keep overlay->details flow; bind to Velocity/native metadata | locked-batch-b |
| `1080i/Includes_Search.xml` | 2 | search helper properties/guards | replace | preserve combined search UX with Velocity/native contracts | locked-batch-b |
| `1080i/Includes_SkinSettings.xml` | 2* | helper settings and helper addon-id visibility | remove | remove helper settings entries while preserving non-helper UX settings | locked-batch-a |
| `1080i/Home.xml` | 2 | home expressions bound to helper info | replace | map to native/Velocity properties | open |
| `1080i/Custom_1140_OSD_Playlist.xml` | 2 | helper-linked playlist fields | remove | aligned with playlist OSD removal | open |
| `1080i/Custom_1105_Search.xml` | 2 | helper-named discover property key | keep-temporary/replace | keep key temporarily if harmless; ensure target route is Velocity and plan rename later | locked-batch-b |
| `1080i/Custom_1114_Dialog_CustomPlot.xml` | 1 | helper path in custom plot dialog | remove/replace | simplify custom plot path to full-details model | locked-batch-b |
| `1080i/DialogVideoInfo.xml` | 1 | helper expression/property guard in details dialog | replace | map remaining guard to Velocity/native expression | locked-batch-b |
| `1080i/script-wikipedia.xml` | 1 | helper base-title dependency for wiki | remove | Wiki flow removed from context strategy | locked-batch-a |
| `1080i/MyWeather.xml` | 1 | helper property branch in weather screen | keep-temporary/replace | out-of-scope screen now; document and replace when weather scope opens | open |
| `1080i/Includes_Views.xml` | 1 | helper label in views | replace | migrate to non-helper label variable | open |
| `1080i/Includes_Views_List.xml` | 1 | helper-bound list view field | replace | migrate to native/Velocity label/property | open |
| `1080i/Includes_Views_Row.xml` | 1 | helper-bound row view field | replace | migrate to native/Velocity label/property | open |
| `1080i/Includes_Home.xml` | 1 | helper field in home include | replace | remove helper label/property dependencies in home shell | open |
| `1080i/Includes_Views_Wall.xml` | 1 | helper-bound wall view field | replace | migrate to native/Velocity label/property | open |
| `1080i/Includes_Lists.xml` | 1 | helper property in list include | replace | bind to velocity/native equivalent | open |
| `1080i/DialogPVRChannelGuide.xml` | 1 | helper field in PVR guide | remove | aligned with PVR removal | locked-batch-a |
| `1080i/DialogPVRGuideSearch.xml` | 1 | helper field in PVR guide search | remove | aligned with PVR removal | locked-batch-a |
| `1080i/DialogPVRChannelsOSD.xml` | 1 | helper field in PVR OSD | remove | aligned with PVR removal | locked-batch-a |
| `1080i/Custom_1171_Dialog_Views.xml` | 1 | helper field in views dialog | replace | migrate to non-helper view metadata | open |
| `1080i/Custom_1170_Dialog_Options.xml` | 1 | helper field in options dialog | replace | migrate to non-helper metadata | open |
| `1080i/Custom_1160_Dialog_Favourites.xml` | 1 | helper field in favourites dialog | replace | migrate to non-helper metadata | open |
| `1080i/Custom_1161_Dialog_Weather.xml` | 1 | helper field in weather dialog | keep-temporary/replace | weather not in current focus; replace in weather pass | open |
| `1080i/Custom_1122_Dialog_SelectTrailer.xml` | 1 | helper trailer metadata in selector | replace | keep trailer UX only if retained elsewhere; bind to velocity/native fields | open |
| `1080i/Custom_1123_Dialog_Trailer.xml` | 1 | helper trailer metadata | replace/remove | if trailer dialog retained, rebind; otherwise remove | open |
| `1080i/Custom_1120_Dialog_SelectCrew.xml` | 1 | helper crew metadata | remove | aligned with person/crew rail removal | locked-batch-a |
| `1080i/Custom_1113_Dialog_Plot.xml` | 1 | helper plot metadata | replace/remove | simplify first to align with no-small-dialog model, then remove if no remaining dependency | locked-batch-a |
| `1080i/Custom_1118_Dialog_Settings.xml` | 1 | helper-linked settings branch | remove/replace | remove helper-only branch; keep generic settings routing | locked-batch-a |
| `1080i/Custom_1172_Dialog_InfoOptions.xml` | 1 | helper field in info options dialog | replace | map options to retained details model | open |
| `1080i/Custom_1180_Dialog_Bumper.xml` | 1 | helper field in bumper flow | keep-temporary/replace | low-risk surface; replace when bumper flow touched | open |
| `1080i/Includes_OSD.xml` | 2 | helper references in OSD include | replace/remove | retain only normal OSD controls with non-helper bindings | open |

\* `Settings.xml` and `Includes_SkinSettings.xml` also include explicit `plugin.video.themoviedb.helper` addon-id references.

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

Batch D (deferred/keep-temporary review):
- Weather and bumper surfaces (`MyWeather.xml`, `Custom_1161_Dialog_Weather.xml`, `Custom_1180_Dialog_Bumper.xml`)
- `Custom_1105_Search.xml` helper-named property key rename (if still desired after functional parity).

---

## 4) Exception policy

Allowed `keep-temporary` only when all are true:
- replacing now would break active UX.
- no safe native/Velocity replacement available in this phase.
- clear follow-up task exists with owner and target milestone.

No undocumented exceptions.

---

## 5) Completion criteria for D-038

D-038 can move from `modify` to `accept` when:
- every active helper property usage is represented in this ledger,
- all entries are marked `remove` or `replace`, except explicitly justified `keep-temporary`,
- replacements/exceptions are implemented and trace-linked.

