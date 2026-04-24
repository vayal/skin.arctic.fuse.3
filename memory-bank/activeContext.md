# Active Context — Arctic Fuse 3 Velocity Migration

## Current Work Focus

**Phase 07: Stabilization and Freeze** — The skin fork is 94% complete with Phases 01-06 finished. Phase 07 requires runtime validation evidence in Kodi that cannot be captured in CI/agent environments.

**Gap Analysis Status** (2026-04-22 to 2026-04-23):
- 120+ surviving TMDbHelper references identified across 1080i/ and shortcuts/ directories
- Bucket A (Generator Sources): 5 files wiped, 2 files survived rollback
- Bucket B (Base Screens): 44 files wiped, 11 files survived rollback
- Batch C (Metadata/Rendering): 19 files still contain legacy helper bindings
- Batch D (Deferred Exceptions): 5 open items including weather file mismatches
- PVR references: 11 instances surviving in Dialog_DialogShortcuts.xml and Includes_Home.xml
- Weather references: 6 instances surviving in Dialog_DialogWeather.xml, MyWeather.xml, Includes_Weather.xml, Custom_1109_Settings.xml
- TMDbHelper.ListItem.*: ~50+ references in paths, labels, info, views, widgets, lists, home, dialogs, trailer
- TMDbHelper.Player.*: ~15+ references in player status, crop image, clear art
- TMDbHelper.WidgetContainer: ~30+ references across views, widgets, overlay paths
- TMDbHelper.ContextMenu: ~7 references in dialog onloads
- TMDbHelper.IsData / EnableExtendedProperties: ~7 references in DialogVideoInfo.xml
- TMDbHelper.UserDiscover.*: ~3 references in search flow (temporary exception)

**Migration Status Summary**:
- Wiped: 49 files (Phase 01-06 changes lost to rollback)
- Survived: 13 files (still using TMDbHelper)
- Total: 62 files audited

**Generator Exceptions (D-038 Documented)**:
- Search path: Uses `TMDbHelper.UserDiscover.FolderPath` property key (keep-temporary)
- Widget rows: Helper path conditions remain
- Shortcut presets: Generator pipeline artifact (temporary exception)
- OSD crop image binding: D-038 §4; playback OSD still uses it
- Background blur toggle: D-038 §4; user setting preserved
- Writer/director crew bindings: D-038 §4; no active UX path yet
- Freeze risk: Home.xml still sets `TMDbHelper.Corner.Radius` and `TMDbHelper.UseLocalWindowIDs`

### Primary Task

Capture end-to-end journey evidence for:
1. Browse-to-play (Home → Series hub → Continue watching → Play)
2. Search-to-play (Discover → Movie → Play)
3. Info-and-related (Row → Full details → Trailer)
4. Pagination behavior (In-row cap 10, full list 40/page)

### Recent Changes

**Phase 06 Completed** (2026-04-XX):
- Removed weather surfaces (`MyWeather.xml`, `Custom_1161_Dialog_Weather.xml`)
- Renamed `Action_TMDbHelper_Toggle_Onclick` → `Action_Skin_LegacyBlurDataToggle_Onclick`
- Decoupled scheme blur from `Exp_TMDbHelper_IsBlur` to `Skin.HasSetting(TMDbHelper.EnableBlur)`

**Phase 05 Completed** (2026-04-XX):
- Migrated `Includes_Images.xml` — artwork paths use native `ListItem`/`Container`/`VideoPlayer`
- Migrated `Includes_Labels.xml` — overlay/OSD labels use native infolabels
- Migrated `Includes_Info.xml` — replaced multi-aggregator ratings with single `Rating` row
- Migrated `Includes_Views*.xml` — no remaining TMDbHelper references
- Migrated trailer plumbing (C10A) — `Container.ListItem.Trailer` then `ListItem.Trailer`

**Phase 04 Completed** (2026-04-XX):
- Removed expanded context menu (`Dialog_DialogContextMenu.xml` — `has_menu` forced false)
- Removed OSD cast dialog (`Custom_1141_OSD_Cast.xml` deleted)
- Removed PVR dialog family (6 files deleted)
- Removed Wikipedia/crew flows (`script-wikipedia.xml`, `Custom_1120_Dialog_SelectCrew.xml`)
- Removed small plot dialog (`Custom_1113_Dialog_Plot.xml` deleted)
- Removed helper settings entry points

**Phase 03 Completed** (2026-04-XX):
- Migrated `Includes_Paths.xml`, `Includes_Actions.xml`, `Includes_DialogInfo.xml`
- Migrated details dialogs (`DialogVideoInfo.xml`, `Dialog_DialogPlot.xml`, `Custom_1114_Dialog_CustomPlot.xml`)
- Migrated OSD bridge (`Custom_1193_VideoOSDInfo.xml`)
- Fork default IA bootstrap slice — first-run now enables only Home/Series/Movies toggles

**Phase 02 Completed** (2026-04-XX):
- Implemented D-015 contract families in Velocity addon
- Added pagination payload (`items/page/has_more/next_page`)
- Terminal page omits `next_page`
- Progress fields: `last_watched_at`, `percent_watched`, `resume_point`, `is_in_progress`

**Phase 01 Completed** (2026-04-XX):
- Frozen D-003, D-015, D-021, D-038 decisions
- Locked execution boundaries

## Next Steps

### Immediate (Phase 07 Runtime Evidence)

1. **Bootstrap reset** in Kodi:
   ```
   Skin.Reset(HomeSwitcher.1101.Toggle)
   Skin.Reset(HomeSwitcher.1102.Toggle)
   Skin.Reset(HomeSwitcher.1103.Toggle)
   Skin.Reset(HomeSwitcher.1104.Toggle)
   Skin.Reset(HomeSwitcher.1106.Toggle)
   Skin.Reset(HomeSwitcher.1107.Toggle)
   Skin.Reset(HomeSwitcher.1108.Toggle)
   Skin.Reset(HomeSwitcher.LoopBack)
   Skin.Reset(DefaultConfig.InitDone)
   ActivateWindow(Startup)
   ```

2. **Verify top bar** — only Search + Home + Series + Movies visible; no 1103/1104/1106-1108

3. **Capture hub navigation evidence**:
   - Home: in-progress tab strip + poster row populate
   - Series (1101): 6 rows (Continue Watching, New Episodes, Active Shows, Up Next, Recently Watched, Discover)
   - Movies (1102): 6 rows (In Progress, Recently Watched, Continue Watching, Recent, Discover, Velocity Home)

4. **Capture search combined flow**:
   - `1080i/Custom_1105_Search.xml` uses `Velocity.Path.Discover`
   - `1080i/Includes_Search.xml` keeps `skinvariables-searchwidgets-combined`

5. **Capture full details flow**:
   - `1080i/DialogVideoInfo.xml` — no helper branching
   - `1080i/Includes_DialogInfo.xml` — plot action targets `ActivateWindow(1114)`

6. **Capture OSD bridge flow**:
   - `1080i/Custom_1193_VideoOSDInfo.xml` — `Action(Info)` then close overlay

7. **Pagination checks** (per `doc/roadmap/phase-01-freeze-and-runtime-verification.md` Appendix B):
   - Spotlight uses `page=1` with empty `limit` on Omega binding
   - In-row cap 10 vs contract §1
   - Row header → full list behavior
   - Full list 40/page semantics
   - Empty state "No items available"

### After Runtime Evidence

8. **Update Phase 07 validation report**:
   - Fill §2 runtime columns with evidence
   - Update §6 appendix checklist pass/fail
   - Update §8 freeze checklist
   - Set Phase 07 status to **completed** in README

## Active Decisions and Considerations

| Decision | Status | Rationale |
|---|---|---|
| Keep `TMDbHelper.UserDiscover.FolderPath` property key | Temporary exception | Only used in approved search flow; rename deferred post-Phase 07 |
| Writer/director crew bindings | Temporary exception | D-038 §4; no active UX path yet |
| OSD crop image binding | Temporary exception | D-038 §4; playback OSD still uses it |
| Background blur toggle | Temporary exception | D-038 §4; user setting preserved |
| Shortcut generator presets | Temporary exception | D-038 §4; generator pipeline artifact |

## Important Patterns

1. **Edit & Replace only** — never write layout tags from scratch
2. **Preserve generator pipeline** — `script.skinvariables` drives the skin
3. **Native Kodi properties first** — `ListItem.*`, `Container.*`, `VideoPlayer.*`
4. **Velocity paths as source of truth** — `plugin://plugin.video.velocity2/?action=...`
5. **D-038 ledger as exception registry** — any remaining helper binding must be documented

## Learnings and Insights

- Arctic Fuse 3 is highly dynamic; static XML edits are overwritten
- The generator pipeline is the true "source of truth" for hub rows
- Velocity addon contracts (D-015) must be stable for skin migration to succeed
- Runtime validation is critical but requires Kodi access not available in CI
- Temporary exceptions are necessary during migration but must have clear expiration