# Phase 06 Validation Report

Phase doc: [phase-06-deferred-exceptions-and-final-cleanup.md](./phase-06-deferred-exceptions-and-final-cleanup.md)

Primary sources: [D-038 Legacy Property Ledger](../d038-legacy-property-ledger.md), [screen-by-screen build contract](../screen-by-screen-build-contract.md)

## 1. Batch D implementation

| Item | Result |
|------|--------|
| `1080i/MyWeather.xml` | Deleted |
| `1080i/Custom_1161_Dialog_Weather.xml` | Deleted |
| Weather reachability | `ActivateWindow(1161)` / `ActivateWindow(weather)` removed from skin XML and `shortcuts/skinvariables-shortcut-config.json`; `Hub_Settings_Items` weather row removed; `Hub_Weather_Widget` include removed; `Custom_1109_Settings.xml` list 501 hidden; power-tile default `OptionsTiles.03` set to `SystemInfo` with `Weather` → `SystemInfo` migration onloads; shortcuts dialog cycle no longer includes Weather |
| `Custom_1105_Search.xml` | Unchanged: Velocity discover onload retained (`keep-temporary` key) |
| `Custom_1180_Dialog_Bumper.xml` | Unchanged: `TMDbHelper.ContextMenu` documented as `keep-temporary` in D-038 §4 |

## 2. Residual control-plane cleanup (D-038 §4)

| Item | Result |
|------|--------|
| `Action_TMDbHelper_Toggle_Onclick` | Renamed to `Action_Skin_LegacyBlurDataToggle_Onclick` (`Includes_Actions.xml`); call sites `Dialog_DialogCustom.xml`, `Includes_SkinSettings.xml` |
| Scheme blur branches in `Includes_Actions.xml` | `$EXP[Exp_TMDbHelper_IsBlur]` replaced with `Skin.HasSetting(TMDbHelper.EnableBlur)` |

## 3. Static grep — helper pattern (active / touched surfaces)

Pattern: `TMDbHelper|TMDBHelper|themoviedb.helper|Exp_TMDbHelper|Exp_TMDBHelper`

Files: `1080i/Home.xml`, `1080i/Includes_Home.xml`, `1080i/Includes_Hubs.xml`, `1080i/Custom_1105_Search.xml`, `1080i/Includes_Search.xml`, `1080i/Includes_Actions.xml`, `1080i/Custom_1180_Dialog_Bumper.xml`

| File | Before (Phase 06 start) | After |
|------|-------------------------|-------|
| `Custom_1105_Search.xml` | 2 | 2 |
| `Includes_Search.xml` | 1 | 1 |
| `Includes_Actions.xml` | 13 | 12 |
| `Custom_1180_Dialog_Bumper.xml` | 1 | 1 |
| `Home.xml` / `Includes_Home.xml` / `Includes_Hubs.xml` | 0 | 0 |

## 4. Acceptance

- Batch D locked decisions implemented for weather removal and documented keep-temporary search/bumper exceptions.
- Phase 05 prerequisite: [README](./README.md) lists Phase 05 completed with [phase-05-validation-report.md](./phase-05-validation-report.md); Phase 06 may be marked completed per roadmap gates.

## 5. Manual / runtime

Operator should confirm in Kodi: settings hub (1109) without weather row; search combined discover; no crash opening former weather shortcuts (removed from generator config).
