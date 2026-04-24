# Arctic Fuse 3 Velocity Fork — Deep Documentation

## Table of Contents

1. [Introduction](#1-introduction)
2. [Project Overview](#2-project-overview)
3. [Architecture Overview](#3-architecture-overview)
4. [D-003 View Mode Matrix](#4-d-003-view-mode-matrix)
5. [D-015 Addon Contract Family](#5-d-015-addon-contract-family)
6. [D-021 Context Menu Policy](#6-d-021-context-menu-policy)
7. [D-038 legacy properties](#7-d-038-legacy-properties)
8. [Generator Pipeline Deep Dive](#8-generator-pipeline-deep-dive)
9. [Hub System Deep Dive](#9-hub-system-deep-dive)
10. [Migration Journey](#10-migration-journey)
11. [Critical Implementation Paths](#11-critical-implementation-paths)
12. [Development Guidelines](#12-development-guidelines)
13. [Phase Roadmap](#13-phase-roadmap)
14. [Appendices](#14-appendices)

---

## 1. Introduction

This document provides deep, comprehensive documentation of the Arctic Fuse 3 Velocity fork — a Kodi skin fork that completely strips out dependencies on `plugin.video.themoviedb.helper` and replaces them with a proprietary custom addon called **Velocity** (`plugin.video.velocity2`).

### The Core Problem

Arctic Fuse 3 originally relied heavily on the TMDbHelper addon for:
- Data fetching and metadata
- Progress tracking
- View mode control
- Expression evaluation

The TMDbHelper addon is:
- **Unmaintained** — No active development
- **Vendor-locked** — Tied to the original skin author
- **Overly complex** — Too many features, some never used
- **Blocking** — Prevents skin migration to other platforms

### The Solution

The Velocity fork implements a **contract-first migration** approach:
1. Define stable data contracts (D-015)
2. Implement Velocity addon with those contracts
3. Migrate skin plumbing to native Kodi properties
4. Remove all TMDbHelper dependencies
5. Document any remaining exceptions (D-038)

---

## 2. Project Overview

### Core Objective

**Replace TMDbHelper with Velocity** — Map Kodi GUI widget pathways to Velocity's routing endpoints while preserving the skin's dynamic generation architecture driven by `script.skinvariables`.

### Key Constraints (The Golden Rules)

1. **NEVER edit output XML files** (`Includes_Home.xml`, `Includes_Hubs.xml`, `Includes_Search.xml`) — they are overwritten by the generator
2. **NEVER write Kodi `<control>` XML from scratch** — you will hallucinate syntax
3. **ONLY edit blueprint/shortcut files** (`shortcuts/generator/data/setup/*.xml`, `shortcuts/generator/data/base/*.xml`, `shortcuts/skinvariables-generator.json`)
4. **Edit & Replace strategy** — preserve layout tags, only replace `<content>` and `<onclick>` paths

### Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        KODI UI LAYER                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │
│  │  Home.xml   │  │ 1101.xml    │  │ 1102.xml    │             │
│  │ 1101.xml    │  │ 1102.xml    │  │ 1106-1109.xml│             │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘             │
│         │                │                │                      │
│         ▼                ▼                ▼                      │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              script.skinvariables (Generator)            │  │
│  │  Reads: shortcuts/*.xml + shortcuts/generator/*.xml      │  │
│  │  Produces: 1080i/*.xml (final UI)                        │  │
│  └──────────────┬──────────────────────────────────────────┘  │
│                 │                                              │
│                 ▼                                              │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              Velocity Addon (Data Layer)                 │  │
│  │  ┌───────┐  ┌───────┐  ┌───────┐  ┌─────────┐           │  │
│  │  │ Home  │  │ Series│  │ Movies│  │ Provider│           │  │
│  │  │ list  │  │ list  │  │ list  │  │ list    │           │  │
│  │  └────┬──┘  └────┬──┘  └────┬──┘  └────┬────┘           │  │
│  │       │          │          │          │                  │  │
│  │       ▼          ▼          ▼          ▼                  │  │
│  │  ┌──────────────────────────────────────────────────┐   │  │
│  │  │  D-015 Contract Family: items/page/has_more/next │   │  │
│  │  │  Progress: last_watched_at, percent_watched, etc.│   │  │
│  │  └──────────────────────────────────────────────────┘   │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

### Roadmap Status

| Phase | Status | Key Deliverables |
|-------|--------|------------------|
| Phase 01 | ✅ Completed | Frozen D-003, D-015, D-021, D-038 decisions |
| Phase 02 | ✅ Completed | Velocity D-015 contracts implemented |
| Phase 03 | ✅ Completed | Core plumbing migrated (Paths, Actions, DialogInfo, OSD) |
| Phase 04 | ✅ Completed | Removals enforced (context menu, PVR, OSD cast, Wikipedia, crew, plot dialog) |
| Phase 05 | ✅ Completed | Metadata/rendering migrated (Images, Labels, Info, Views, Widgets) |
| Phase 06 | ✅ Completed | Deferred exceptions cleaned (Weather removed, blur decoupled) |
| Phase 07 | 🚧 Blocked | Requires runtime evidence |

---

## 3. Architecture Overview

### The Three Layers

#### 1. UI Layer (1080i/)

The UI layer contains all the XML files that define the skin's appearance and behavior.

**Key files:**
- `Home.xml` — Primary hub window
- `Includes_Home.xml` — Home switcher and hub rows
- `Includes_Hubs.xml` — Hub widget definitions
- `Includes_Paths.xml` — Path contract variables
- `Includes_Actions.xml` — Action dispatch
- `Includes_Velocity_Paths.xml` — Velocity path wrappers
- `Includes_DialogInfo.xml` — Details dialog wiring
- `Includes_OSD.xml` — OSD bridge

**Dialogs:**
- `DialogVideoInfo.xml` — Full details screen
- `Custom_1193_VideoOSDInfo.xml` — OSD info bridge
- `Custom_1105_Search.xml` — Search window

**Custom windows (removed/cleared):**
- `Custom_1103_Hub.xml` — Cleared by default
- `Custom_1104_Hub.xml` — Cleared by default
- `Custom_1106_NextAired.xml` — Cleared by default
- `Custom_1107_LiveTV.xml` — Cleared by default
- `Custom_1108_Addons.xml` — Cleared by default
- `Custom_1161_Dialog_Weather.xml` — Removed (Phase 06)
- `Custom_1180_Dialog_Bumper.xml` — Keep-temporary
- `Custom_1195_SkinUserLoginScreen.xml` — Keep-temporary

#### 2. Generator Layer (shortcuts/)

The generator layer contains the blueprint files that define the UI structure.

**Key files:**
- `skinvariables-generator.json` — Generator configuration
- `skinvariables-shortcut-config.json` — Shortcut editor presets
- `skinvariables-shortcut-homewidgets.json` — Home widget shortcuts
- `skinvariables-shortcut-searchwidgets.json` — Search widget shortcuts

**Generator data:**
```
generator/data/base/
  home_widgets.xml              # Standard home widgets
  home_widgets_combined.xml     # Combined view widgets
  home_widgets_standard.xml     # Standard view widgets
  search_widgets.xml            # Search widgets
  search_widgets_standard.xml   # Standard search widgets
  power_main.xml                # Power menu widgets
  search_info.xml               # Search info widgets

generator/data/setup/
  widgets_row.xml               # Row widget setup
  widgets_spotlight.xml         # Spotlight widget setup
  widgets_standard.xml          # Standard widget setup
  onclick_path.xml              # On-click path setup
  search_path.xml               # Search path setup
  search_row.xml                # Search row setup
  widgets_include_row.xml       # Row include setup
  widgets_include_wall.xml      # Wall include setup

generator/data/parts/
  widgets_row.xmltemplate       # Row widget template
  widgets_spotlight.xmltemplate # Spotlight widget template
  widgets_standard.xmltemplate  # Standard widget template
  widgets_selector.xmltemplate  # Selector widget template
```

#### 3. Data Layer (Velocity Addon)

The Velocity addon provides the data contracts that the skin consumes.

**Contract families:**
- **Home contracts** — `home_spotlight_mixed`, `home_in_progress_series`, `home_in_progress_movies`
- **Series hub contracts** — `series_spotlight_trending`, `series_continue_watching_episodes`, etc.
- **Movies hub contracts** — `movies_spotlight_trending`, `movies_in_progress`, etc.
- **Provider mini-hub contracts** — `provider_{id}_spotlight`, `provider_{id}_trending`, etc.
- **Search contracts** — `search_movies`, `search_tvshows`

---

## 4. D-003 View Mode Matrix

### Purpose

The D-003 View Mode Matrix enumerates all relevant screen/surface families that require an explicit view-mode decision and locks one primary mode per surface/list family. No fallback mode switching in the target UX.

### Mode Options

- **Standard** — Default list view
- **Combined** — Multiple view modes stacked
- **Wall** — Large poster grid
- **N/A** — Surface does not use hub mode system

### Surface Decisions

#### Hub and mini-hub surfaces (HomeSwitcher-backed)

| Surface ID | Surface/Window | Uses HomeSwitcher mode | Decision | Notes |
|---|---|---|---|---|
| `HS-home` | Home root (`Home` window); `HomeSwitcher.Home.*` | Yes | **Combined** | Primary home IA; spotlight/list wiring under `HomeSwitcher.Home.*` |
| `HS-series` | Series hub window **1101**; `HomeSwitcher.1101.*` | Yes | **Combined** | `ReplaceWindow(1101)` from switcher when enabled |
| `HS-movies` | Movies hub window **1102**; `HomeSwitcher.1102.*` | Yes | **Combined** | `ReplaceWindow(1102)` from switcher when enabled |
| `HS-hub-1103` | Optional hub **1103**; `HomeSwitcher.1103.*` | Yes | **Combined** | Cleared by default in bootstrap; optional slot |
| `HS-hub-1104` | Optional hub **1104**; `HomeSwitcher.1104.*` | Yes | **Combined** | Cleared by default in bootstrap; optional slot |
| `HS-nextaired` | Calendar / Up Next hub **1106**; `HomeSwitcher.1106.*` | Legacy/toggle-dependent | **N/A** | Off by default after bootstrap |
| `HS-pvr` | Live TV hub **1107**; `HomeSwitcher.1107.*` | Legacy/toggle-dependent | **N/A** | Off by default; core Kodi PVR may still exist outside this fork's hub scope |
| `HS-addons` | Add-ons hub **1108**; `HomeSwitcher.1108.*` | Legacy/toggle-dependent | **Wall** | Off by default; may route to `addonbrowser` |
| `HS-weather` | Weather | — | **N/A** | **Removed** (Phase 06); not mapped to a hub window or `HomeSwitcher.*` slot |
| `HS-settingshub` | Settings hub **1109** (`Custom_1109_Settings.xml`); `HomeSwitcher.1109.*` | Legacy/toggle-dependent | **N/A** | Settings hub behavior deferred as needed |

#### Provider mini-hubs

Provider mini-hubs follow the same stacked row philosophy and use **Combined** mode when modeled through HomeSwitcher/generated hub includes.

#### Search/discovery/list surfaces (non-hub or mixed)

| Surface ID | Surface | View-style decision needed | Decision | Notes |
|---|---|---|---|---|
| `SEARCH-main` | Search window (`Custom_1105_Search.xml`) | Yes | **Combined** | locked by D-006 |
| `SEARCH-selector` | Search selector tabs (`Includes_Search.xml`) | Yes | **N/A** | selector IA is tab set, not HomeSwitcher mode |
| `DISCOVER-list` | Discover full list screens | Yes | **Poster** (default) | use row-family defaults unless a list explicitly overrides |
| `GENRE-global` | Genre filtered global lists | Yes | **Poster** | consistent with global trending rows |
| `GENRE-provider` | Provider genre lists | Yes | **Poster** | consistent with provider trending/popular/genre rows |

#### Details/context/OSD surfaces (explicitly non-hub-mode)

| Surface ID | Surface | Decision | Notes |
|---|---|---|---|
| `INFO-main` | Full details screen (`DialogVideoInfo.xml`) | **Full details only** | no small info dialog UX |
| `INFO-plot` | Plot/custom details (`Dialog_DialogPlot.xml`, `Custom_1114`) | **Simplified bridge** | align with no-small-dialog policy |
| `CTX-expanded` | Expanded context menu (`Dialog_DialogContextMenu.xml`) | **Remove expanded dialog items** | watched/unwatched + add-to-library delegated to addon logic |
| `OSD-main` | Main OSD (`Includes_OSD.xml`) | **Normal controls only** | locked by D-027 direction |
| `OSD-pause-strip` | Pause info strip | **Minimal title + plot** | locked by D-027 direction |
| `OSD-bridge` | OSD info bridge (`Custom_1193`) | **Lightweight overlay -> full details** | locked by E2 behavior |

### Completion Rule for D-003

D-003 can move from `modify` to `accept` when:
- Every active surface above has a filled `Decision`
- Any non-applicable surface is explicitly marked `N/A` with reason
- No surface relies on runtime fallback mode switching

---

## 5. D-015 Addon Required Lists Contract

### Purpose

D-015 enumerates all addon-provided lists/feeds required by the frozen skin vision, defines contract characteristics so skin wiring is deterministic, and serves as the handoff document for addon implementation.

### Contract Schema

For each list/feed, define:
- `contract_id`: stable identifier used by skin routing
- `media_scope`: `movie` / `show` / `episode` / `mixed`
- `surface_usage`: where it appears in skin
- `sort_rule`: explicit sort semantics
- `pagination`: `none` for spotlight, paginated for list rows
- `pagination_payload`: `items`, `page`, `has_more`, `next_page`
- `page_size`: 40 for full-list page contract
- `required_item_fields`: strict canonical IDs, metadata fields
- `default_action_semantics`: what skin should do when clicked
- `empty_behavior`: return clean empty lists and let skin render `No items available`

### Home Contracts

| contract_id | media_scope | surface_usage | sort_rule | pagination | notes |
|---|---|---|---|---|---|
| `home_spotlight_mixed` | mixed movie+show | Home spotlight hero | fixed alternation movie/show | none | non-paginated only |
| `home_in_progress_series` | show/episode-linked | Home row tab A | last watched desc | paginated | in-row cap 10, full-list paging 40 |
| `home_in_progress_movies` | movie | Home row tab B | last watched desc | paginated | in-row cap 10, full-list paging 40 |

### Series Hub Contracts

| contract_id | media_scope | surface_usage | sort_rule | pagination | notes |
|---|---|---|---|---|---|
| `series_spotlight_trending` | show | Series spotlight | trending | none | no next-page semantics |
| `series_continue_watching_episodes` | episode | Continue watching episodes row | priority logic (in-progress episode first, else next unwatched aired) then recency | paginated | addon-owned guaranteed ordering behavior |
| `series_in_progress_shows` | show | In-progress shows row | last watched desc | paginated | default click opens show/details |
| `series_global_trending` | show | Global trending row | trending desc | paginated | label `Trending` |
| `series_provider_icons` | provider entities | Provider icon row | fixed curated provider order | none | no "all providers" item |

### Movies Hub Contracts

| contract_id | media_scope | surface_usage | sort_rule | pagination | notes |
|---|---|---|---|---|---|
| `movies_spotlight_trending` | movie | Movies spotlight | trending | none | non-paginated spotlight |
| `movies_in_progress` | movie | In Progress row | last watched desc | paginated | label locked: `In Progress` |
| `movies_global_trending` | movie | Global trending row | trending desc | paginated | label `Trending` |
| `movies_provider_icons` | provider entities | Provider icon row | fixed curated provider order | none | same provider roster |

### Provider Mini-Hub Contracts

Provider IDs (curated roster):
- `netflix`
- `disney_plus`
- `prime_video`
- `apple_tv_plus`
- `hulu`
- `max`
- `paramount_plus`
- `peacock`
- `bbc_iplayer`

Required contract families per provider `{provider_id}`:

| contract_id pattern | media_scope | surface_usage | sort_rule | pagination | notes |
|---|---|---|---|---|---|
| `provider_{provider_id}_{media}_spotlight` | media-specific (`movie` or `show`) | provider spotlight | trending/editorial (30-day basis where applicable) | none | subtle provider branding, content-first |
| `provider_{provider_id}_{media}_trending` | media-specific (`movie` or `show`) | provider trending row | trending desc (30-day basis where applicable) | paginated | row title `Trending on <Provider>` |
| `provider_{provider_id}_{media}_popular` | media-specific (`movie` or `show`) | provider most popular row | popularity desc (30-day basis where applicable) | paginated | naming consistency across providers |
| `provider_{provider_id}_{media}_genre_{genre}` | media-specific (`movie` or `show`) | provider genre rows | genre + trending/popularity (30-day basis where applicable) | paginated | fixed genre family; long-form standardized route family |

### Genre Discovery Contracts (global + provider)

Fixed genre set:
- Action
- Comedy
- Drama
- Thriller
- Romance
- Sci-Fi
- Crime
- Animation

Recommended explicit global contract IDs:
- `genre_global_action`
- `genre_global_comedy`
- `genre_global_drama`
- `genre_global_thriller`
- `genre_global_romance`
- `genre_global_scifi`
- `genre_global_crime`
- `genre_global_animation`

Provider genre contract IDs:
- `provider_{provider_id}_genre_{genre_slug}`

**Decision locked:** Each genre contract is media-specific and standardized per provider/genre route family. Keep the fixed 8 genres now, with optional future extension.

### Search Contracts

Selector tabs:
- Discover
- Movies
- TV Shows

Required contracts:
- `search_movies`
- `search_tvshows`
- optional additional explicit routes only when directly required by frozen hub/mini-hub/search surfaces (no generic `discover_root` requirement)

Search parameter model:
- `query`
- `media_type`
- `page`
- `sort`

Alias policy:
- keep only aliases required for Discover/Movies/TV
- remove unused legacy/music alias families

### Cross-Cutting Contract Guarantees

1. **Pagination guarantees:**
   - Spotlight contracts: non-paginated
   - Row contracts: compatible with in-row 10 cap + row-end next-page affordance
   - Full-list contracts: 40 items per page

2. **Item identity guarantees:**
   - stable canonical internal IDs for play, info/details, and deep-view navigation
   - include canonical provider/genre identifiers where required for routing

3. **Metadata guarantees by surface:**
   - Spotlight: title/year/runtime/rating/short_plot/artwork
   - Row cards (image-only): artwork still mandatory; metadata available for focused info panel/details transitions
   - Pause strip: title + short plot

4. **Empty list guarantees:**
   - clean empty list response (no fake next-page item in spotlight feeds)

### Completion Criteria for D-015

D-015 can move from `modify` to `accept` when:
- Every contract above has an implemented addon route or mapped equivalent
- Route naming/parameters are frozen and documented
- Skin path wiring references only these frozen contracts
- Paging and metadata guarantees are validated on hub, mini-hub, and search surfaces

---

## 6. D-021 Context Menu Policy

### Overview

D-021 defines the policy for context menu behavior in the Velocity fork. The policy is: **remove expanded skin items and rely on addon context items**.

### Expanded Context Menu Removal

The expanded context menu (`Dialog_DialogContextMenu.xml`) has been removed from active UX:

```xml
<!-- D-021: has_menu forced false -->
<visible>!has_menu</visible>
```

**Decision:** `has_menu` is forced `false` (D-021); header/poster still read `TMDbHelper.ListItem.base_*` when `$EXP[Exp_AllowExpandedContextMenu]` (see D-038 §4).

### Context Menu Items Policy

**What was removed:**
- Watched/unwatched items
- Add-to-library items
- Any expanded dialog items

**What remains:**
- Addon-provided context items (handled by Velocity addon)

### Rationale

1. **Addon ownership** — Context menu items are addon concerns, not skin concerns
2. **Simplified UX** — Fewer menu items = less cognitive load
3. **Consistency** — All addons use their own context menu items
4. **Skin neutrality** — Skin doesn't dictate addon behavior

### Implementation

The context menu policy is enforced via:
- `has_menu` forced `false` in `Dialog_DialogContextMenu.xml`
- D-021 decision locked in D-003 view mode matrix
- D-038 ledger entry for any remaining references

### Completion Status

D-021 is **locked and enforced**:
- ✅ Expanded dialog items removed
- ✅ `has_menu` forced `false`
- ✅ No policy regressions in core UX
- ⚠️ Header/poster still read TMDbHelper.ListItem.base_* (D-038 §4)

---

## 7. D-038 legacy properties

**Canonical document:** [d038-legacy-properties-and-mapping.md](./d038-legacy-properties-and-mapping.md) — file-level **ledger**, transfer batches, documented `keep-temporary` exceptions, completion criteria, and the **TMDbHelper → native/Velocity mapping** table.

This fork doc previously inlined the full ledger; that content now lives only in **context** to avoid drift. For D-021 interaction with residual helper symbols, still see **§4** in that document.

## 8. Generator Pipeline Deep Dive

### Overview

The generator pipeline uses `script.skinvariables` to generate final XML from blueprint files. This is the true "source of truth" for hub rows — static XML edits are overwritten.

### Pipeline Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Generator Pipeline                       │
├─────────────────────────────────────────────────────────────┤
│  Input Layer                                               │
│  ├─ shortcuts/*.xml (shortcut definitions)                  │
│  ├─ shortcuts/generator/data/base/*.xml (base widgets)      │
│  ├─ shortcuts/generator/data/setup/*.xml (setup overrides)  │
│  └─ shortcuts/generator/data/parts/*.xmltemplate (templates)│
├─────────────────────────────────────────────────────────────┤
│  Processing Layer                                          │
│  ├─ Read shortcuts                                          │
│  ├─ Apply overrides                                         │
│  ├─ Generate variables                                      │
│  └─ Resolve templates                                       │
├─────────────────────────────────────────────────────────────┤
│  Output Layer                                              │
│  └─ 1080i/*.xml (final UI XML)                              │
└─────────────────────────────────────────────────────────────┘
```

### Generator Configuration

**skinvariables-generator.json:**
```json
{
  "shortcuts": [
    "shortcuts/skinvariables-shortcut-homewidgets.json",
    "shortcuts/skinvariables-shortcut-searchwidgets.json"
  ],
  "base": "shortcuts/generator/data/base/",
  "setup": "shortcuts/generator/data/setup/",
  "parts": "shortcuts/generator/data/parts/",
  "output": "1080i/"
}
```

### Shortcut Files

Shortcut files define variables in a structured format:

**Example: Home widgets shortcut**
```xml
<shortcut>
  <name>Home widgets</name>
  <description>Home hub widget definitions</description>
  <category>Home</category>
  
  <variable>
    <name>HomeSwitcher.Home.Spotlight.List</name>
    <value>plugin://plugin.video.velocity2/?action=list&list_id=home_spotlight_mixed&page=1</value>
    <visible>IsVisible(HomeSwitcher.Home.Spotlight)</visible>
  </variable>
  
  <variable>
    <name>HomeSwitcher.Home.InProgress.Series.List</name>
    <value>plugin://plugin.video.velocity2/?action=list&list_id=home_in_progress_series&page=1</value>
    <visible>IsVisible(HomeSwitcher.Home.InProgress.Series)</visible>
  </variable>
</shortcut>
```

### Generator Data Structure

**Base widgets (generator/data/base/):**
- `home_widgets.xml` — Standard home widgets
- `home_widgets_combined.xml` — Combined view widgets
- `home_widgets_standard.xml` — Standard view widgets
- `search_widgets.xml` — Search widgets
- `search_widgets_standard.xml` — Standard search widgets
- `power_main.xml` — Power menu widgets
- `search_info.xml` — Search info widgets

**Setup overrides (generator/data/setup/):**
- `widgets_row.xml` — Row widget setup
- `widgets_spotlight.xml` — Spotlight widget setup
- `widgets_standard.xml` — Standard widget setup
- `onclick_path.xml` — On-click path setup
- `search_path.xml` — Search path setup
- `search_row.xml` — Search row setup
- `widgets_include_row.xml` — Row include setup
- `widgets_include_wall.xml` — Wall include setup

**Parts templates (generator/data/parts/):**
- `widgets_row.xmltemplate` — Row widget template
- `widgets_spotlight.xmltemplate` — Spotlight widget template
- `widgets_standard.xmltemplate` — Standard widget template
- `widgets_selector.xmltemplate` — Selector widget template

### Generator Template Example

**widgets_row.xmltemplate:**
```xml
<include name="widgets_row">
  <control type="list" id="501">
    <visible>IsVisible(HomeSwitcher.Home.InProgress.Series)</visible>
    <content>
      <playlist>$INFO[Skin.String(HomeSwitcher.Home.InProgress.Series.List)]</playlist>
    </content>
  </control>
</include>
```

### Override Files

Override files are loaded before the generator includes, allowing custom widget definitions:

```xml
<!-- script-skinvariables-generator-overrides.xml -->
<include name="custom_widgets">
  <control type="list" id="501">
    <visible>IsVisible(HomeSwitcher.Home.InProgress.Series)</visible>
    <content>
      <playlist>$INFO[Skin.String(HomeSwitcher.Home.InProgress.Series.List)]</playlist>
    </content>
  </control>
</include>
```

### Generator Pipeline Steps

1. **Read shortcuts** — Parse all shortcut files in `shortcuts/`
2. **Apply overrides** — Load `script-skinvariables-generator-overrides.xml`
3. **Generate variables** — Create skin variables from shortcuts
4. **Resolve templates** — Process `.xmltemplate` files
5. **Output XML** — Write final window XML files to `1080i/`

### Golden Rule

**NEVER edit output XML files** (`Includes_Home.xml`, `Includes_Hubs.xml`, `Includes_Search.xml`) — they are overwritten by the generator. Only edit blueprint/shortcut files.

---

## 9. Hub System Deep Dive

### Overview

The hub system is the primary navigation surface in Kodi skins. It features a spotlight/hero section, tabbed or stacked row sections, and navigation controls.

### HomeSwitcher System

The HomeSwitcher system is a property-based configuration mechanism that manages which hub windows are enabled, their display names, and their operational modes.

#### Architecture

```
HomeSwitcher System
├── HomeSwitcher.Home.*    # Primary home IA
├── HomeSwitcher.1101.*    # Series hub window
├── HomeSwitcher.1102.*    # Movies hub window
├── HomeSwitcher.1103.*    # Optional hub 1103
├── HomeSwitcher.1104.*    # Optional hub 1104
├── HomeSwitcher.1106.*    # Next Aired hub
├── HomeSwitcher.1107.*    # Live TV hub
├── HomeSwitcher.1108.*    # Add-ons hub
├── HomeSwitcher.1109.*    # Settings hub
└── HomeSwitcher.LoopBack  # Loop navigation
```

#### Variables

**Visibility variables:**
```xml
<variable name="IsVisible(HomeSwitcher.Home.Spotlight)" value="true" />
<variable name="IsVisible(HomeSwitcher.Home.InProgress.Series)" value="true" />
<variable name="IsVisible(HomeSwitcher.Home.InProgress.Movies)" value="true" />
```

**Mode variables:**
```xml
<variable name="HomeSwitcher.Home.Mode" value="Combined" />
<variable name="HomeSwitcher.1101.Mode" value="Combined" />
<variable name="HomeSwitcher.1102.Mode" value="Combined" />
```

#### Bootstrap

The bootstrap initializes the HomeSwitcher system:

```xml
<control type="button" id="1001">
  <onclick>
    Skin.Reset(HomeSwitcher.1101.Toggle)
    Skin.Reset(HomeSwitcher.1102.Toggle)
    Skin.Reset(HomeSwitcher.LoopBack)
    ActivateWindow(Startup)
  </onclick>
</control>
```

### Home Hub Structure

```xml
<control type="group" id="50">
  <control type="image" id="51">
    <!-- Spotlight/hero -->
  </control>
  <control type="list" id="52">
    <!-- In-progress series tab -->
  </control>
  <control type="list" id="53">
    <!-- In-progress movies tab -->
  </control>
</control>
```

### Hub Switcher (Includes_Home.xml)

```xml
<control type="group" id="1001">
  <visible>IsVisible(HomeSwitcher.Home.Spotlight)</visible>
  <control type="button" id="1002">
    <label>Spotlight</label>
  </control>
  <control type="button" id="1003">
    <label>In Progress</label>
  </control>
</control>
```

### Hub Widgets (Includes_Hubs.xml)

Hub widgets define the structure of hub rows:

```xml
<include name="skinvariables-homewidgets-standard">
  <control type="group" id="501">
    <visible>IsVisible(HomeSwitcher.Home.InProgress.Series)</visible>
    <control type="list" id="502">
      <content>
        <playlist>$INFO[Skin.String(HomeSwitcher.Home.InProgress.Series.List)]</playlist>
      </content>
    </control>
  </control>
</include>
```

### Widget Types

**Spotlight (Hero):**
- Single large item
- Info-focused display
- Play/Info actions

**Standard Row:**
- Multiple items in a row
- Image-only cards
- Play/Info actions

**Provider Icon Row:**
- Small square icons
- Opens provider mini-hub

**Genre Navigation:**
- Button/list-entry style
- Opens filtered list

### Pagination Semantics

**In-row cap:** 10 items before row-end "Next Page"
**Full list:** 40 items per page
**Spotlights:** Non-paginated

**Pagination payload:**
- `items` — Array of items
- `page` — Current page number
- `has_more` — Boolean
- `next_page` — Page number, omitted on terminal

---

## 10. Migration Journey

### Phase 01: Preflight and Contract Lock

**Status:** ✅ Completed

**Key deliverables:**
- Frozen D-003, D-015, D-021, D-038 decisions
- Locked execution boundaries
- Execution boundaries explicit

**Decisions:**
- D-003: View mode matrix per surface
- D-015: Addon list contract families
- D-021: Context menu policy
- D-038: Legacy property migration ledger

### Phase 02: Addon Contract Implementation

**Status:** ✅ Completed

**Key deliverables:**
- Implemented D-015 contract families in Velocity addon
- Added pagination payload (`items/page/has_more/next_page`)
- Terminal page omits `next_page`
- Progress fields: `last_watched_at`, `percent_watched`, `resume_point`, `is_in_progress`

**Contract families:**
- Home contracts
- Series hub contracts
- Movies hub contracts
- Provider mini-hub contracts
- Search contracts

### Phase 03: Skin Core Plumbing Migration

**Status:** ✅ Completed

**Key deliverables:**
- Migrated `Includes_Paths.xml` — Path contract variables
- Migrated `Includes_Actions.xml` — Action dispatch
- Migrated `Includes_DialogInfo.xml` — Details wiring
- Migrated OSD bridge (`Custom_1193_VideoOSDInfo.xml`)
- Fork default IA bootstrap slice — first-run now enables only Home/Series/Movies toggles

**Batch B (locked):**
- `Includes_Paths.xml` → replace helper monitor/tmdb-id property plumbing with Velocity/native canonical ID/routing contracts
- `Includes_Actions.xml` → keep minimal dispatch only; remove helper service/blur/rating toggles
- `Includes_DialogInfo.xml` → replace/remove helper-heavy details rails; retain curated full-details content only
- `DialogVideoInfo.xml` → replace remaining helper guards with Velocity/native expressions
- `Dialog_DialogPlot.xml` → simplify to full-details flow and remove helper mode/path dependencies
- `Custom_1114_Dialog_CustomPlot.xml` → simplify/remove helper path usage aligned to full-details flow
- `Custom_1193_VideoOSDInfo.xml` → replace helper-linked metadata while preserving overlay->details behavior
- `Includes_Search.xml` → replace helper search guards/properties while preserving combined search UX

### Phase 04: Skin Removal and Policy Enforcement

**Status:** ✅ Completed

**Key deliverables:**
- Removed expanded context menu (`Dialog_DialogContextMenu.xml` — `has_menu` forced false)
- Removed OSD cast dialog (`Custom_1141_OSD_Cast.xml` deleted)
- Removed PVR dialog family (6 files deleted)
- Removed Wikipedia/crew flows (`script-wikipedia.xml`, `Custom_1120_Dialog_SelectCrew.xml`)
- Removed small plot dialog (`Custom_1113_Dialog_Plot.xml` deleted)
- Removed helper settings entry points

**Batch A (locked):**
- `Dialog_DialogContextMenu.xml`
- `Custom_1141_OSD_Cast.xml`
- PVR family (`Dialog_DialogPVRInfo.xml`, `DialogPVR*`)
- helper addon settings entries in `Settings.xml` and `Includes_SkinSettings.xml`
- helper-only crew/wikipedia surfaces (`script-wikipedia.xml`, `Custom_1120_Dialog_SelectCrew.xml`)

### Phase 05: Metadata and Rendering Migration

**Status:** ✅ Completed

**Key deliverables:**
- Migrated `Includes_Images.xml` — artwork paths use native `ListItem`/`Container`/`VideoPlayer`
- Migrated `Includes_Labels.xml` — overlay/OSD labels use native infolabels
- Migrated `Includes_Info.xml` — replaced multi-aggregator ratings with single `Rating` row
- Migrated `Includes_Views*` — no remaining TMDbHelper references
- Migrated trailer plumbing (C10A) — `Container.ListItem.Trailer` then `ListItem.Trailer`

**Batch C (locked):**
- `Includes_Images.xml` → replace helper image/blur/status dependencies with Velocity/native metadata fields
- `Includes_Labels.xml` → replace helper-derived labels with Velocity/native payload fields
- `Includes_Info.xml` → replace helper expression-gated fields with Velocity/native expressions/properties
- `Includes_Overlay.xml` → replace helper-bound overlay labels/artwork bindings
- `Includes_Views*` → replace helper aliases/label sources
- `Includes_Widgets.xml` → replace helper widget info bindings
- `Includes_Lists.xml` → replace helper list property usage
- `Home.xml` and `Includes_Home.xml` → replace remaining helper-bound home labels/properties

### Phase 06: Deferred Exceptions and Final Cleanup

**Status:** ✅ Completed

**Key deliverables:**
- Removed weather surfaces (`MyWeather.xml`, `Custom_1161_Dialog_Weather.xml`)
- Renamed `Action_TMDbHelper_Toggle_Onclick` → `Action_Skin_LegacyBlurDataToggle_Onclick`
- Decoupled scheme blur from `Exp_TMDbHelper_IsBlur` to `Skin.HasSetting(TMDbHelper.EnableBlur)`
- D-038 ledger updated

**Batch D (locked):**
- `MyWeather.xml` → remove (never used in target fork)
- `Custom_1161_Dialog_Weather.xml` → remove (never used in target fork)
- `Custom_1180_Dialog_Bumper.xml` → keep-temporary for now; replace when bumper flow is touched

### Phase 07: Stabilization and Freeze

**Status:** 🚧 Blocked

**Remaining:** Runtime validation evidence

**Evidence needed:**
- Browse-to-play journey (Home → Series hub → Continue watching → Play)
- Search-to-play journey (Discover → Movie → Play)
- Info-and-related journey (Row → Full details → Trailer)
- Pagination: in-row cap 10
- Pagination: full list 40/page
- Empty state: "No items available" rendering

**Bootstrap reset procedure:**
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

---

## 11. Critical Implementation Paths

### Path 1: Hub Row to Play

```
1. User clicks row card
2. Kodi reads <content> → Velocity plugin://plugin.video.velocity2/?action=list&list_id=home_in_progress_series&page=1
3. Velocity returns item list
4. User clicks item
5. Kodi reads <onclick> → Velocity plugin://plugin.video.velocity2/?action=play&id=...
6. Velocity resolves and plays
```

**Key files:** `1080i/Includes_Hubs.xml`, `1080i/Home.xml`, `1080i/Includes_Home.xml`

### Path 2: Search to Play

```
1. User opens search (Custom_1105_Search.xml)
2. User selects Discover tab
3. Kodi reads Velocity.Path.Discover → plugin://plugin.video.velocity2/?action=discover
4. Velocity returns results
5. User clicks item
6. Kodi reads <onclick> → Velocity plugin://plugin.video.velocity2/?action=play&id=...
```

**Key files:** `1080i/Custom_1105_Search.xml`, `1080i/Includes_Search.xml`

### Path 3: Row to Full Details

```
1. User clicks row card
2. Kodi reads <content> → Velocity list
3. User clicks item
4. Kodi reads <onclick> → plugin://plugin.video.velocity2/?action=info&id=...
5. Velocity returns item properties
6. Kodi opens 1080i/DialogVideoInfo.xml
7. Kodi reads Includes_DialogInfo.xml → native infolabels
```

**Key files:** `1080i/DialogVideoInfo.xml`, `1080i/Includes_DialogInfo.xml`

### Path 4: OSD Bridge

```
1. User pauses playback
2. Kodi reads Custom_1193_VideoOSDInfo.xml
3. Kodi executes Action(Info) → minimal overlay
4. User clicks overlay
5. Kodi opens 1080i/DialogVideoInfo.xml (full details)
```

**Key files:** `1080i/Custom_1193_VideoOSDInfo.xml`, `1080i/DialogVideoInfo.xml`

---

## 12. Development Guidelines

### Golden Rules

1. **Never write Kodi `<control>` XML from scratch** — You will hallucinate syntax. Always reference existing files.

2. **Use includes and variables over duplicating long `plugin://` strings** — Centralize and reuse.

3. **URL-encode query values where needed** — Special characters in addon URLs must be encoded.

4. **Preserve generator pipeline** — `script.skinvariables` drives the skin; static XML edits are overwritten.

5. **Edit & Replace strategy** — Preserve layout tags, only replace `<content>` and `<onclick>` paths.

6. **Use native Kodi properties first** — `ListItem.*`, `Container.*`, `VideoPlayer.*` over helper properties.

7. **Document exceptions** — Any remaining helper binding must be explicitly documented.

### Code Style

**Consistent indentation:**
```xml
<control type="group" id="501">
  <visible>IsVisible(HomeSwitcher.Home.InProgress.Series)</visible>
  <content>
    <playlist>plugin://plugin.video.velocity2/?action=list&list_id=home_in_progress_series&page=1</playlist>
  </content>
  <onselect>
    <action>
      <action type="playlist" pos="10" />
    </action>
  </onselect>
</control>
```

**Meaningful IDs:**
- Group containers: `501`, `502`, etc.
- Lists: `503`, `504`, etc.
- Buttons: `1001`, `1002`, etc.
- Labels: `2001`, `2002`, etc.

**Conditional visibility:**
```xml
<visible>
  <or>
    <condition expression="IsVisible(HomeSwitcher.Home.Spotlight)" />
    <condition expression="IsVisible(HomeSwitcher.Home.InProgress.Series)" />
  </or>
</visible>
```

### Testing Checklist

- [ ] Navigate to each hub window
- [ ] Verify spotlight displays correctly
- [ ] Check row content loads
- [ ] Test navigation between rows
- [ ] Verify search functionality
- [ ] Check details dialog
- [ ] Test OSD bridge
- [ ] Verify pagination behavior
- [ ] Check empty state rendering

### Finding References

```bash
# Search all XML files
rg "TMDbHelper|TMDBHelper|Exp_TMDbHelper" 1080i/*.xml

# Search specific files
rg "TMDbHelper" 1080i/Includes_Hubs.xml

# Count matches
rg "TMDbHelper" 1080i/*.xml | wc -l
```

### Performance Considerations

- **First-run:** ~5-10 seconds (bootstrap + generator)
- **Reload:** ~2-5 seconds (skin reset)
- **Generator overhead:** Minimal (uses Kodi's native variable system)

---

## 13. Phase Roadmap

### Phase 01: Preflight and Contract Lock

**Status:** ✅ Completed

**Objectives:**
- Define D-003, D-015, D-021, D-038 decisions
- Lock execution boundaries
- Document legacy properties

**Deliverables:**
- D-003 View Mode Matrix
- D-015 Addon Contract Family
- D-021 Context Menu Policy
- D-038 legacy properties ([context doc](./d038-legacy-properties-and-mapping.md))

### Phase 02: Addon Contract Implementation

**Status:** ✅ Completed

**Objectives:**
- Implement D-015 contract families in Velocity addon
- Add pagination payload
- Add progress fields

**Deliverables:**
- Home contracts
- Series hub contracts
- Movies hub contracts
- Provider mini-hub contracts
- Search contracts

### Phase 03: Skin Core Plumbing Migration

**Status:** ✅ Completed

**Objectives:**
- Migrate path contracts
- Migrate action dispatch
- Migrate details wiring
- Migrate OSD bridge

**Deliverables:**
- `Includes_Paths.xml` migrated
- `Includes_Actions.xml` migrated
- `Includes_DialogInfo.xml` migrated
- `Custom_1193_VideoOSDInfo.xml` migrated

### Phase 04: Skin Removal and Policy Enforcement

**Status:** ✅ Completed

**Objectives:**
- Remove expanded context menu
- Remove OSD cast dialog
- Remove PVR dialog family
- Remove Wikipedia/crew flows
- Remove small plot dialog
- Remove helper settings entry points

**Deliverables:**
- `Dialog_DialogContextMenu.xml` removed
- `Custom_1141_OSD_Cast.xml` removed
- PVR family removed
- Wikipedia/crew flows removed
- `Custom_1113_Dialog_Plot.xml` removed

### Phase 05: Metadata and Rendering Migration

**Status:** ✅ Completed

**Objectives:**
- Migrate image rendering
- Migrate label rendering
- Migrate info rendering
- Migrate view rendering
- Migrate widget rendering

**Deliverables:**
- `Includes_Images.xml` migrated
- `Includes_Labels.xml` migrated
- `Includes_Info.xml` migrated
- `Includes_Views*` migrated
- `Includes_Widgets.xml` migrated

### Phase 06: Deferred Exceptions and Final Cleanup

**Status:** ✅ Completed

**Objectives:**
- Remove weather surfaces
- Decouple scheme blur
- Update D-038 ledger

**Deliverables:**
- `MyWeather.xml` removed
- `Custom_1161_Dialog_Weather.xml` removed
- `Action_TMDbHelper_Toggle_Onclick` renamed
- D-038 ledger updated

### Phase 07: Stabilization and Freeze

**Status:** 🚧 Blocked

**Objectives:**
- Capture runtime evidence for browse-to-play journey
- Capture runtime evidence for search-to-play journey
- Capture runtime evidence for info-and-related journey
- Verify pagination behavior
- Verify empty state rendering

**Deliverables:**
- Runtime evidence for browse-to-play
- Runtime evidence for search-to-play
- Runtime evidence for info-and-related
- Pagination verification
- Empty state verification

---

## 14. Appendices

### Appendix A: Velocity Endpoint Contract Summary

**Home Hub:** `home_spotlight_mixed`, `home_in_progress_series`, `home_in_progress_movies`

**Series Hub:** `series_spotlight_trending`, `series_continue_watching_episodes`, `series_in_progress_shows`, `series_global_trending`, `series_provider_icons`

**Movies Hub:** `movies_spotlight_trending`, `movies_in_progress`, `movies_global_trending`, `movies_provider_icons`

**Provider Mini-Hubs:** `provider_{id}_spotlight`, `provider_{id}_trending`, `provider_{id}_popular`, `provider_{id}_genre_{genre}`

**Pagination:** In-row max 10 items, full list 40/page, spotlights non-paginated

### Appendix B: Velocity Endpoint Contract Summary

**Home Hub:** `home_spotlight_mixed`, `home_in_progress_series`, `home_in_progress_movies`

**Series Hub:** `series_spotlight_trending`, `series_continue_watching_episodes`, `series_in_progress_shows`, `series_global_trending`, `series_provider_icons`

**Movies Hub:** `movies_spotlight_trending`, `movies_in_progress`, `movies_global_trending`, `movies_provider_icons`

**Provider Mini-Hubs:** `provider_{id}_spotlight`, `provider_{id}_trending`, `provider_{id}_popular`, `provider_{id}_genre_{genre}`

**Pagination:** In-row max 10 items, full list 40/page, spotlights non-paginated

### Appendix C: Current Blockers

- Phase 07 requires live Kodi runtime evidence for end-to-end journeys
- No Kodi execution environment available in CI/agent pipelines

### Appendix D: Critical Decisions (Frozen)

| ID | Scope | Status |
|---|---|---|
| D-003 | View mode matrix per surface | Frozen |
| D-015 | Addon list contract families | Frozen |
| D-021 | Context menu policy | Frozen |
| D-038 | Legacy property migration ledger | Frozen |

### Appendix E: Primary Touch Files

- `1080i/Includes_Paths.xml` — Path contract variables
- `1080i/Includes_Actions.xml` — Action dispatch
- `1080i/Includes_Home.xml` — Home switcher & hub rows
- `1080i/Includes_Hubs.xml` — Hub widget definitions
- `1080i/Custom_1105_Search.xml` — Search window (temporary helper key retained)

### Appendix F: Temporary Exceptions

| Exception | Location | Rationale | Follow-up |
|---|---|---|---|
| `TMDbHelper.UserDiscover.FolderPath` | `Custom_1105_Search.xml` | Combined discover wiring; Velocity path | Rename keys when Batch D follow-up scheduled |
| `Skin.HasSetting(TMDbHelper.EnableBlur)` | `Includes_Actions.xml` | Legacy skin.bool name; inline guard replaces expression name only in scheme block | Migrate bool namespace in Phase 07 if settings keys are renamed |

### Appendix G: Velocity Response Format

```json
{
  "items": [
    {
      "id": "123456",
      "title": "Movie Title",
      "year": 2023,
      "runtime": 120,
      "plot": "Short plot summary...",
      "rating": 7.5,
      "poster": "http://...",
      "landscape": "http://...",
      "trailer": "http://...",
      "last_watched_at": 1678886400,
      "percent_watched": 50,
      "is_in_progress": true
    }
  ],
  "page": 1,
  "has_more": true,
  "next_page": 2
}
```

### Appendix H: Pagination Contract (D-015)

| Field | Required | Notes |
|---|---|---|
| `items` | Yes | Array of items |
| `page` | Yes | Current page number |
| `has_more` | Yes | Boolean |
| `next_page` | Yes (if has_more) | Page number, omitted on terminal |
| `items_per_page` | Optional | Default: 40 for full list |

---

## References

- [Kodi Wiki - Skinning Manual](https://kodi.wiki/view/Skinning_Manual)
- [Kodi Wiki - Skin Development Introduction](https://kodi.wiki/view/Skin_development_introduction)
- [script.skinvariables GitHub](https://github.com/jurialmunkey/script.skinvariables)
- [Kodi Development Kit](https://xbmc.github.io/docs.kodi.tv/)
- [Kodi Forum - script.skinvariables thread](https://forum.kodi.tv/showthread.php?tid=353811)

---

*This documentation is specific to the Arctic Fuse 3 Velocity fork. For general Kodi skin development, refer to the official Kodi documentation.*