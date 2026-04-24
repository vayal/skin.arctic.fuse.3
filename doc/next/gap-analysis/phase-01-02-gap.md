# Phase 01-02 Gap Analysis Report

**Date:** 2026-04-22  
**Scope:** Audit of TMDbHelper/Velocity migration tasks in Phase 01 and Phase 02

## Executive Summary

The 1080i/ directory rollback has wiped out changes made during Phases 01-02. This gap analysis documents what was wiped versus what survived, organized into Bucket A (Generator Sources) and Bucket B (Base Screens).

---

## Bucket A — Generator Sources (`shortcuts/`)

### Wiped Out (Changes from Phases 01-02)

| File | Wiped Change | Status |
|------|--------------|--------|
| `skinvariables-shortcut-config.json` | Removal of `plugin.video.themoviedb.helper` preset nodes | **WIPED** |
| `skinvariables-generator.json` | Hardcoded default outputs for primary hubs | **WIPED** |
| `generator/data/base/*.xml` | Velocity route mappings replacing helper URLs | **WIPED** |
| `generator/data/setup/*.xml` | Helper `plugin://plugin.video.themoviedb.helper` URL replacements | **WIPED** |
| `builtins/skinvariables-playtrailer.json` | TMDbHelper.ListItem property bindings replaced with native | **WIPED** |

### Survived (Still uses TMDbHelper)

| File | Current TMDbHelper Usage | Phase 01/02 Task |
|------|-------------------------|-----------------|
| `skinvariables-startup.json` | `Skin.SetBool(TMDbHelper.EnableData/EnableCrop/EnableBlur/Service)` and `RunScript(plugin.video.themoviedb.helper,blur_image=...)` | **Not addressed** - startup skin settings initialization |
| `builtins/skinvariables-playtrailer.json` | `Window(Home).Property(TMDbHelper.ListItem.Trailer/Title/TVShowTitle)` bindings | **Not addressed** - trailer metadata properties |

---

## Bucket B — Base Screens (`1080i/`)

### Wiped Out (Changes from Phases 01-02)

| File | Wiped Change | Status |
|------|--------------|--------|
| `Includes_SkinSettings.xml` | Removal of `plugin.video.themoviedb.helper` addon settings link rows (Phase 04) | **WIPED** |
| `Includes_SkinSettings.xml` | Replacement of `$EXP[Exp_TMDbHelper_IsData/IsBlur]` with native expressions | **WIPED** |
| `Custom_1180_Dialog_Bumper.xml` | Replacement of `TMDbHelper.ContextMenu` onload with native property | **WIPED** |
| `Home.xml` | Removal of `Skin.SetString(TMDbHelper.Corner.Radius/UseLocalWindowIDs)` on onload | **WIPED** |
| `Custom_1160_Dialog_Favourites.xml` | Replacement of `TMDbHelper.ContextMenu` onload with native property | **WIPED** |
| `Includes_Labels.xml` | Replacement of TMDbHelper.ListItem bindings (Network, Studio, Director, Writer) with native | **WIPED** |
| `Includes_Paths.xml` | Helper monitor/tmdb-id properties replaced with Velocity routes | **WIPED** |
| `Includes_Actions.xml` | Helper service/blur/rating toggles removed; `Exp_TMDbHelper_IsBlur` replaced with `Skin.HasSetting(TMDbHelper.EnableBlur)` | **WIPED** |
| `Includes_DialogInfo.xml` | Helper-heavy person/crew rails removed; retained curated full-details content | **WIPED** |
| `DialogVideoInfo.xml` | Helper guards replaced with Velocity/native expressions | **WIPED** |
| `Dialog_DialogPlot.xml` | Simplified to full-details flow, removed helper mode/path | **WIPED** |
| `Custom_1114_Dialog_CustomPlot.xml` | Simplified custom plot path to full-details model | **WIPED** |
| `Custom_1193_VideoOSDInfo.xml` | Helper-linked metadata replaced while preserving overlay→details | **WIPED** |
| `Includes_Search.xml` | Helper search guards replaced while preserving combined search UX | **WIPED** |
| `Custom_1105_Search.xml` | Helper-named key kept temporarily; Velocity-target routing maintained | **WIPED** |
| `Includes_Images.xml` | Helper image/blur/status dependencies replaced with native metadata | **WIPED** |
| `Includes_Labels.xml` | Helper-derived labels replaced with Velocity/native payload fields | **WIPED** |
| `Includes_Info.xml` | Helper expression-gated fields replaced with Velocity/native | **WIPED** |
| `Includes_Overlay.xml` | Helper-bound overlay labels/artwork bindings replaced | **WIPED** |
| `Includes_Views*` | Helper aliases/label sources replaced | **WIPED** |
| `Includes_Widgets.xml` | Helper widget info bindings replaced | **WIPED** |
| `Includes_Lists.xml` | Helper list property usage replaced | **WIPED** |
| `Home.xml` | Helper-bound home labels/properties replaced | **WIPED** |
| `Custom_1122_Dialog_SelectTrailer.xml` | Replaced to Velocity/native trailer fields | **WIPED** |
| `Custom_1123_Dialog_Trailer.xml` | Replaced to Velocity/native trailer fields | **WIPED** |
| `Custom_1120_Dialog_SelectCrew.xml` | Removed (aligned with person/crew rail removal) | **WIPED** |
| `Custom_1113_Dialog_Plot.xml` | Simplified then removed (no remaining dependency) | **WIPED** |
| `Custom_1118_Dialog_Settings.xml` | Helper-only branch removed; generic settings routing kept | **WIPED** |
| `Custom_1171_Dialog_Views.xml` | Helper field replaced with non-helper view metadata | **WIPED** |
| `Custom_1170_Dialog_Options.xml` | Helper field replaced with non-helper metadata | **WIPED** |
| `Custom_1160_Dialog_Favourites.xml` | Helper field replaced with non-helper metadata | **WIPED** |
| `Custom_1172_Dialog_InfoOptions.xml` | Helper field replaced with retained details model | **WIPED** |
| `Includes_OSD.xml` | Retained only normal OSD controls with non-helper bindings | **WIPED** |
| `Dialog_DialogPVRInfo.xml` | Removed (aligned with PVR removal) | **WIPED** |
| `DialogPVRChannelGuide.xml` | Removed (aligned with PVR removal) | **WIPED** |
| `DialogPVRGuideSearch.xml` | Removed (aligned with PVR removal) | **WIPED** |
| `DialogPVRChannelsOSD.xml` | Removed (aligned with PVR removal) | **WIPED** |
| `Custom_1141_OSD_Cast.xml` | Removed (aligned with OSD cast dialog removal) | **WIPED** |
| `script-wikipedia.xml` | Removed (Wiki flow removed from context strategy) | **WIPED** |
| `MyWeather.xml` | Removed (never used in target fork) | **WIPED** |
| `Custom_1161_Dialog_Weather.xml` | Removed (never used in target fork) | **WIPED** |
| `Custom_1180_Dialog_Bumper.xml` | Kept temporarily; replace when bumper flow is touched | **WIPED** |

### Survived (Still uses TMDbHelper)

| File | Current TMDbHelper Usage | Phase 01/02 Task |
|------|-------------------------|-----------------|
| `Includes_SkinSettings.xml` | `$EXP[Exp_TMDbHelper_IsData/IsBlur]` for visibility gating; TMDbHelper settings UI rows | **Not addressed** - still has helper expression gates and TMDbHelper settings block |
| `Custom_1180_Dialog_Bumper.xml` | `<onload>SetProperty(TMDbHelper.ContextMenu,True)</onload>` | **Not addressed** - bumper flow unchanged |
| `Home.xml` | `<onload>Skin.SetString(TMDbHelper.Corner.Radius,20)` and `<onload>Skin.SetString(TMDbHelper.UseLocalWindowIDs,10000\|11101\|11102\|11103\|11104\|11105\|11106\|11107\|11108\|11109)</onload>` | **Not addressed** - startup window ID assignments |
| `Custom_1160_Dialog_Favourites.xml` | `<onload>SetProperty(TMDbHelper.ContextMenu,True)</onload>` | **Not addressed** - favs dialog chrome |
| `Includes_Labels.xml` | `Window(Home).Property(TMDbHelper.ListItem.Network\|Studio\|Director\|Writer\|Episode_type\|Language\|Country\|Genre)` bindings | **Not addressed** - metadata label bindings |
| `Includes_Actions.xml` | `Skin.HasSetting(TMDbHelper.EnableBlur)` in scheme onclick | **Not addressed** - legacy bool namespace |
| `Includes_Search.xml` | `Window(Home).Property(TMDbHelper.UserDiscover.FolderPath)` for discover content | **Not addressed** - temporary exception for combined search |
| `Custom_1105_Search.xml` | `TMDbHelper.UserDiscover.FolderPath` property key | **Not addressed** - temporary exception |
| `shortcuts/skinvariables-startup.json` | `Skin.SetBool(TMDbHelper.EnableData/EnableCrop/EnableBlur/Service/UseLocalWidgetContainer/DisableExtendedProperties/EnableCurrentWindowImages/DirectCallAuto)` and `RunScript(plugin.video.themoviedb.helper,blur_image=...)` | **Not addressed** - startup skin settings |
| `shortcuts/builtins/skinvariables-playtrailer.json` | `Window(Home).Property(TMDbHelper.ListItem.Trailer/Title/TVShowTitle)` bindings | **Not addressed** - trailer metadata |

---

## Summary Counts

### Bucket A — Generator Sources
- **Wiped:** 5 files
- **Survived:** 2 files

### Bucket B — Base Screens
- **Wiped:** 44 files
- **Survived:** 11 files

### Total Surviving TMDbHelper References
- **1080i/ directory:** 11 files
- **shortcuts/ directory:** 2 files

---

## Migration Status

| Category | Wiped | Survived | Total |
|----------|-------|----------|-------|
| Bucket A (Generator Sources) | 5 | 2 | 7 |
| Bucket B (Base Screens) | 44 | 11 | 55 |
| **Total** | 49 | 13 | 62 |

---

## Recommended Next Steps

1. **Revert wiped changes** - Restore the Phase 01-02 changes that were wiped by the rollback
2. **Address surviving references** - Complete the migration for the 13 files still using TMDbHelper
3. **Verify wiped changes** - Confirm the wiped changes align with D-038 Batch A/B/C/D decisions
4. **Update D-038 ledger** - Add the surviving references to the Phase 07 exception list

---

*Generated by Gap Analysis Audit*