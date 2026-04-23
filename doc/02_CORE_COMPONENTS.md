# Kodi Skin Core Components

## 1. addon.xml

The main configuration file for any Kodi skin.

### Example

```xml
<addon id="skin.velocity.af3" name="Arctic Fuse 3" version="3.0.0" provider-name="jurialmunkey">
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

### Important Fields

| Field | Description | Example |
|---|---|---|
| `id` | Unique identifier (must be lowercase, no spaces) | `skin.velocity.af3` |
| `name` | Display name | `Arctic Fuse 3` |
| `version` | Semantic versioning | `3.0.0` |
| `provider-name` | Author name | `jurialmunkey` |
| `requires` | Dependencies (Kodi version, other addons) | `xbmc.gui`, `script.skinvariables` |
| `files` | Skin file paths | `1080i/Home.xml` |
| `assets` | Icon and fanart references | `icon.png`, `fanart.jpg` |
| `description` | Skin description | Text description |
| `platform` | Platform compatibility | `all`, `linux`, `windows` |

---

## 2. Windows (XML Files)

Each window is a separate XML file defining the UI layout.

### Standard Windows

| File | Description |
|---|---|
| `Home.xml` | Primary hub window |
| `DialogVideoInfo.xml` | Full details dialog |
| `DialogSettings.xml` | Settings dialog |
| `FileBrowser.xml` | File browser |
| `DialogSelect.xml` | Selection dialog |

### Custom Windows

| File | Description |
|---|---|
| `Custom_1105_Search.xml` | Search window |
| `Custom_1193_VideoOSDInfo.xml` | OSD info bridge |
| `Custom_1109_Settings.xml` | Settings hub |
| `Custom_1115_Window_Shortcuts.xml` | Shortcuts window |
| `Custom_1116_Dialog_Shortcuts.xml` | Shortcuts dialog |

### Dialog Windows

| File | Description |
|---|---|
| `Dialog_DialogConfirm.xml` | Confirmation dialog |
| `Dialog_DialogSelect.xml` | Selection dialog |
| `Dialog_DialogSettings.xml` | Settings dialog |
| `Dialog_DialogVideoInfo.xml` | Video information |
| `Dialog_DialogContextMenu.xml` | Context menu |

### OSD Windows

| File | Description |
|---|---|
| `Custom_1140_OSD_Playlist.xml` | Playlist OSD |
| `Custom_1141_OSD_Cast.xml` | Cast OSD |
| `Custom_1142_OSD_MusicTracks.xml` | Music tracks OSD |
| `Custom_1143_OSD_NextOverlay.xml` | Next overlay OSD |
| `Custom_1145_OSD_InfoPanel.xml` | Info panel OSD |
| `Custom_1146_OSD_AudioStreams.xml` | Audio streams OSD |
| `Custom_1147_OSD_SubtitleStreams.xml` | Subtitle streams OSD |
| `Custom_1148_OSD_VideoStreams.xml` | Video streams OSD |
| `Custom_1151_OSD_MusicInfoOverlay.xml` | Music info overlay OSD |
| `Custom_1152_OSD_VideoInfoOverlay.xml` | Video info overlay OSD |
| `Custom_1153_OSD_VideoInfoOverlayTop.xml` | Video info overlay top OSD |

---

## 3. Includes

Includes allow code reuse and modular design.

### Core Includes

| File | Description |
|---|---|
| `Includes.xml` | Core includes loaded first |
| `Includes_Home.xml` | Home-specific includes |
| `Includes_Hubs.xml` | Hub widget definitions |
| `Includes_Search.xml` | Search-specific includes |
| `Includes_OSD.xml` | OSD includes |

### Window-Specific Includes

| File | Description |
|---|---|
| `Includes_Home.xml` | Home hub includes |
| `Includes_Search.xml` | Search window includes |
| `Includes_LiveTV.xml` | Live TV includes |
| `Includes_NextAired.xml` | Next aired includes |
| `Includes_Weather.xml` | Weather includes |

### Widget Definition Includes

| File | Description |
|---|---|
| `Includes_Hubs.xml` | Hub row definitions |
| `Includes_Views.xml` | View definitions |
| `Includes_Views_Combined.xml` | Combined view definitions |
| `Includes_Views_List.xml` | List view definitions |
| `Includes_Views_PVR.xml` | PVR view definitions |
| `Includes_Views_Row.xml` | Row view definitions |
| `Includes_Views_Wall.xml` | Wall view definitions |

### Control Definition Includes

| File | Description |
|---|---|
| `Includes_Buttons.xml` | Button definitions |
| `Includes_Lists.xml` | List definitions |
| `Includes_Labels.xml` | Label definitions |
| `Includes_Images.xml` | Image definitions |
| `Includes_Overlay.xml` | Overlay definitions |
| `Includes_Widgets.xml` | Widget definitions |

### Include Types

**Core includes:** `Includes.xml` - essential includes loaded first

**Window-specific:** `Includes_Home.xml`, `Includes_Search.xml`

**Widget definitions:** `Includes_Hubs.xml` - hub row definitions

**Control definitions:** `Includes_Buttons.xml`, `Includes_Lists.xml`

### Include Resolution Order

1. `Includes.xml` - Core includes loaded first
2. Window-specific includes (e.g., `Includes_Home.xml`)
3. Widget definition includes (e.g., `Includes_Hubs.xml`)
4. Control definition includes

**Override files:**

```xml
<!-- Loaded before generator includes -->
<include file="script-skinvariables-generator-overrides.xml" />
```

### Include Example

```xml
<!-- In Home.xml -->
<include name="Includes_Home.xml" />
<include name="Includes_Hubs.xml" />
```

---

## 4. Variables

Skin variables are dynamic values that can change at runtime. They are essential for the script.skinvariables addon.

### Variable Types

```xml
<!-- String variable -->
<variable name="HomeSwitcher.Home.Spotlight.List" value="$INFO[Skin.String(HomeSwitcher.Home.Spotlight.List)]" />

<!-- Boolean variable -->
<variable name="HomeSwitcher.DisableSearch" value="false" />

<!-- Integer variable -->
<variable name="HomeSwitcher.LoopBack" value="1" />
```

### Variable Evaluation

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

---

## 5. Dialogs

Dialogs are modal windows that appear on top of the main UI.

### Dialog Example

```xml
<control type="dialog" id="1001">
  <visible>Control.HasFocus(1001)</visible>
  <control type="label" id="1002">
    <label>Continue?</label>
  </control>
</control>
```

### Common Dialogs

| Dialog | Description |
|---|---|
| `DialogConfirm.xml` | Confirmation dialog |
| `DialogSelect.xml` | Selection dialog |
| `DialogSettings.xml` | Settings dialog |
| `DialogVideoInfo.xml` | Video information |

---

## 6. OSD (On-Screen Display)

OSD elements appear during playback.

### OSD Example

```xml
<control type="group" id="100">
  <control type="label" id="101">
    <label>$INFO[Player.Info.Title]</label>
  </control>
</control>
```

### OSD Types

| Type | Description |
|---|---|
| Playlist OSD | Playlist information |
| Cast OSD | Cast information |
| Music tracks OSD | Music track information |
| Video info OSD | Video information |
| Audio/subtitle streams OSD | Audio and subtitle stream information |

---

*See also: [addon.xml](02_CORE_COMPONENTS.md#1-addonxml), [Windows](02_CORE_COMPONENTS.md#2-windows-xml-files), [Includes](02_CORE_COMPONENTS.md#3-includes)*