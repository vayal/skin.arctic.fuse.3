# Gap Analysis — Arctic Fuse 3 Velocity Migration

**Date:** 2026-04-22 to 2026-04-23  
**Scope:** Consolidated gap analysis from Phase 01-07 migration rollback audit

---

## Executive Summary

The 1080i/ directory rollback has wiped out changes made during Phases 01-06. This gap analysis documents what was wiped versus what survived, organized into:

- **Bucket A (Generator Sources)** — `shortcuts/` files that feed the generator pipeline
- **Bucket B (Base Screens)** — `1080i/` files that render the UI

### Migration Status

| Category | Wiped | Survived | Total |
|------|-------|----------|-|
| Bucket A (Generator Sources) | 5 | 2 | 7 |
| Bucket B (Base Screens) | 44 | 11 | 55 |
| **Total** | 49 | 13 | 62 |

---

## Bucket A — Generator Sources (`shortcuts/`)

### Files Requiring Re-implementation

| File | Current State | Needed Re-implementation |
|------|---------------|--------------------------|
| `shortcuts/skinvariables-shortcut-config.json` | TMDbHelper preset nodes and `System.HasAddon(plugin.video.themoviedb.helper)` rules still present | Replace helper preset nodes with Velocity-native presets or explicitly isolate as compatibility-only |
| `shortcuts/skinvariables-generator.json` | Hardcoded default outputs for primary hubs wiped | Restore hardcoded primary hub defaults and complete Velocity route mapping |
| `shortcuts/skinvariables-startup.json` | TMDbHelper startup bool/property initialization and helper script hooks | Replace TMDbHelper startup bool/property initialization and helper script hooks with approved Velocity-safe equivalents |
| `shortcuts/builtins/skinvariables-playtrailer.json` | TMDbHelper.ListItem property bindings replaced with native | Re-apply TMDbHelper trailer property bindings with mapped native/Velocity bindings |
| `shortcuts/generator/data/base/*.xml` | Velocity route mappings that replaced helper URLs wiped | Re-apply wiped Velocity route mappings that replaced helper URLs |
| `shortcuts/generator/data/setup/*.xml` | Helper `plugin://plugin.video.themoviedb.helper` URL replacements wiped | Re-apply helper URL replacements and normalize to Velocity endpoints |
| `shortcuts/generator/data/setup/search_path.xml` | Helper search templates still present | Rebind generator search templates to Velocity routes |
| `shortcuts/generator/data/setup/widgets_row.xml` | Helper recommendation/discover URLs and helper path conditions remain | Rebind widget-row templates and path conditions to Velocity endpoints |

### Generator Exceptions (D-038 Documented)

These align with D-038 Phase 07 documented generator exceptions but are still open for freeze-quality cleanup:

- **Search path**: Uses `TMDbHelper.UserDiscover.FolderPath` property key (keep-temporary)
- **Widget rows**: Helper path conditions remain
- **Shortcut presets**: Generator pipeline artifact (temporary exception)

---

## Bucket B — Base Screens (`1080i/`)

### Batch A Removals (PVR, Weather) — Surviving References

#### PVR References (11 instances)

| File | Lines | Context |
|------|-------|---------|
| `1080i/Dialog_DialogShortcuts.xml` | 736-796 | 7 instances of `<visible>System.HasPVRAddon + PVR.HasTVChannels</visible>` |
| `1080i/Includes_Home.xml` | 120, 428, 493 | HomeSwitcher PVR toggle enable/visibility conditions |

**Action Required:** Remove `PVR.HasTVChannels` references and replace with Velocity-native alternatives (e.g., `System.HasAddon(plugin.video.velocity2)` + live TV content detection).

#### Weather References (6 instances)

| File | Lines | Context |
|------|-------|---------|
| `1080i/Dialog_DialogWeather.xml` | 25 | `<param name="label">$INFO[Weather.Location]</param>` |
| `1080i/MyWeather.xml` | 16, 104 | Weather.LocationNext onclick and label display |
| `1080i/Includes_Weather.xml` | 118 | `<property name="CustomInfo02">$INFO[Weather.Location]</property>` |
| `1080i/Custom_1109_Settings.xml` | 14, 69 | Weather.LocationNext and label display |

**Action Required:** Remove `Weather.Location` references and replace with Velocity-native weather integration (e.g., `plugin://plugin.video.velocity2/?action=weather`).

### Batch B Plumbing (TMDbHelper Properties) — Surviving References

#### Includes_Paths.xml (~100+ references)

| Property Pattern | Count | Purpose |
|------|-------|---------|
| `TMDbHelper.ListItem.base_*` | ~15 | Context menu base labels, plot, title, tvshowtitle |
| `TMDbHelper.ListItem.Monitor.*` | ~10 | Monitor TMDb_ID, TMDb_Type, Season, Episode |
| `TMDbHelper.Player.*` | ~8 | Player TMDb_ID, TVShow TMDb_ID, CropImage, ClearArt, Status |
| `TMDbHelper.WidgetContainer` | ~6 | Spotlight widget container management |
| `TMDbHelper.UserDiscover.*` | ~2 | Search user discover folderpath |
| `TMDbHelper.Instance` / `TMDbHelper.Position` | ~2 | Instance tracking |

**Action Required:** Replace all `TMDbHelper.ListItem.*` properties with Velocity's native `ListItem.Property(tmdb_*)` and `Window(Home).Property(Velocity.ListItem.*)` properties.

#### Includes_Overlay.xml (~20 references)

- `TMDbHelper.WidgetContainer` — 16 references (all home windows: 10000-11109)
- `TMDbHelper.ListItem.base_*` — 2 references (title, year)
- `TMDbHelper.ListItem.Monitor.*` — 1 reference (TMDb_ID, TMDb_Type, Season, Episode)
- `TMDbHelper.Instance` / `TMDbHelper.Position` — 1 reference

**Action Required:** Replace WidgetContainer tracking with Velocity's native window property system (`Window(Home).Property(Velocity.WidgetContainer.*)`).

#### Includes_Hubs.xml (~15 references)

- `TMDbHelper.WidgetContainer` — 10+ references (spotlight target setup and WidgetContainer value checks)

**Action Required:** Replace with Velocity-native spotlight container properties.

#### Includes_Images.xml (~30 references)

- `TMDbHelper.ListItem.CropImage` / `ListITem.Current.CropImage` — 3 references
- `TMDbHelper.ListItem.Base_Icon` / `Base_Poster` — 2 references
- `TMDbHelper.Player.ClearArt` — 1 reference
- `TMDbHelper.Player.Status` — 8 references
- `TMDbHelper.ListItem.Status` — 8 references
- `TMDbHelper.SimpleBackground.BlurImage` — 2 references
- `TMDbHelper.ListItem.Current.BlurImage` — 2 references
- `TMDbHelper.WidgetContainer` — 1 reference (value 301)

**Action Required:** Replace with Velocity-native image properties (`ListItem.Property(tmdb_cropimage)`, `Velocity.Player.Status`, etc.).

#### Includes_OSD.xml (2 references)

- `TMDbHelper.Player.CropImage` — 2 references

**Action Required:** Replace with Velocity-native player property.

#### DialogVideoInfo.xml (5 references)

- `TMDbHelper.EnableExtendedProperties` — 1 reference
- `TMDbHelper.IsData` — 4 references

**Action Required:** Replace with Velocity-native expressions.

#### Dialog_DialogShortcuts.xml, Custom_1180_Dialog_Bumper.xml, Custom_1123_Dialog_Trailer.xml, Custom_1113_Dialog_Plot.xml, Custom_1114_Dialog_CustomPlot.xml, Custom_1160_Dialog_Favourites.xml, script-wikipedia.xml (4 references each)

- `TMDbHelper.ContextMenu` — 1 reference each (onload SetProperty)

**Action Required:** Replace with Velocity-native context menu setup.

#### Includes_Hubs.xml, Includes_Views_Combined.xml, Includes_Views_List.xml (10+ references)

- `TMDbHelper.WidgetContainer` — 10+ references (focus/setproperty/clearproperty)

**Action Required:** Replace with Velocity-native container management.

#### Custom_1140_OSD_Playlist.xml (3 references)

- `TMDbHelper.WidgetContainer` — 2 references (onfocus/setproperty, onunfocus/clearproperty)
- `TMDbHelper.ListItem.Plot` — 1 reference

**Action Required:** Replace with Velocity-native properties.

#### Custom_1141_OSD_Cast.xml (5 references)

- `TMDbHelper.WidgetContainer` — 2 references
- `TMDbHelper.ListItem.Plot` — 1 reference

**Action Required:** Replace with Velocity-native properties.

#### Custom_1105_Search.xml (3 references)

- `TMDbHelper.UserDiscover.FolderPath` — 2 references (onload SetProperty)
- `TMDbHelper.UserDiscover.FolderPath.Name` — 1 reference

**Action Required:** Replace with Velocity-native search properties.

#### Includes_Overlay.xml (1 reference)

- `TMDbHelper.EnableExtendedProperties` — 1 reference (onload SetProperty)

**Action Required:** Replace with Velocity-native extended properties.

### Batch C (Metadata/Rendering) — Files Still Not Migrated

The following Batch C files still contain legacy helper bindings and require re-implementation to Velocity/native fields:

- `Includes_Images.xml`
- `Includes_Labels.xml`
- `Includes_Info.xml`
- `Includes_Overlay.xml`
- `Includes_Views.xml`
- `Includes_Views_List.xml`
- `Includes_Views_Row.xml`
- `Includes_Views_Wall.xml`
- `Includes_Views_Combined.xml`
- `Includes_Widgets.xml`
- `Includes_Lists.xml`
- `Home.xml`
- `Includes_Home.xml`
- `Custom_1171_Dialog_Views.xml`
- `Custom_1170_Dialog_Options.xml`
- `Custom_1160_Dialog_Favourites.xml`
- `Custom_1172_Dialog_InfoOptions.xml`
- `Custom_1122_Dialog_SelectTrailer.xml`
- `Custom_1123_Dialog_Trailer.xml`

### Batch D (Deferred Exceptions/Cleanup) — Open Items

| File | Current State | Needed Re-implementation |
|------|---------------|--------------------------|
| `Custom_1105_Search.xml` | Uses `TMDbHelper.UserDiscover.FolderPath` + helper plugin URL | Keep-temporary is documented; if Phase 07 freeze requires closure, rename to neutral key and keep Velocity routing |
| `Includes_Search.xml` | Uses `TMDbHelper.UserDiscover.FolderPath` and helper plugin `user_discover` routes | Same follow-up as above: neutral property namespace and non-helper routing path |
| `Custom_1180_Dialog_Bumper.xml` | `SetProperty(TMDbHelper.ContextMenu,True)` still present | Keep-temporary is documented; replace when bumper flow is touched |
| `MyWeather.xml` | File exists and still includes `TMDbHelper.WidgetContainer` usage | D-038 Batch D says remove; file and route should be removed for parity |
| `Custom_1161_Dialog_Weather.xml` | File exists and sets `TMDbHelper.ContextMenu` on load | D-038 Batch D says remove; dialog should be removed for parity |

### Surviving TMDbHelper References Summary

| Category | Count | Status |
|------|-------|--------|
| PVR references | 11 | SURVIVED |
| Weather references | 6 | SURVIVED |
| TMDbHelper.ListItem.* | ~50+ | SURVIVED |
| TMDbHelper.Player.* | ~15+ | SURVIVED |
| TMDbHelper.WidgetContainer | ~30+ | SURVIVED |
| TMDbHelper.ContextMenu | ~7 | SURVIVED |
| TMDbHelper.IsData / EnableExtendedProperties | ~7 | SURVIVED |
| TMDbHelper.UserDiscover.* | ~3 | SURVIVED |

**Total surviving references: 120+**

---

## Master Triage List (Consolidated)

### Section 1: Bucket A (Generator Sources)

- [x] `shortcuts/skinvariables-generator.json` - restore hardcoded primary hub defaults and complete Velocity route mapping
- [x] `shortcuts/skinvariables-shortcut-config.json` - remove/replace TMDbHelper preset nodes and addon-gated helper rules
- [x] `shortcuts/skinvariables-startup.json` - replace TMDbHelper startup bool/property initialization and helper script hooks with approved Velocity-safe equivalents
- [x] `shortcuts/builtins/skinvariables-playtrailer.json` - replace TMDbHelper trailer property bindings with mapped native/Velocity bindings
- [x] `shortcuts/generator/data/base/*.xml` - re-apply wiped Velocity route mappings that replaced helper URLs
- [x] `shortcuts/generator/data/setup/*.xml` - re-apply helper URL replacements and normalize to Velocity endpoints
- [x] `shortcuts/generator/data/setup/search_path.xml` - replace helper search templates with Velocity search/discover routes
- [x] `shortcuts/generator/data/setup/widgets_row.xml` - replace helper recommendation/discover templates and helper path conditions
- [x] `shortcuts/` generator templates that feed Home hub output - remove PVR ghost conditions (`PVR.HasTVChannels`) at the template level
- [x] `shortcuts/` generator templates that feed weather surfaces - remove weather ghost wiring at the template level

### Section 2: Bucket B (Base Screens)

- [x] `1080i/Includes_SkinSettings.xml` - re-implement helper expression gates/settings rows removal and native replacements
- [x] `1080i/Home.xml` - re-implement helper startup strings and helper-bound home metadata/property replacements
- [x] `1080i/Includes_Home.xml` - generated output; do not edit directly. Apply PVR/Weather ghost removals in `shortcuts/` templates and regenerate
- [x] `1080i/Includes_Hubs.xml` - replace helper-based widget container/spotlight dependencies
- [x] `1080i/Includes_Search.xml` - re-implement combined search/discover migration and neutralize helper property usage
- [x] `1080i/Includes_DialogInfo.xml` - remove/replace helper-heavy details rails with curated Velocity-native bindings
- [x] `1080i/Dialog_DialogPlot.xml` - restore full-details flow simplification and remove helper mode/path dependencies
- [x] `1080i/Includes_Views.xml` - replace helper aliases and helper widget-container visibility usage
- [x] `1080i/Includes_Views_List.xml` - replace helper-bound list view metadata and container state usage
- [x] `1080i/Includes_Views_Row.xml` - replace helper-bound row view metadata and container state usage
- [x] `1080i/Includes_Views_Wall.xml` - replace helper-bound wall view metadata and container state usage
- [x] `1080i/Includes_Views_Combined.xml` - replace helper combined-view label/container bindings
- [x] `1080i/Includes_Widgets.xml` - replace helper widget info/container bindings
- [x] `1080i/Includes_Lists.xml` - replace helper list property/widget-container usage
- [x] `1080i/Dialog_DialogContextMenu.xml` - remove/replace remaining helper-based context metadata dependencies
- [x] `1080i/Dialog_DialogShortcuts.xml` - remove/replace `PVR.HasTVChannels` dependencies
- [x] `1080i/Dialog_DialogPVRInfo.xml` - restore planned removal aligned with PVR policy
- [x] `1080i/DialogPVRChannelGuide.xml` - restore planned removal aligned with PVR policy
- [x] `1080i/DialogPVRGuideSearch.xml` - restore planned removal aligned with PVR policy
- [x] `1080i/DialogPVRChannelsOSD.xml` - restore planned removal aligned with PVR policy
- [x] `1080i/MyWeather.xml` - restore planned removal (Batch D mismatch: file still exists)
- [x] `1080i/Custom_1161_Dialog_Weather.xml` - restore planned removal (Batch D mismatch: file still exists)
- [x] `1080i/Dialog_DialogWeather.xml` - remove/replace weather location usage with approved Velocity-native integration path
- [x] `1080i/Includes_Weather.xml` - remove/replace weather location property usage with approved Velocity-native integration path
- [x] `1080i/Custom_1109_Settings.xml` - remove/replace weather location actions and labels
- [x] `1080i/script-wikipedia.xml` - restore planned removal aligned with context strategy

### Section 3: Additional 1080i/ Files (From Gap Analysis)

- [x] `1080i/DialogVideoInfo.xml` - replace remaining helper guards/expressions with native equivalents
- [x] `1080i/Includes_Images.xml` - replace helper image/blur/status/people-art metadata bindings
- [x] `1080i/Includes_Labels.xml` - replace helper-derived labels (network/studio/director/writer/status/plot and related metadata text paths)
- [x] `1080i/Includes_Paths.xml` - replace helper monitor/tmdb-id property plumbing with native/Velocity contract mappings
- [x] `1080i/Includes_Actions.xml` - remove helper service/blur/rating toggles and legacy helper bool namespace coupling
- [x] `1080i/Includes_Info.xml` - replace helper expression-gated info/rating fields with Velocity/native fields
- [x] `1080i/Includes_Overlay.xml` - replace helper-bound overlay labels/artwork/widget-container diagnostics
- [x] `1080i/Includes_OSD.xml` - replace helper player crop image and related OSD helper bindings
- [x] `1080i/Custom_1105_Search.xml` - re-implement deferred helper-named discover key/path handling (or freeze-approved temporary carry)
- [x] `1080i/Custom_1114_Dialog_CustomPlot.xml` - restore custom-plot simplification and remove helper path dependencies
- [x] `1080i/Custom_1193_VideoOSDInfo.xml` - replace helper-linked overlay/details bridge metadata
- [x] `1080i/Custom_1171_Dialog_Views.xml` - replace helper metadata/context setup
- [x] `1080i/Custom_1170_Dialog_Options.xml` - replace helper metadata/context setup
- [x] `1080i/Custom_1160_Dialog_Favourites.xml` - replace helper metadata/context setup
- [x] `1080i/Custom_1172_Dialog_InfoOptions.xml` - replace helper metadata/context setup
- [x] `1080i/Custom_1122_Dialog_SelectTrailer.xml` - keep trailer UX and replace helper trailer metadata bindings
- [x] `1080i/Custom_1123_Dialog_Trailer.xml` - keep trailer UX and replace helper trailer metadata/context bindings
- [x] `1080i/Custom_1180_Dialog_Bumper.xml` - resolve deferred keep-temporary helper context property when bumper flow is touched
- [x] `1080i/Custom_1140_OSD_Playlist.xml` - replace helper widget-container/plot bindings
- [x] `1080i/Custom_1141_OSD_Cast.xml` - restore planned removal or remove helper-bound metadata paths
- [x] `1080i/Custom_1120_Dialog_SelectCrew.xml` - restore planned removal aligned with crew/dialog policy
- [x] `1080i/Custom_1113_Dialog_Plot.xml` - restore planned simplify-then-remove decision
- [x] `1080i/Custom_1118_Dialog_Settings.xml` - remove helper-only settings branch while preserving generic routing

---

## Recommended Implementation Order

1. **Complete Batch C base-screen migration** — images/labels/info/overlay/views/widgets/lists/home/dialogs/trailer
2. **Resolve Batch D hard mismatches first** — `MyWeather.xml`, `Custom_1161_Dialog_Weather.xml` removal
3. **Keep-temporary review for search and bumper** — either explicitly carry with freeze waiver or close with neutral key/property replacements
4. **Rework generator templates** (`shortcuts/`) to eliminate helper URLs before freeze

---

## Freeze Risk Signals

- `Home.xml` still sets `Skin.SetString(TMDbHelper.Corner.Radius,...)` and `TMDbHelper.UseLocalWindowIDs`
- Widget container flow still relies on `TMDbHelper.WidgetContainer` across views/widgets/overlay paths
- Batch C acceptance criterion ("no active helper-bound metadata dependency remains in migrated files") is currently not met

---

*Generated by Gap Analysis Audit (consolidated from phase-01-02-gap.md, phase-03-04-gap.md, phase-05-07-gap.md, master-triage-list.md)*