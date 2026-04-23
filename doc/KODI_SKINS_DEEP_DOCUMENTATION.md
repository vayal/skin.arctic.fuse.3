# Kodi Skins Deep Documentation

## Table of Contents

1. [Introduction](#1-introduction)
2. [Kodi Skin Architecture Overview](#2-kodi-skin-architecture-overview)
3. [Core Skin Components](#3-core-skin-components)
4. [Window and Control Types](#4-window-and-control-types)
5. [Skin Variables and Includes](#5-skin-variables-and-includes)
6. [The script.skinvariables Addon](#6-the-scriptskinvariables-addon)
7. [HomeSwitcher System](#7-homeswitcher-system)
8. [Hub Architecture](#8-hub-architecture)
9. [View Modes](#9-view-modes)
10. [Skin Development Best Practices](#10-skin-development-best-practices)
11. [Kodi Skin Development Environment](#11-kodi-skin-development-environment)
12. [Testing and Debugging](#12-testing-and-debugging)
13. [Deployment and Distribution](#13-deployment-and-distribution)

---

## 1. Introduction

Kodi (formerly XBMC) is a free and open-source media player and entertainment hub developed for personal computers, game consoles, smart televisions, and streaming devices. Kodi skins are the user interface themes that define how Kodi looks and behaves.

### What is a Kodi Skin?

A Kodi skin is a collection of files that controls:
- **Visual appearance**: Colors, fonts, images, textures
- **Layout**: Positions and sizes of controls (buttons, lists, labels)
- **Behavior**: Navigation, animations, interactions
- **Window management**: Which windows are shown and how they transition

### Skin File Structure

```
skin.arctic.fuse.3/
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

## 2. Kodi Skin Architecture Overview

### The Skin Engine

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

- **Window**: A screen in Kodi, defined by an XML file (e.g., `Home.xml`)
- **Control**: An UI element within a window (button, list, label, etc.)
- **Include**: A way to reuse XML code across files
- **Skin Variable**: A dynamic value that can change at runtime
- **Texture**: An image file used for backgrounds, buttons, etc.
- **Furniture**: Pre-built control groups for common layouts

---

## 3. Core Skin Components

### addon.xml

The main configuration file for any Kodi skin.

```xml
<addon id="skin.arctic.fuse.3" name="Arctic Fuse 3" version="3.0.0" provider-name="jurialmunkey">
  <requires>
    <import addon="xbmc.gui" version="5.0.0" />
    <import addon="script.skinvariables" version="3.0.0" />
  </requires>
  <files>
    <dir name="1080i">
      <file name="Home.xml" />
      <file name="Includes.xml" />
    </dir>
  </files>
  <assets>
    <video thumb="icon.png" fanart="fanart.jpg" />
  </assets>
  <description>Arctic Fuse 3 is a modern, dynamic Kodi skin featuring...</description>
  <platform>all</platform>
</addon>
```

**Important fields:**
- `id`: Unique identifier (must be lowercase, no spaces)
- `name`: Display name
- `version`: Semantic versioning
- `provider-name`: Author name
- `requires`: Dependencies (Kodi version, other addons)
- `files`: Skin file paths
- `assets`: Icon and fanart references

### Windows (XML Files)

Each window is a separate XML file defining the UI layout.

**Standard Windows:**
- `Home.xml` - Main hub window
- `DialogVideoInfo.xml` - Full details dialog
- `DialogSettings.xml` - Settings dialog
- `FileBrowser.xml` - File browser
- `DialogSelect.xml` - Selection dialog

**Custom Windows:**
- `Custom_1105_Search.xml` - Search window
- `Custom_1193_VideoOSDInfo.xml` - OSD info bridge

### Includes

Includes allow code reuse and modular design.

```xml
<include name="Includes_Home.xml" />
<include name="Includes_Hubs.xml" />
```

**Types of includes:**
- **Core includes**: `Includes.xml` - essential includes loaded first
- **Window-specific**: `Includes_Home.xml`, `Includes_Search.xml`
- **Widget definitions**: `Includes_Hubs.xml` - hub row definitions
- **Control definitions**: `Includes_Buttons.xml`, `Includes_Lists.xml`

### Dialogs

Dialogs are modal windows that appear on top of the main UI.

```xml
<control type="dialog" id="1001">
  <visible>Control.HasFocus(1001)</visible>
  <control type="label" id="1002">
    <label>Continue?</label>
  </control>
</control>
```

**Common dialogs:**
- `DialogConfirm.xml` - Confirmation dialog
- `DialogSelect.xml` - Selection dialog
- `DialogSettings.xml` - Settings dialog
- `DialogVideoInfo.xml` - Video information

### OSD (On-Screen Display)

OSD elements appear during playback.

```xml
<control type="group" id="100">
  <control type="label" id="101">
    <label>$INFO[Player.Info.Title]</label>
  </control>
</control>
```

**OSD types:**
- Playlist OSD
- Cast OSD
- Music tracks OSD
- Video info OSD
- Audio/subtitle streams OSD

---

## 4. Window and Control Types

### Window Types

| Type | Description | Common Uses |
|------|-------------|-------------|
| `dialog` | Modal dialog window | Confirmations, selections |
| `window` | Standard window | Home, settings, info |
| `window1080` | 1080p window | High-resolution UI |
| `window1080hdbg` | 1080p with HD background | Full HD with HD backdrop |
| `window1080hdbg16x9` | 16:9 aspect HD | Widescreen HD |
| `window1080hd` | 1080p HD | Full HD |
| `window1080hd16x9` | 16:9 HD | Widescreen HD |

### Control Types

#### Groups

```xml
<control type="group" id="501">
  <visible>!Skin.HasSetting(HomeSwitcher.DisableSearch)</visible>
  <control type="button" id="502" />
  <control type="label" id="503" />
</control>
```

**Group attributes:**
- `id`: Unique identifier
- `visible`: Visibility condition
- `animation`: Fade, slide, zoom transitions
- `posx`, `posy`, `width`, `height`: Position and size
- `zorder`: Z-axis layering

#### Lists

```xml
<control type="list" id="501">
  <posx>60</posx>
  <posy>160</posy>
  <width>640</width>
  <height>384</height>
  <visible>IsVisible(HomeSwitcher.Home.InProgress)</visible>
  <content>
    <playlist>plugin://plugin.video.velocity2/?action=list&list_id=home_in_progress_series&page=1</playlist>
  </content>
  <onselect>
    <action>
      <action type="playlist" pos="10" />
    </action>
  </onselect>
  <onfocus>
    <action>
      <action type="move" direction="down" />
    </action>
  </onfocus>
</control>
```

**List attributes:**
- `content`: Playlist, directory, list, or image source
- `onselect`: Action when item selected
- `onfocus`: Action when focused
- `onup`: Action when moved up
- `ondown`: Action when moved down
- `highlight`: Highlighted item appearance
- `selecteditemhighlight`: Selected item appearance

#### Buttons

```xml
<control type="button" id="501">
  <posx>60</posx>
  <posy>160</posy>
  <width>140</width>
  <height>40</height>
  <label>Search</label>
  <onclick>ActivateWindow(1105)</onclick>
  <onfocus>
    <action>
      <action type="sound" file="special://skin/sounds/2-0.wav" />
    </action>
  </onfocus>
</control>
```

**Button attributes:**
- `label`: Text displayed
- `onclick`: Action on click
- `onfocus`: Action on focus
- `onunfocus`: Action on unfocus
- `onhover`: Action on hover
- `onunhover`: Action on unhover

#### Labels

```xml
<control type="label" id="501">
  <posx>60</posx>
  <posy>160</posy>
  <width>320</width>
  <height>40</height>
  <label>$INFO[Player.Info.Title]</label>
  <font>Font16</font>
  <textcolor>0xFFFFFF</textcolor>
</control>
```

**Label attributes:**
- `label`: Static text or infolabel expression
- `font`: Font definition
- `textcolor`: Color (hex or RGB)
- `align`: left, center, right
- `halign`: left, center, right
- `wrap`: Wrap text

#### Images

```xml
<control type="image" id="501">
  <posx>60</posx>
  <posy>160</posy>
  <width>128</width>
  <height>192</height>
  <texture>$INFO[ListItem.Icon]</texture>
  <aspectratio>stretch</aspectratio>
</control>
```

**Image attributes:**
- `texture`: Image source
- `aspectratio`: stretch, keep, zoom, zoom fill, scale, scale fill
- `zpos`: Z-axis position
- `fadetime`: Fade animation time

#### Textures (Special Controls)

```xml
<control type="texture" id="501">
  <posx>60</posx>
  <posy>160</posy>
  <width>640</width>
  <height>384</height>
  <texture>background.png</texture>
  <textureborder top="border_top.png" bottom="border_bottom.png" />
</control>
```

**Texture attributes:**
- `textureborder`: Borders on all sides
- `texturecorners`: Corners on all sides
- `texturecollide`: Collides with other controls
- `textureeffect`: Blur, glow, etc.

---

## 5. Skin Variables and Includes

### Skin Variables

Skin variables are dynamic values that can change at runtime. They are essential for the script.skinvariables addon.

#### Variable Types

```xml
<!-- String variable -->
<variable name="HomeSwitcher.Home.Spotlight.List" value="$INFO[Skin.String(HomeSwitcher.Home.Spotlight.List)]" />

<!-- Boolean variable -->
<variable name="HomeSwitcher.DisableSearch" value="false" />

<!-- Integer variable -->
<variable name="HomeSwitcher.LoopBack" value="1" />
```

#### Variable Evaluation

```xml
<visible>
  <or>
    <condition expression="!Skin.HasSetting(HomeSwitcher.DisableSearch)" />
    <condition expression="IsVisible(HomeSwitcher.Home.InProgress)" />
  </or>
</visible>
```

**Common expressions:**
- `Skin.HasSetting(setting_name)` - Check if setting is enabled
- `Skin.String(variable_name)` - Get string variable value
- `Skin.Boolean(variable_name)` - Get boolean variable value
- `Skin.Integer(variable_name)` - Get integer variable value
- `$EXP[Expression]` - Evaluate expression
- `$INFO[variable]` - Get infolabel value

### Includes Resolution Order

1. `Includes.xml` - Core includes loaded first
2. Window-specific includes (e.g., `Includes_Home.xml`)
3. Widget definition includes (e.g., `Includes_Hubs.xml`)
4. Control definition includes

**Override files:**
```xml
<!-- Loaded before generator includes -->
<include file="script-skinvariables-generator-overrides.xml" />
```

---

## 6. The script.skinvariables Addon

### Overview

`script.skinvariables` is a powerful addon that generates skin variables dynamically. It reads shortcut files and produces variables that control window visibility, content, and behavior.

### Architecture

```
shortcuts/
├── *.xml                    # Shortcut definitions
├── generator/
│   ├── data/base/           # Base widget definitions
│   ├── data/setup/          # Setup-specific overrides
│   └── data/parts/          # Reusable parts
└── skinvariables-generator.json  # Generator configuration
```

### Shortcut Files

Shortcut files define variables in a structured format.

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

### Generator Pipeline

The generator pipeline processes shortcuts and produces final XML:

1. **Read shortcuts**: Parse all shortcut files
2. **Apply overrides**: Load override files
3. **Generate variables**: Create skin variables
4. **Output XML**: Write final window XML files

**Generator template example:**

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

---

## 7. HomeSwitcher System

### Overview

The HomeSwitcher system is a property-based configuration mechanism that manages which hub windows are enabled, their display names, and their operational modes.

### Architecture

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

### Variables

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

### Bootstrap

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

### Decision Matrix (D-003)

Each surface has a locked view mode decision:

| Surface | Mode | Notes |
|---------|------|-------|
| Home | Combined | Primary IA with spotlight/list wiring |
| Series (1101) | Combined | ReplaceWindow(1101) from switcher |
| Movies (1102) | Combined | ReplaceWindow(1102) from switcher |
| Next Aired (1106) | N/A | Off by default |
| Live TV (1107) | N/A | Core Kodi PVR outside hub scope |
| Add-ons (1108) | Wall | Routes to addonbrowser |
| Settings (1109) | N/A | Deferred |

---

## 8. Hub Architecture

### Overview

Hubs are the primary navigation surfaces in Kodi skins. They typically feature:
- A spotlight/hero section
- Tabbed or stacked row sections
- Navigation controls

### Home Hub

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

---

## 9. View Modes

### Overview

View modes determine how content is displayed in lists and rows. Kodi supports several view modes that can be controlled via skin variables.

### View Mode Types

| Mode | Description | Typical Use |
|------|-------------|-------------|
| **Standard** | Default list view | General browsing |
| **Combined** | Multiple view modes stacked | Home, hub surfaces |
| **Wall** | Large poster grid | Add-ons, images |
| **Poster** | Vertical poster cards | Movies, shows |
| **Landscape** | Horizontal landscape cards | Episodes, photos |
| **List** | Compact list view | Settings, files |

### View Mode Control

```xml
<variable name="ViewMode(HomeSwitcher.Home)" value="Combined" />
<variable name="ViewMode(HomeSwitcher.1101)" value="Combined" />
<variable name="ViewMode(HomeSwitcher.1102)" value="Combined" />
```

### View Mode Matrix (D-003)

The view mode matrix locks one mode per surface to prevent runtime fallback drift:

```
┌─────────────────────────────────────────────────────────┐
│ Surface                    │ Mode Decision      │ Notes              │
├─────────────────────────────────────────────────────────┤
│ Home (HS-home)             │ Combined           │ Primary IA         │
│ Series (HS-series)         │ Combined           │ ReplaceWindow(1101)│
│ Movies (HS-movies)         │ Combined           │ ReplaceWindow(1102)│
│ Next Aired (HS-nextaired)  │ N/A                │ Off by default     │
│ Live TV (HS-pvr)           │ N/A                │ Core Kodi PVR      │
│ Add-ons (HS-addons)        │ Wall               │ addonbrowser       │
│ Settings (HS-settingshub)  │ N/A                │ Deferred           │
└─────────────────────────────────────────────────────────┘
```

### View Mode Enforcement

View mode enforcement prevents Kodi from arbitrarily changing the view mode:

```xml
<visible>
  <or>
    <condition expression="IsVisible(HomeSwitcher.Home.Spotlight)" />
    <condition expression="IsVisible(HomeSwitcher.Home.InProgress.Series)" />
  </or>
</visible>
```

---

## 10. Skin Development Best Practices

### Golden Rules

1. **Never write Kodi `<control>` XML from scratch** - You will hallucinate syntax. Always reference existing files.

2. **Use includes and variables over duplicating long `plugin://` strings** - Centralize and reuse.

3. **URL-encode query values where needed** - Special characters in addon URLs must be encoded.

4. **Preserve generator pipeline** - `script.skinvariables` drives the skin; static XML edits are overwritten.

5. **Edit & Replace strategy** - Preserve layout tags, only replace `<content>` and `<onclick>` paths.

6. **Use native Kodi properties first** - `ListItem.*`, `Container.*`, `VideoPlayer.*` over helper properties.

7. **Document exceptions** - Any remaining helper binding must be explicitly documented.

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

---

## 11. Kodi Skin Development Environment

### Prerequisites

1. **Kodi installation** (23.x or 24.x)
2. **Addon manager** (Kodi repository)
3. **Development tools:**
   - ripgrep (`rg`) - File search
   - pytest - Addon contract testing
   - git - Version control

### Skin Installation

```bash
# Copy skin folder to Kodi userdata
cp -r skin.arctic.fuse.3 ~/.kodi/addons/

# Enable in Kodi
# Settings → Interface → Skin → Select "Arctic Fuse 3"
```

### Generator Pipeline Testing

```bash
# 1. Open Kodi
# 2. Navigate to skin settings
# 3. Trigger generator: Skin.ResetSettings → ActivateWindow(Startup)
# 4. Verify hub rows load correctly
# 5. Check kodi.log for missing include warnings
```

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

- **First-run**: ~5-10 seconds (bootstrap + generator)
- **Reload**: ~2-5 seconds (skin reset)
- **Generator overhead**: Minimal (uses Kodi's native variable system)

---

## 12. Testing and Debugging

### Debug Windows

Kodi provides debug windows for skin development:

```xml
<control type="button" id="1001">
  <onclick>ActivateWindow(1199)</onclick>
  <label>Debug Overlay</label>
</control>
```

- `1199` - Debug Overlay
- `1194` - Debug Grid
- `1191` - Test window

### kodi.log

The kodi.log file contains extensive debugging information:

```bash
# View log
tail -f ~/.kodi/log/kodi.log

# Search for warnings
grep -i "warning" ~/.kodi/log/kodi.log

# Search for missing includes
grep -i "include" ~/.kodi/log/kodi.log
```

### Common Issues

**Missing includes:**
```
WARNING: Failed to include 'Includes_Hubs.xml'
```
*Solution:* Check file path, ensure file exists, verify include order.

**Variable not set:**
```
ERROR: Skin.String(HomeSwitcher.Home.Spotlight.List) is not set
```
*Solution:* Verify shortcut file defines the variable, check generator pipeline.

**Control not visible:**
```
ERROR: Control(1002) is not visible
```
*Solution:* Check visibility conditions, verify parent control is visible.

**Z-order issues:**
```
ERROR: Control(1003) is behind Control(1002)
```
*Solution:* Adjust zorder attributes, check parent zorder.

---

## 13. Deployment and Distribution

### Package Structure

```
skin.arctic.fuse.3.zip
├── addon.xml
├── 1080i/
├── colors/
├── fonts/
├── media/
├── language/
├── inventory/
└── extras/
```

### Repository Distribution

Add the skin to a Kodi repository:

```xml
<!-- repository.xml -->
<addon id="repository.skin.arctic.fuse.3" name="Arctic Fuse 3 Repository" version="3.0.0" type="repository">
  <description>Arctic Fuse 3 Kodi skin repository</description>
  <files>
    <dir name="addons">
      <file name="skin.arctic.fuse.3.zip" />
    </dir>
  </files>
</addon>
```

### Versioning

Follow semantic versioning:

```xml
<addon id="skin.arctic.fuse.3" name="Arctic Fuse 3" version="3.0.0" provider-name="jurialmunkey">
```

- **Major**: Breaking changes
- **Minor**: New features, backward compatible
- **Patch**: Bug fixes, backward compatible

### Migration

When migrating from one addon to another (e.g., TMDbHelper to Velocity):

1. **Contract-first**: Define addon contracts before skin changes
2. **Document exceptions**: Track any remaining helper bindings
3. **Native properties first**: Migrate to native Kodi properties
4. **Preserve generator**: Never edit output XML; edit blueprints

---

## Appendix A: Kodi Control Reference

### Group Controls

| Attribute | Description |
|-----------|-------------|
| id | Unique identifier |
| visible | Visibility condition |
| posx, posy | X, Y position in pixels |
| width, height | Width, height in pixels |
| zorder | Z-axis layering |
| animation | Fade, slide, zoom |
| fadetime | Animation duration in milliseconds |

### List Controls

| Attribute | Description |
|-----------|-------------|
| content | Playlist, directory, list, image |
| onselect | Action on item selection |
| onfocus | Action on focus |
| onup, ondown | Action on movement |
| highlight | Highlighted item appearance |
| selecteditemhighlight | Selected item appearance |
| itemheight | Height of each item |

### Button Controls

| Attribute | Description |
|-----------|-------------|
| label | Text displayed |
| onclick | Action on click |
| onfocus | Action on focus |
| onhover | Action on hover |
| texture | Background image |
| textcolor | Text color |

### Label Controls

| Attribute | Description |
|-----------|-------------|
| label | Static text or infolabel |
| font | Font definition |
| textcolor | Text color |
| align | left, center, right |
| halign | left, center, right |
| wrap | Wrap text |

### Image Controls

| Attribute | Description |
|-----------|-------------|
| texture | Image source |
| aspectratio | stretch, keep, zoom, etc. |
| zpos | Z-axis position |
| fadetime | Fade animation time |

---

## Appendix B: Common Infolabels

### Player Info

```xml
$INFO[Player.Info.Title]           # Title
$INFO[Player.Info.Artist]          # Artist
$INFO[Player.Info.Duration]        # Duration
$INFO[Player.Info.Time]            # Current time
$INFO[Player.Info.SeekTime]        # Seek time
$INFO[Player.Info.PositionPercent] # Position percent
$INFO[Player.Info.CurrentTrack]    # Current track
$INFO[Player.Info.CurrentEpisode]  # Current episode
$INFO[Player.Info.CurrentSeason]   # Current season
$INFO[Player.Info.CurrentShow]     # Current show
$INFO[Player.Info.Plot]            # Plot
$INFO[Player.Info.Studio]          # Studio
$INFO[Player.Info.Year]            # Year
```

### List/Container Info

```xml
$INFO[Container.Folder]            # Current folder
$INFO[Container.Directory]         # Current directory
$INFO[Container.Label]             # Current label
$INFO[Container.SortMethod]        # Sort method
$INFO[Container.ViewMode]          # View mode
$INFO[Container.Icon]              # Current item icon
$INFO[Container.Art]               # Current item art
$INFO[Container.ArtThumb]          # Current item thumb
$INFO[Container.ArtFanart]         # Current item fanart
```

### Item Info

```xml
$INFO[ListItem.Title]              # Title
$INFO[ListItem.Art]                # Art
$INFO[ListItem.Icon]               # Icon
$INFO[ListItem.Thumb]              # Thumb
$INFO[ListItem.Fanart]             # Fanart
$INFO[ListItem.Path]               # Path
$INFO[ListItem.IconPath]           # Icon path
$INFO[ListItem.ThumbPath]          # Thumb path
$INFO[ListItem.FanartPath]         # Fanart path
$INFO[ListItem.FileName]           # File name
$INFO[ListItem.FileSize]           # File size
$INFO[ListItem.Duration]           # Duration
$INFO[ListItem.Year]               # Year
$INFO[ListItem.Genre]              # Genre
$INFO[ListItem.Plot]               # Plot
$INFO[ListItem.Rating]             # Rating
$INFO[ListItem.Studio]             # Studio
$INFO[ListItem.Cast]               # Cast
$INFO[ListItem.CriticRating]       # Critic rating
$INFO[ListItem.ContentRating]      # Content rating
$INFO[ListItem.VideoResolution]    # Video resolution
$INFO[ListItem.VideoCodec]         # Video codec
$INFO[ListItem.AudioCodec]         # Audio codec
$INFO[ListItem.AudioChannels]      # Audio channels
$INFO[ListItem.AudioLanguage]      # Audio language
$INFO[ListItem.SubtitleLanguage]   # Subtitle language
```

---

## Appendix C: Common Expressions

### Skin HasSetting

```xml
Skin.HasSetting(HomeSwitcher.DisableSearch)
Skin.HasSetting(TMDbHelper.EnableBlur)
Skin.HasSetting(HomeSwitcher.1101.Toggle)
```

### Skin String/Boolean/Integer

```xml
Skin.String(HomeSwitcher.Home.Spotlight.List)
Skin.Boolean(HomeSwitcher.DisableSearch)
Skin.Integer(HomeSwitcher.LoopBack)
```

### EXP (Expression)

```xml
$EXP[Exp_TMDbHelper_IsBlur]
$EXP[Exp_AllowExpandedContextMenu]
$EXP[Exp_TMDBHelper_IsData]
```

### Info

```xml
$INFO[Skin.String(HomeSwitcher.Home.Spotlight.List)]
$INFO[Player.Info.Title]
$INFO[Container.Folder]
$INFO[ListItem.Title]
```

---

## Appendix D: Kodi 24 (Kodi 20) Changes

Kodi 24 introduced several changes that affect skin development:

### New Features

- **Enhanced skin variables**: More powerful expression evaluation
- **Improved view modes**: Better handling of stacked views
- **New control types**: Additional control options
- **Performance improvements**: Faster rendering and less memory usage

### Breaking Changes

- **Older Kodi versions**: Skins may not work on Kodi 24
- **View mode changes**: Some view modes may behave differently
- **Control IDs**: Some default control IDs may have changed

### Migration Guide

When migrating to Kodi 24:

1. Test on Kodi 24 first
2. Update addon.xml requires section
3. Review view mode decisions
4. Check for deprecated controls
5. Test all navigation paths

---

## References

- [Kodi Wiki - Skinning Manual](https://kodi.wiki/view/Skinning_Manual)
- [Kodi Wiki - Skin Development Introduction](https://kodi.wiki/view/Skin_development_introduction)
- [script.skinvariables GitHub](https://github.com/jurialmunkey/script.skinvariables)
- [Kodi Development Kit](https://xbmc.github.io/docs.kodi.tv/)
- [Kodi Forum - script.skinvariables thread](https://forum.kodi.tv/showthread.php?tid=353811)

---

*This documentation is specific to Kodi skin development and the Arctic Fuse 3 skin fork. For general Kodi development, refer to the official Kodi documentation.*