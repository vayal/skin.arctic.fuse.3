# Kodi Skin Core Architecture

## 1. Introduction

Kodi (formerly XBMC) is a free and open-source media player and entertainment hub. Kodi skins are the user interface themes that define how Kodi looks and behaves.

### What is a Kodi Skin?

A Kodi skin is a collection of files that controls:
- **Visual appearance**: Colors, fonts, images, textures
- **Layout**: Positions and sizes of controls (buttons, lists, labels)
- **Behavior**: Navigation, animations, interactions
- **Window management**: Which windows are shown and how they transition

### Skin File Structure

```
skin.velocity.af3/
├── addon.xml              # Skin metadata and configuration
├── 1080i/                 # Main skin directory
│   ├── Home.xml           # Primary hub window
│   ├── Includes.xml       # Core includes
│   ├── Includes_Home.xml  # Home-specific includes
│   ├── Includes_Hubs.xml  # Hub widget definitions
│   ├── Dialog_*.xml       # Dialog windows
│   ├── Custom_*.xml       # Custom windows
│   ├── IDs/               # ID definitions
│   ├── Colors.xml         # Color definitions
│   ├── Font.xml           # Font definitions
│   ├── Sizes.xml          # Size definitions
│   ├── Textures.xml       # Texture definitions
│   ├── Background.xml     # Background definitions
│   └── ...
├── colors/                # Color scheme files
├── fonts/                 # Font files
├── media/                 # Images, textures
├── scripts/               # Python scripts
├── shortcuts/             # SkinVariables shortcuts
├── language/              # Localization files
├── inventory/             # Asset inventory
├── extras/                # Extra files
└── doc/                   # Documentation
```

---

## 2. The Skin Engine

Kodi's skin engine processes XML files to render the user interface. The architecture follows a layered approach:

```
┌─────────────────────────────────────────────────────────┐
│                    Kodi Skin Engine                      │
├─────────────────────────────────────────────────────────┤
│  Output Layer  ──→  Rendered UI on screen                │
├─────────────────────────────────────────────────────────┤
│  Include Layer  ──→  Includes resolve dependencies       │
├─────────────────────────────────────────────────────────┤
│  Variable Layer ──→  Skin variables evaluated            │
├─────────────────────────────────────────────────────────┤
│  Control Layer  ──→  XML controls parsed and instantiated│
├─────────────────────────────────────────────────────────┤
│  Window Layer   ──→  Window instances created            │
├─────────────────────────────────────────────────────────┤
│  Input Layer    ──→  Remote control, keyboard, gestures  │
├─────────────────────────────────────────────────────────┤
│  Event Layer    ──→  Events trigger window changes       │
└─────────────────────────────────────────────────────────┘
```

### Skin Lifecycle

1. **Initialization**: Kodi loads `addon.xml`, reads configuration
2. **Window Creation**: User navigates to a window, XML is parsed
3. **Include Resolution**: Includes are resolved in order
4. **Variable Evaluation**: Skin variables are evaluated
5. **Control Instantiation**: Controls are created and positioned
6. **Rendering**: UI is rendered on screen
7. **Event Handling**: User input triggers events
8. **Window Transition**: User navigates to another window

### Key Concepts

| Concept | Description |
|---|---|
| **Window** | A screen in Kodi, defined by an XML file (e.g., `Home.xml`) |
| **Control** | An UI element within a window (button, list, label, etc.) |
| **Include** | A way to reuse XML code across files |
| **Skin Variable** | A dynamic value that can change at runtime |
| **Texture** | An image file used for backgrounds, buttons, etc. |
| **Furniture** | Pre-built control groups for common layouts |

---

## 3. The Three Layers

### 1. UI Layer (1080i/)

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

### 2. Generator Layer (shortcuts/)

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

### 3. Data Layer (Velocity Addon)

The Velocity addon provides the data contracts that the skin consumes.

**Contract families:**
- **Home contracts** — `home_spotlight_mixed`, `home_in_progress_series`, `home_in_progress_movies`
- **Series hub contracts** — `series_spotlight_trending`, `series_continue_watching_episodes`, etc.
- **Movies hub contracts** — `movies_spotlight_trending`, `movies_in_progress`, etc.
- **Provider mini-hub contracts** — `provider_{id}_spotlight`, `provider_{id}_trending`, etc.
- **Search contracts** — `search_movies`, `search_tvshows`

---

## 4. Architecture Diagram

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

---

## 5. Roadmap Status

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

## 6. Bootstrap Reset Procedure

To reset the HomeSwitcher system:

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

*See also: [Components](02_CORE_COMPONENTS.md), [Controls](03_CONTROLS.md), [Variables & Includes](04_VARIABLES_INCLUDES.md)*