# Master Triage List

Consolidated from:
- `doc/gap-analysis/phase-01-02-gap.md`
- `doc/gap-analysis/phase-03-04-gap.md`
- `doc/gap-analysis/phase-05-07-gap.md`

## Section 1: Bucket A (Agent Ready)

[x] `shortcuts/skinvariables-generator.json` - restore hardcoded primary hub defaults and complete Velocity route mapping.
[x] `shortcuts/skinvariables-shortcut-config.json` - remove/replace TMDbHelper preset nodes and addon-gated helper rules.
[x] `shortcuts/skinvariables-startup.json` - replace TMDbHelper startup bool/property initialization and helper script hooks with approved Velocity-safe equivalents.
[x] `shortcuts/builtins/skinvariables-playtrailer.json` - replace TMDbHelper trailer property bindings with mapped native/Velocity bindings.
[x] `shortcuts/generator/data/base/*.xml` - re-apply wiped Velocity route mappings that replaced helper URLs.
[x] `shortcuts/generator/data/setup/*.xml` - re-apply helper URL replacements and normalize to Velocity endpoints.
[x] `shortcuts/generator/data/setup/search_path.xml` - replace helper search templates with Velocity search/discover routes.
[x] `shortcuts/generator/data/setup/widgets_row.xml` - replace helper recommendation/discover templates and helper path conditions.
[x] `shortcuts/` generator templates that feed Home hub output - remove PVR ghost conditions (`PVR.HasTVChannels`) at the template level so regenerated `Includes_Home.xml` is clean.
[x] `shortcuts/` generator templates that feed weather surfaces - remove weather ghost wiring at the template level so regenerated home/settings outputs no longer emit weather remnants.
[x] `1080i/DialogVideoInfo.xml` - replace remaining helper guards/expressions with native equivalents.
[x] `1080i/Includes_Images.xml` - replace helper image/blur/status/people-art metadata bindings.
[x] `1080i/Includes_Labels.xml` - replace helper-derived labels (network/studio/director/writer/status/plot and related metadata text paths).
[x] `1080i/Includes_Paths.xml` - replace helper monitor/tmdb-id property plumbing with native/Velocity contract mappings.
[x] `1080i/Includes_Actions.xml` - remove helper service/blur/rating toggles and legacy helper bool namespace coupling.
[x] `1080i/Includes_Info.xml` - replace helper expression-gated info/rating fields with Velocity/native fields.
[x] `1080i/Includes_Overlay.xml` - replace helper-bound overlay labels/artwork/widget-container diagnostics.
[x] `1080i/Includes_OSD.xml` - replace helper player crop image and related OSD helper bindings.
[x] `1080i/Custom_1105_Search.xml` - re-implement deferred helper-named discover key/path handling (or freeze-approved temporary carry).
[x] `1080i/Custom_1114_Dialog_CustomPlot.xml` - restore custom-plot simplification and remove helper path dependencies.
[x] `1080i/Custom_1193_VideoOSDInfo.xml` - replace helper-linked overlay/details bridge metadata.
[x] `1080i/Custom_1171_Dialog_Views.xml` - replace helper metadata/context setup.
[x] `1080i/Custom_1170_Dialog_Options.xml` - replace helper metadata/context setup.
[x] `1080i/Custom_1160_Dialog_Favourites.xml` - replace helper metadata/context setup.
[x] `1080i/Custom_1172_Dialog_InfoOptions.xml` - replace helper metadata/context setup.
[x] `1080i/Custom_1122_Dialog_SelectTrailer.xml` - keep trailer UX and replace helper trailer metadata bindings.
[x] `1080i/Custom_1123_Dialog_Trailer.xml` - keep trailer UX and replace helper trailer metadata/context bindings.
[x] `1080i/Custom_1180_Dialog_Bumper.xml` - resolve deferred keep-temporary helper context property when bumper flow is touched.
[x] `1080i/Custom_1140_OSD_Playlist.xml` - replace helper widget-container/plot bindings.
[x] `1080i/Custom_1141_OSD_Cast.xml` - restore planned removal or remove helper-bound metadata paths.
[x] `1080i/Custom_1120_Dialog_SelectCrew.xml` - restore planned removal aligned with crew/dialog policy.
[x] `1080i/Custom_1113_Dialog_Plot.xml` - restore planned simplify-then-remove decision.
[x] `1080i/Custom_1118_Dialog_Settings.xml` - remove helper-only settings branch while preserving generic routing.

## Section 2: Bucket B (User Blocked)

User note: Generated home/hub/search outputs must be fixed through `shortcuts/` source templates first, then regenerated. Please isolate/scaffold these generated surfaces before I map/patch them.

- [ ] `1080i/Includes_SkinSettings.xml` - re-implement helper expression gates/settings rows removal and native replacements.
- [ ] `1080i/Home.xml` - re-implement helper startup strings and helper-bound home metadata/property replacements.
- [ ] `1080i/Includes_Home.xml` - generated output; do not edit directly. Apply PVR/Weather ghost removals in `shortcuts/` templates and regenerate.
- [ ] `1080i/Includes_Hubs.xml` - replace helper-based widget container/spotlight dependencies.
- [ ] `1080i/Includes_Search.xml` - re-implement combined search/discover migration and neutralize helper property usage.
- [ ] `1080i/Includes_DialogInfo.xml` - remove/replace helper-heavy details rails with curated Velocity-native bindings.
- [ ] `1080i/Dialog_DialogPlot.xml` - restore full-details flow simplification and remove helper mode/path dependencies.
- [ ] `1080i/Includes_Views.xml` - replace helper aliases and helper widget-container visibility usage.
- [ ] `1080i/Includes_Views_List.xml` - replace helper-bound list view metadata and container state usage.
- [ ] `1080i/Includes_Views_Row.xml` - replace helper-bound row view metadata and container state usage.
- [ ] `1080i/Includes_Views_Wall.xml` - replace helper-bound wall view metadata and container state usage.
- [ ] `1080i/Includes_Views_Combined.xml` - replace helper combined-view label/container bindings.
- [ ] `1080i/Includes_Widgets.xml` - replace helper widget info/container bindings.
- [ ] `1080i/Includes_Lists.xml` - replace helper list property/widget-container usage.
- [ ] `1080i/Dialog_DialogContextMenu.xml` - remove/replace remaining helper-based context metadata dependencies.
- [ ] `1080i/Dialog_DialogShortcuts.xml` - remove/replace `PVR.HasTVChannels` dependencies.
- [x] `1080i/Dialog_DialogPVRInfo.xml` - restore planned removal aligned with PVR policy.
- [x] `1080i/DialogPVRChannelGuide.xml` - restore planned removal aligned with PVR policy.
- [x] `1080i/DialogPVRGuideSearch.xml` - restore planned removal aligned with PVR policy.
- [x] `1080i/DialogPVRChannelsOSD.xml` - restore planned removal aligned with PVR policy.
- [x] `1080i/MyWeather.xml` - restore planned removal (Batch D mismatch: file still exists).
- [x] `1080i/Custom_1161_Dialog_Weather.xml` - restore planned removal (Batch D mismatch: file still exists).
- [ ] `1080i/Dialog_DialogWeather.xml` - remove/replace weather location usage with approved Velocity-native integration path.
- [ ] `1080i/Includes_Weather.xml` - remove/replace weather location property usage with approved Velocity-native integration path.
- [ ] `1080i/Custom_1109_Settings.xml` - remove/replace weather location actions and labels.
- [x] `1080i/script-wikipedia.xml` - restore planned removal aligned with context strategy.
