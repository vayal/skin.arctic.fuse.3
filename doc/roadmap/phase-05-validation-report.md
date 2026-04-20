# Phase 05 Validation Report

Phase doc reference:

- [Phase 05 - Metadata and Rendering Migration](./phase-05-metadata-and-rendering-migration.md)

Primary sources applied:

- [D-038 Legacy Property Ledger](../d038-legacy-property-ledger.md) (Batch C)
- [Screen-by-Screen Build Contract](../screen-by-screen-build-contract.md)
- Velocity addon reference (`docs/VELOCITY_ADDON_REFERENCE.md` or upstream `velocity-addon-reference-for-skin-forks.md`) and Kodi native `ListItem` / `VideoPlayer` / `Container` infolabels

## 1. Migration summary by metadata surface

| Surface | Files | What changed |
|--------|-------|----------------|
| Images | `1080i/Includes_Images.xml` | Prior work: artwork and spotlight paths use `ListItem` / `Container` / `VideoPlayer` art and standard infolabels; helper blur/crop window properties removed from active chains where applicable. |
| Labels | `1080i/Includes_Labels.xml` | Prior work: overlay and OSD labels use native infolabels; helper-only branches removed or stubbed; `Exp_TMDbHelper_IsData` decoupled. |
| Info + overlay | `1080i/Includes_Info.xml`, `1080i/Includes_Overlay.xml` | `Info_Meta_Ratings` replaced with a single native `Rating` row; total episodes row always eligible when `Property(totalepisodes)` is set; TV status row uses `Premiered` / `Property(status)` and existing `Label_*_Status` / `Image_*_Status` variables; Oscars / multi-aggregator helper ratings removed. `Info_Title`: TMDb crop logo path disabled (`croplogo` empty, crop control not shown). `Info_Panel` / `Info_Meta`: default `service`, `croplogo`, and `container` params wired. Overlay: debug strings use `ListItem.*` / `UniqueID()`; helper “is updating” variables collapsed to static `DONE`. |
| Views | `1080i/Includes_Views*.xml` | No remaining `TMDbHelper` / `Exp_TMDbHelper` references (verified static). |
| Widgets + lists + home | `1080i/Includes_Widgets.xml`, `Includes_Lists.xml`, `Home.xml`, `Includes_Home.xml` | `Home.xml`: removed dead `Skin.SetString(TMDbHelper.Corner…)` / `UseLocalWindowIDs` onloads. `Includes_Home.xml`: commented sample `onright` updated to `Velocity.WidgetContainer`. |
| Dialogs + trailers | `Custom_1171` / `1170` / `1160` / `1172`, `Custom_1122` / `1123` | Removed `SetProperty(TMDbHelper.ContextMenu,True)` onloads (no helper context). |
| Trailer plumbing | `shortcuts/builtins/skinvariables-playtrailer.json` | **C10A:** `Trailer` resolution order is `Container.ListItem.Trailer` then `ListItem.Trailer` only; title resolution uses container then focused list item; TMDbHelper window-property fallbacks removed. |

### Atomic rename (Batch C coupling)

- `TMDbHelper.WidgetContainer` → `Velocity.WidgetContainer` everywhere (including hub/OSD collateral) was completed in an earlier step; `TMDbHelper.WidgetContainer` has **zero** grep hits in the repo.

## 2. Trailer retention (C10A)

| Item | Status |
|------|--------|
| Window `1122` (select trailer) | Present; helper context `onload` removed; close guards on `PlayTrailerItems` unchanged. |
| Window `1123` (play trailer) | Present; plays `Window(Home).Property(PlayTrailer)`; helper context `onload` removed. |
| `skinvariables-playtrailer.json` | Still at `shortcuts/builtins/skinvariables-playtrailer.json`; native trailer infolabels first; no helper trailer branch. |

## 3. Static verification

**Phase 05 touch list + `skinvariables-playtrailer.json`** — ripgrep over every path in [phase-05-metadata-and-rendering-migration.md](./phase-05-metadata-and-rendering-migration.md) § File-Level Touch List, plus `shortcuts/builtins/skinvariables-playtrailer.json`, for the pattern `TMDbHelper|TMDBHelper|Exp_TMDbHelper|Exp_TMDBHelper|plugin.video.themoviedb.helper`.

**Result:** no matches (ripgrep exit code 1 = no matches).

**Note:** `1080i/Includes_Expressions.xml` still defines `Exp_TMDbHelper_*` for legacy skin settings and `Exp_DialogTheme_IsAdaptive`; that file is **outside** the Phase 05 Batch C touch list. Phase 06 may retire or neutralize those expressions when settings UI is migrated.

## 4. Appendix / checklist mapping

- **[appendix-verification-checklists.md](./appendix-verification-checklists.md) §6 Metadata rendering:** Batch C files use `ListItem` / `Container` / `VideoPlayer` for ratings, status, plot-related surfaces touched in this phase; aggregator-specific helper ratings intentionally dropped where Velocity does not supply equivalents.
- **§7 Residual dependency:** No `TMDbHelper` / `TMDBHelper` / `Exp_TMDbHelper` strings remain **in** the Phase 05 file set or `skinvariables-playtrailer.json`. Other windows (e.g. `Dialog_DialogCustom.xml`, `Includes_SkinSettings.xml`) still reference helper settings for Phase 06 scope.
- **[kodi-ui-verification-matrix.md](./kodi-ui-verification-matrix.md):** Runtime checks for image-only rows, spotlight fields, info panel, and trailer pick/play flows require **operator evidence** in Kodi (not available in this environment).

## 5. Phase 05 checklist (from phase doc)

| Check | Result |
|-------|--------|
| image-only card policy for rows | **Pass (static)** — no edits in this handoff changed row templates; views files had no helper references. |
| spotlight metadata (title/year/runtime/rating/plot) | **Pass (static)** — prior images/labels work + info meta uses native `Rating`; runtime confirmation needed. |
| info overlays and labels | **Pass (static)** for Batch C touched includes; full product pass in Kodi recommended. |
| trailer flows | **Pass (static)** — windows 1122/1123 intact; playtrailer JSON uses native trailer sources first. |

## 6. Acceptance criteria (phase doc)

| Criterion | Result |
|-----------|--------|
| all Batch C files migrated | **Pass** |
| no active helper-bound metadata dependency in migrated files | **Pass** (grep-clean on touch list + playtrailer). |
| row / spotlight / details match blueprint contract | **Pass (static)** — operator validation recommended. |

## 7. Blocker report

None.

## 8. Final Phase 05 result

- Acceptance criteria: **pass** (static), with runtime QA deferred to the verification matrix.
- Phase status recommendation: **completed**.
- Next: [Phase 06 - Deferred Exceptions and Final Cleanup](./phase-06-deferred-exceptions-and-final-cleanup.md).
