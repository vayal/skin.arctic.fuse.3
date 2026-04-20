# Settings Inventory (exhaustive source map)

This inventory documents all known settings-definition surfaces for this skin, including static XML controls and property/generator-driven settings flows.

## 1) Settings entry points (windows/dialogs)

| Surface | Source file | Window/Dialog ID | Purpose | Dependency |
|---|---|---:|---|---|
| Main settings landing | `1080i/Settings.xml` | n/a | Entry tiles to interface/skin/system panes and addon settings shortcuts | Kodi-native + addons |
| Skin settings root | `1080i/SkinSettings.xml` | n/a | Category menu for skin settings sections (`Customise`, `Appearance`, etc.) | Kodi-native |
| Settings category shell | `1080i/SettingsCategory.xml` | n/a | Shared left/right settings shell and fallback status labels | Kodi-native |
| Shortcut category chooser | `1080i/Custom_1115_Window_Shortcuts.xml` | 1115 | Configure widget/menu windows and toggles | SkinVariables/HomeSwitcher |
| Shortcut dialog host | `1080i/Custom_1116_Dialog_Shortcuts.xml` | 1116 | Hosts shortcut editing UI | SkinVariables |
| Custom settings dialog | `1080i/Custom_1118_Dialog_Settings.xml` | 1118 | Runtime-configured custom settings groups | TMDbHelper + SkinVariables |
| Shortcut editor runtime | `1080i/Dialog_DialogShortcuts.xml` | include-driven | Dynamic node editing actions (`do_move`, `do_edit`, etc.) | SkinVariables |
| Custom settings group router | `1080i/Dialog_DialogCustom.xml` | include-driven | Routes `CustomDialogSettingsItems` to specific settings groups | Mixed |
| Icon selector dialog | `1080i/Custom_1117_Dialog_IconSelector.xml` | 1117 | Per-shortcut icon selection | SkinVariables |
| Rating type dialog | `1080i/Custom_1119_Dialog_RatingType.xml` | 1119 | Rating type selection for details | TMDbHelper-bound |
| Shortcut settings dialog | `1080i/Custom_1124_Dialog_Shortcut_Settings.xml` | 1124 | Window-scoped shortcut options (`Dialog.1124.*`) | SkinVariables |

## 2) Static settings controls by file

### 2.1 `Settings.xml` (top-level settings and utilities)

| Source symbol | Label / intent | Path or action | Guard/visible | Dependency | Provenance |
|---|---|---|---|---|---|
| `item id=1` | Interface | `ActivateWindow(InterfaceSettings)` | always | Kodi-native | static |
| `item id=3` | Skin settings | `ActivateWindow(skinsettings)` | always | Kodi-native | static |
| `item id=2` | System info | `ActivateWindow(systeminfo)` | always | Kodi-native | static |
| Settings entry: TMDbHelper | Open addon settings | `Addon.OpenSettings(plugin.video.themoviedb.helper)` | `System.AddonIsEnabled(plugin.video.themoviedb.helper)` | TMDbHelper | static |
| Settings entry: ArtistSlideshow | Open addon settings | `Addon.OpenSettings(script.artistslideshow)` | addon enabled | script addon | static |
| Settings entry: Up Next | Open addon settings | `Addon.OpenSettings(service.upnext)` | addon enabled | service addon | static |
| Configure shortcuts | Shortcut editor window | `ActivateWindow(1115)` | always | SkinVariables | static |
| Configure search widgets | Set edit props + open | `SetProperty(Shortcuts.EditMenu,menu=searchwidgets,Home)` + `ActivateWindow(1116)` | always | SkinVariables | static |
| Configure Video OSD items | Set custom dialog props + open | `SetProperty(CustomDialogSettingsItems,DialogCustom_VideoOSD_Items,Home)` + `ActivateWindow(1118)` | always | Mixed | static |
| Configure VideoInfo items | Set custom dialog props + open | `SetProperty(CustomDialogSettingsItems,DialogCustom_VideoInfo_Items,Home)` + `ActivateWindow(1118)` | always | Mixed | static |
| Build view templates | Build views | `RunScript(script.skinvariables,action=buildviews,configure)` | always | SkinVariables | static |

### 2.2 `SkinSettings.xml` + `Includes_SkinSettings.xml` (core skin settings)

The root category structure is in `SkinSettings.xml`, while most actual controls are emitted from `Includes_SkinSettings.xml`.

| Settings section include | Key controls (description) | Action pattern | Dependency | Provenance |
|---|---|---|---|---|
| `SkinSettings_Items_Menus` | Customise Widgets, Startup focus, Side menu position, icon mode, header mode, spotlight slide/use-menu-button | `ActivateWindow(1115)`, `Skin.ToggleSetting(...)`, conditional `Skin.SetBool/Reset` | HomeSwitcher + Kodi-native | static include |
| `SkinSettings_Items_Appearance` | Presets, color selector, window/dialog backgrounds, startup art, background blur style, ratings color | `SetProperty(CustomDialogSettingsItems,DialogCustom_Settings_Items_*,Home)` + `ActivateWindow(1118)`; `Skin.ToggleSetting(Ratings.EnableColor)` | DialogCustom + TMDbHelper blur hooks | static include |
| `SkinSettings_Items_Viewtypes` | Configure views, text mode, indicators, VideoOSD button set, info/button sets | `RunScript(script.skinvariables,action=buildviews,configure)` and `CustomDialog_*` routes | SkinVariables + DialogCustom | static include |
| `SkinSettings_Items_Interface` | Header weather, context tray/artwork, footer behavior (some controls commented) | `Skin.ToggleSetting(...)` | Mixed (includes TMDbHelper guard on artwork) | static include |
| `SkinSettings_Items_Behaviour` | Widget autoscroll/more-item/placeholder, navigation back/scroll, textbox/label autoscroll, OSD timeout/seek behavior, background video | `CustomDialog_Autoscroll_Items`, `Skin.ToggleSetting`, `Skin.SetString`, `Skin.SetNumeric` | Kodi-native + SkinVariables | static include |
| `SkinSettings_Items_Details` | TMDb service/rating dialogs, plotline tags, star/audio/HDR tags | `CustomDialog_Ratings_*`, `Skin.ToggleSetting(...)` | TMDbHelper-heavy | static include |
| `SkinSettings_Items_Other` | Startup init behavior, hub preloading, widget profiles, holiday theme modes, nuke settings, TMDbHelper PVR behavior | `Skin.ToggleSetting`, `Skin.ResetSettings`, `ActivateWindow(Startup)` | Mixed (TMDbHelper references present) | static include |
| `SkinSettings_Items_Dependecies` | Dependency/maintenance/debug entries | toggle/debug actions | Mixed | static include |

## 3) Property-driven custom settings groups

The settings dialog router is in `Dialog_DialogCustom.xml`. It maps `Window(Home).Property(CustomDialogSettingsItems)` to settings groups.

| Property key value | Routed include | Typical caller |
|---|---|---|
| `DialogCustom_Settings_Items_ColourPresets` | color preset options | Appearance settings |
| `DialogCustom_Settings_Items_ColourHighlights` | color highlight picker | Appearance settings |
| `DialogCustom_Settings_Items_BackgroundImage` | window background source | Appearance settings |
| `DialogCustom_Settings_Items_BackgroundDialogImage` | dialog background style | Appearance settings |
| `DialogCustom_Settings_Items_BackgroundStyle` | blur/crop style | Appearance settings |
| `DialogCustom_Settings_Items_Startup` | startup image/video source | Appearance settings |
| `DialogCustom_Settings_Items_Indicators` | indicator toggles | Viewtypes/settings |
| `DialogCustom_Autoscroll_Items` | autoscroll options | Behaviour settings |
| `DialogCustom_VideoOSD_Items` | OSD control options | Viewtypes/settings |
| `DialogCustom_VideoInfo_Items` | info dialog buttons/items | Viewtypes/settings |
| `DialogCustom_Buttons_Items` | extra button set | Viewtypes/settings |
| `DialogCustom_Ratings_Movies_Items` | movie ratings selection | Details settings |
| `DialogCustom_Ratings_TVShows_Items` | TV ratings selection | Details settings |

Additional property-driven settings contract:
- `Dialog.1124.Window` controls window-scoped shortcut setting contexts in `Dialog_DialogShortcuts.xml`.

## 4) Shortcut-editor-related settings controls

| Source file | Control family | Action style | Dependency |
|---|---|---|---|
| `Custom_1115_Window_Shortcuts.xml` | Toggle and window selection for shortcut domains | `Skin.SetString(...Toggle)` / `Skin.Reset(...)` | HomeSwitcher/SkinVariables |
| `Dialog_DialogShortcuts.xml` | Per-item editing (move/new/delete/edit/icon/sort/limit/autoscroll/style) | `RunPlugin(...func=do_*)`, property edits, submenu mode switching | SkinVariables |
| `Custom_1117_Dialog_IconSelector.xml` | Icon pick and save | `RunPlugin` with icon function hooks | SkinVariables |
| `Custom_1116_Dialog_Shortcuts.xml` | Host navigation and focus | dialog host only | SkinVariables |

## 5) Generated/indirect settings contracts and provenance

Settings flows depend on generated includes and shortcut data, not only static XML:

1. `shortcuts/skinvariables-generator.json` defines generator output:
   - output file: `script-skinvariables-generator-includes-{skinuser}.xml`
   - sources: `generator/data/base/*.xml`
2. Generator emits include content consumed by UI windows.
3. `1080i/Includes.xml` loads generated output:
   - `script-skinvariables-generator-includes-.xml` for default user context.
4. Shortcut and settings editing actions in `Dialog_DialogShortcuts.xml` write/read dynamic nodes via:
   - `plugin://script.skinvariables/?info=get_shortcuts_node...`

Provenance chain for many effective settings:

`Settings/SkinSettings -> Includes_SkinSettings -> SetProperty(CustomDialogSettingsItems,...) -> Custom_1118_Dialog_Settings -> Dialog_DialogCustom include switch -> specific DialogCustom_* item group`

## 6) Gaps / ambiguities requiring runtime validation

- Some settings are hidden by `Skin.SettingsLevel` and conditional guards (expert-only or context-specific).
- TMDbHelper-related controls use `Exp_TMDbHelper_*` conditions and may not appear without helper/service state.
- Generated includes depend on SkinVariables runtime generation and per-user skin profile context.
- Not all settings semantics can be inferred statically (for example, nested `RunScript` callbacks).

## 7) Coverage checklist

- Settings windows and categories: covered.
- Include-based settings sections: covered.
- Property-driven custom dialog settings groups: covered.
- Shortcut editor settings path: covered.
- Generator-backed settings provenance: covered.
