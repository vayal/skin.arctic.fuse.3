# System Architecture & Design Patterns

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                        KODI UI LAYER                                │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌──────────┐   │
│  │  Home.xml   │  │ 1101.xml    │  │ 1102.xml    │  │ Search   │   │
│  │ 1101.xml    │  │ 1102.xml    │  │ 1106-1109.xml│ │ 1105.xml │   │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘  └────┬────┘   │
│         │                │                │                │        │
│         ▼                ▼                ▼                ▼        │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │              script.skinvariables (Generator)                │   │
│  │  Reads: shortcuts/*.xml + shortcuts/generator/*.xml          │   │
│  │  Produces: 1080i/*.xml (final UI)                           │   │
│  └──────────────────────┬──────────────────────────────────────┘   │
│                         │                                          │
│                         ▼                                          │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │              Velocity Addon (Data Layer)                     │   │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌────────────┐  │   │
│  │  │ Home     │  │ Series   │  │ Movies   │  │ Provider   │  │   │
│  │  │ list     │  │ list     │  │ list     │  │ list       │  │   │
│  │  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬──────┘  │   │
│  │       │             │             │             │          │   │
│  │       ▼             ▼             ▼             ▼          │   │
│  │  ┌─────────────────────────────────────────────────────┐   │   │
│  │  │  D-015 Contract Family: items/page/has_more/next   │   │   │
│  │  │  Progress: last_watched_at, percent_watched, etc.  │   │   │
│  │  └─────────────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
```

## Key Technical Decisions

### 1. Dynamic Generation Over Static XML

**Decision**: Use `script.skinvariables` to generate final XML from blueprint files.

**Rationale**: Arctic Fuse 3 is highly dynamic; hub rows, widgets, and submenus change frequently. Static XML becomes obsolete quickly.

**Impact**: 
- Blueprints (`shortcuts/`) are the source of truth
- Output XML (`1080i/`) is read-only from developer perspective
- Changes require regenerating via Kodi's generator pipeline

### 2. Native Kodi Properties Over Helper Properties

**Decision**: Migrate from `TMDbHelper.*` to `ListItem.*`, `Container.*`, `VideoPlayer.*`.

**Rationale**: 
- Native properties are built into Kodi; no addon dependency
- Faster rendering (no addon bridge)
- Better debugging (Kodi's native tools work)

**Impact**: 
- Phase 05 migration completed for images, labels, info, views, widgets
- Some exceptions remain documented in D-038 §4

### 3. Velocity as Single Data Source

**Decision**: Replace TMDbHelper entirely with Velocity addon.

**Rationale**: 
- TMDbHelper is unmaintained
- Velocity has clear D-015 contract
- Single source of truth simplifies debugging

**Impact**: 
- All hub rows, spotlights, and mini-hubs now use Velocity endpoints
- Pagination handled server-side by Velocity
- Progress tracking native to addon

### 4. Contract-First Migration

**Decision**: Implement addon contracts (D-015) before skin changes.

**Rationale**: 
- Skin changes depend on data shapes
- Addon must be stable before skin migration
- Prevents cascading breakage

**Impact**: 
- Phase 02 completed: all contract families implemented
- Phase 03-06 could proceed with confidence
- Phase 07 freeze locks both sides

## Design Patterns

### Pattern 1: Edit & Replace (Golden Rule)

**Rule**: Never write layout tags from scratch; only replace `<content>` and `<onclick>` paths.

**Example**:

```xml
<!-- DO: Replace paths in existing block -->
<control type="group" id="501">
  <visible>!Skin.HasSetting(HomeSwitcher.DisableSearch)</visible>
  <content>
    <playlist>plugin://plugin.video.velocity2/?action=list&list_id=home_in_progress_series&page=1</playlist>
  </content>
  <onclick>plugin://plugin.video.velocity2/?action=play&id=...</onclick>
</control>

<!-- DON'T: Write new control blocks -->
<!-- <control type="group" id="999">...</control> -->
```

### Pattern 2: Hub Widget Abstraction

**Pattern**: All hub rows use the same widget definition pattern.

**Files**: `1080i/Includes_Hubs.xml`

**Structure**:

```xml
<!-- Spotlight (Hero) -->
<control type="image" id="...">
  <visible>IsVisible(HomeSwitcher.Home.Spotlight)</visible>
  <content>$INFO[Skin.String(HomeSwitcher.Home.Spotlight.List)]</content>
</control>

<!-- Row (Standard) -->
<control type="list" id="501">
  <visible>IsVisible(HomeSwitcher.Home.InProgress)</visible>
  <content>
    <playlist>plugin://plugin.video.velocity2/?action=list&list_id=home_in_progress_series&page=1</playlist>
  </content>
</control>
```

### Pattern 3: Velocity Path Wrapper

**Pattern**: Centralize Velocity paths in wrapper includes.

**Files**: `1080i/Includes_Velocity_Paths.xml`

**Usage**:

```xml
<!-- Instead of hardcoding -->
<onclick>plugin://plugin.video.velocity2/?action=list&list_id=home_in_progress_series&page=1</onclick>

<!-- Use wrapper -->
<onclick>$INFO[Includes_Velocity_Paths.Home.InProgress.Series]</onclick>
```

### Pattern 4: D-038 Exception Registry

**Pattern**: Any remaining helper binding must be explicitly documented.

**File**: `doc/velocity/d038-legacy-property-ledger.md`

**Sections**:
- §2: Ledger batches (A/B/C/D)
- §3: Exceptions with rationale
- §4: Phase 07 reconciliation

## Component Relationships

### Home Switcher (Top Bar)

```
1080i/Includes_Home.xml
  ├─ Home_Switcher_Horz (horizontal layout)
  │   ├─ Search (magnifier icon)
  │   ├─ Home (always first)
  │   ├─ Series (1101 toggle)
  │   ├─ Movies (1102 toggle)
  │   ├─ 1103-1104 (cleared by default)
  │   └─ 1106-1108 (cleared by default)
  └─ Home_Switcher_Right_Buttons
```

### Hub Flow

```
Home.xml
  ├─ 1080i/Home.xml (main hub container)
  ├─ 1080i/Includes_Home.xml (switcher + spotlight + rows)
  │   ├─ Spotlight (from HomeSwitcher.Home.Spotlight.*)
  │   └─ Rows (from Includes_Hubs.xml)
  └─ 1080i/Includes_Hubs.xml (widget definitions)
      ├─ skinvariables-homewidgets-standard (Home)
      ├─ skinvariables-1101widgets-standard (Series)
      └─ skinvariables-1102widgets-standard (Movies)
```

### Search Flow

```
Custom_1105_Search.xml
  ├─ Velocity.Path.Discover (discover route)
  ├─ TMDbHelper.UserDiscover.FolderPath (keep-temporary key)
  └─ Includes_Search.xml (combined widgets)
      └─ skinvariables-searchwidgets-combined
```

### Details Flow

```
Includes_DialogInfo.xml
  ├─ Info_Title
  ├─ Info_Panel (service, croplogo, container params)
  ├─ Info_Meta (Rating, total episodes, TV status)
  └─ DialogVideoInfo.xml
      ├─ Full details screen
      └─ ActivateWindow(1114) → Dialog_DialogPlot.xml
```

## Critical Implementation Paths

### Path 1: Hub Row to Play

1. User clicks row card
2. Kodi reads `<content>` → Velocity `plugin://plugin.video.velocity2/?action=list&list_id=...`
3. Velocity returns item list
4. User clicks item
5. Kodi reads `<onclick>` → Velocity `plugin://plugin.video.velocity2/?action=play&id=...`
6. Velocity resolves and plays

**Key files**: `1080i/Includes_Hubs.xml`, `1080i/Home.xml`, `1080i/Includes_Home.xml`

### Path 2: Search to Play

1. User opens search (`Custom_1105_Search.xml`)
2. User selects Discover tab
3. Kodi reads `Velocity.Path.Discover` → `plugin://plugin.video.velocity2/?action=discover`
4. Velocity returns results
5. User clicks item
6. Kodi reads `<onclick>` → Velocity `plugin://plugin.video.velocity2/?action=play&id=...`

**Key files**: `1080i/Custom_1105_Search.xml`, `1080i/Includes_Search.xml`

### Path 3: Row to Full Details

1. User clicks row card
2. Kodi reads `<content>` → Velocity list
3. User clicks item
4. Kodi reads `<onclick>` → `plugin://plugin.video.velocity2/?action=info&id=...`
5. Velocity returns item properties
6. Kodi opens `1080i/DialogVideoInfo.xml`
7. Kodi reads `Includes_DialogInfo.xml` → native infolabels

**Key files**: `1080i/DialogVideoInfo.xml`, `1080i/Includes_DialogInfo.xml`

### Path 4: OSD Bridge

1. User pauses playback
2. Kodi reads `Custom_1193_VideoOSDInfo.xml`
3. Kodi executes `Action(Info)` → minimal overlay
4. User clicks overlay
5. Kodi opens `1080i/DialogVideoInfo.xml` (full details)

**Key files**: `1080i/Custom_1193_VideoOSDInfo.xml`, `1080i/DialogVideoInfo.xml`

## View Mode Matrix (D-003)

| Surface | Default Mode | Notes |
|---|---|---|
| Home | Standard | Spotlight + in-progress tabs |
| Series (1101) | Standard | 6 rows + submenu |
| Movies (1102) | Standard | 6 rows + submenu |
| Provider mini-hubs | Standard | Spotlight + trending + popular + genres |
| Search | Combined | Discover + movies + TV |
| Details | Full-screen | No small info dialog UX |
| OSD | Minimal | Title + plot on pause |

## Freeze Checklist (Phase 07)

- [x] D-003 view modes locked per surface
- [x] D-015 contract families implemented
- [x] D-021 context menu policy enforced
- [x] D-038 ledger reconciled
- [ ] Runtime evidence for browse-to-play journey
- [ ] Runtime evidence for search-to-play journey
- [ ] Runtime evidence for info-and-related journey
- [ ] Pagination behavior verified (40/page, 10/in-row)