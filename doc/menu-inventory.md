# Menu Inventory (exhaustive source map)

This inventory captures menu/navigation contracts across static XML and generator-driven `skinvariables-*` includes.

## 1) Menu families and source-of-truth files

| Menu family | Primary source files | Runtime consumers | Notes |
|---|---|---|---|
| Home switcher menu | `1080i/Includes_Home.xml`, `shortcuts/skinvariables-startup.json` | `1080i/Home.xml`, `Includes_Home.xml` | `HomeSwitcher.*` contract defines labels, icons, path/target and enabled toggles |
| Hub widgets/spotlight | `1080i/Includes_Hubs.xml`, `shortcuts/generator/data/base/home_widgets*.xml` | `Includes_Hubs.xml` | Dynamic include names by mode (`wall`, `combined`, `standard`) |
| Home submenu/static items | `shortcuts/generator/data/base/home_submenu.xml`, `home_subitems.xml` | `Includes_Home.xml` | Loaded as `skinvariables-$PARAM[window]submenu-staticitems` |
| Search selector/widgets | `1080i/Includes_Search.xml`, `shortcuts/generator/data/base/search_*.xml`, `shortcuts/skinvariables-shortcut-searchwidgets.json` | `Includes_Search.xml` | Includes: `skinvariables-searchwidgets-*` |
| Settings landing menu | `1080i/Settings.xml`, `1080i/Includes_Settings.xml` | `Settings.xml` | Blend of Kodi windows, addon settings, and custom dialogs |
| Power menu / tray / load | `shortcuts/generator/data/base/power_*.xml`, `shortcuts/skinvariables-shortcut-powermenu.json` | Generated includes + power UI surfaces | Rule transforms in `setup/powermenu_item.xml` |
| Shortcut editor navigation | `1080i/Dialog_DialogShortcuts.xml`, `Custom_1115_Window_Shortcuts.xml` | Dialog windows 1115/1116/1124 | Dynamic node editing through SkinVariables plugin |

## 2) Static XML menu items

### 2.1 Home switcher and window routing (`Includes_Home.xml`)

| Source symbol | Label/path contract | Action | Guard | Dependency |
|---|---|---|---|---|
| `Home_Object` main click | `Skin.String(HomeSwitcher.$PARAM[window].Shortcut.Path)` + optional `.Target` | `ActivateWindow(target,path,return)` or direct builtin | toggle-based visibility | HomeSwitcher + mixed |
| Search slot | search/home entry | `SetFocus(3001)` in search window context | `!Skin.HasSetting(HomeSwitcher.DisableSearch)` | Kodi-native |
| Live TV / Addons slots | window-specific overrides | `ActivateWindow(tvchannels)` / `ActivateWindow(addonbrowser)` | window visibility | Kodi-native |
| Submenu panel list | `skinvariables-$PARAM[window]submenu-staticitems` | list click runs item action | per-window toggle visibility | generated |
| Vertical/horizontal switch | side menu navigation mode | movement actions + focus routing | `Skin.HasSetting(HomeSwitcher.Vertical)` | HomeSwitcher |

### 2.2 Hub widgets and spotlight (`Includes_Hubs.xml`)

| Source symbol | Menu/widget contract | Action/path behavior | Guard | Dependency |
|---|---|---|---|---|
| Spotlight list include | `Skin.String(HomeSwitcher.$PARAM[window].Spotlight.Path)` + target/sort/limit | dynamic content list | spotlight toggle and target existence | HomeSwitcher + provider path |
| Widget include by mode | `skinvariables-$PARAM[window]widgets-wall|combined|standard` | loads generated widget rows | based on `HomeSwitcher.$PARAM[window].Mode` | generated |
| Widget selector include | `skinvariables-$PARAM[window]widgets-*-selector` | selector actions to switch widget rows | mode-dependent | generated |
| Widget info include | `skinvariables-$PARAM[window]widgets-wall-info` / `...combined-info` | info panel rendering for selected row | mode-dependent | generated |
| Spotlight buttons | play/info interactions | `Action(select/play)` + focus shifts | item availability and focus state | Kodi-native + source content |

### 2.3 Search menu and selector (`Includes_Search.xml`)

| Source symbol | Menu contract | Action/path behavior | Guard | Dependency |
|---|---|---|---|---|
| Search combined widgets include | `skinvariables-searchwidgets-combined` | generated search rows with selector | `!Skin.HasSetting(Search.DisableCombined)` | generated |
| Search standard widgets include | `skinvariables-searchwidgets-standard` | alternate generated row layout | `Skin.HasSetting(Search.DisableCombined)` | generated |
| Search info include | `skinvariables-searchwidgets-info` | contextual right-panel info | always in search flow | generated |
| Search selector include | `skinvariables-searchwidgets-selector` | selector items with widget ids | always | generated |
| Discover selector item | hardcoded discover item + `guid=discover` | `RunPlugin(plugin.video.themoviedb.helper/?info=user_discover...)` | discover/combined enabled | TMDbHelper |
| Search keyboard row | A-Z + `_` + backspace item list | updates edit control via builtin actions | focus state | Kodi-native |

### 2.4 Settings landing menu (`Settings.xml`, `Includes_Settings.xml`)

| Menu area | Representative items | Action style | Dependency |
|---|---|---|---|
| Main landing categories | Interface, Skin, System Info | `ActivateWindow(...)` | Kodi-native |
| Addon settings menu | TMDbHelper, ArtistSlideshow, UpNext, etc. | `Addon.OpenSettings(...)` | addon-specific |
| Skin custom actions | configure widgets/search widgets/custom dialogs | `SetProperty(...)` + `ActivateWindow(1115/1116/1118)` | SkinVariables + DialogCustom |

## 3) Generated menu items from shortcut JSON + generator pipeline

### 3.1 Shortcut JSON seed sources

| File | Role | Key contracts |
|---|---|---|
| `shortcuts/skinvariables-shortcut-config.json` | canonical menu seed catalog | `path`, `label`, `target`, `rule`, `grouping://...`, `DefaultSearch-*`, `Stacked_*`, builtin actions |
| `shortcuts/skinvariables-shortcut-homewidgets.json` | home widget seed list | widget labels/styles/paths |
| `shortcuts/skinvariables-shortcut-homesubmenu.json` | submenu seed list | submenu actions |
| `shortcuts/skinvariables-shortcut-searchwidgets.json` | search widget seed list | search widget aliases and targets |
| `shortcuts/skinvariables-shortcut-powermenu.json` | power menu seed list | system/power builtins |

### 3.2 Generator transformation chain

| Stage | Files | Output contract |
|---|---|---|
| Generator root | `shortcuts/skinvariables-generator.json` | output `script-skinvariables-generator-includes-{skinuser}.xml`; executes `genxml` list |
| Base definitions | `shortcuts/generator/data/base/*.xml` | defines menu families (home widgets/submenu/search/power) and include names |
| Setup transforms | `shortcuts/generator/data/setup/*.xml` | computes final `item_path`, `item_target`, `parts_onclick`, widget include style, visibility conditions |
| Item templates | `shortcuts/generator/data/parts/*.xmltemplate` | emits item XML structure (`menu_item`, `search_item`, `widgets_selector`, etc.) |

## 4) Runtime include names and consuming files

| Runtime include name pattern | Produced by | Consumed in |
|---|---|---|
| `skinvariables-$PARAM[window]widgets-wall` | base home widgets + wall setup/template | `1080i/Includes_Hubs.xml` |
| `skinvariables-$PARAM[window]widgets-combined` | base home widgets + combined template | `1080i/Includes_Hubs.xml` |
| `skinvariables-$PARAM[window]widgets-standard` | base home widgets + standard template | `1080i/Includes_Hubs.xml` |
| `skinvariables-$PARAM[window]widgets-wall-selector` | wall selector template | `1080i/Includes_Hubs.xml` |
| `skinvariables-$PARAM[window]widgets-combined-selector` | combined selector template | `1080i/Includes_Hubs.xml` |
| `skinvariables-$PARAM[window]widgets-wall-info` | wall info template | `1080i/Includes_Hubs.xml` |
| `skinvariables-$PARAM[window]widgets-combined-info` | combined info template | `1080i/Includes_Hubs.xml` |
| `skinvariables-$PARAM[window]submenu-staticitems` | base home_submenu/home_subitems | `1080i/Includes_Home.xml` |
| `skinvariables-searchwidgets-combined` | base search_widgets | `1080i/Includes_Search.xml` |
| `skinvariables-searchwidgets-standard` | base search_widgets_standard | `1080i/Includes_Search.xml` |
| `skinvariables-searchwidgets-selector` | base search_selector | `1080i/Includes_Search.xml` |
| `skinvariables-searchwidgets-info` | base search_info | `1080i/Includes_Search.xml` |
| `script-skinvariables-generator-includes-.xml` | generator output (default profile) | `1080i/Includes.xml` |

## 5) Dependency guards and visibility rules

| Rule/guard type | Example contract | Location |
|---|---|---|
| Addon availability guard | `System.HasAddon(plugin.video.themoviedb.helper)` | shortcut config grouping entries |
| UI mode guard | `Skin.HasSetting(HomeSwitcher.Vertical)` | home/hub/search routing |
| Search mode guard | `Skin.HasSetting(Search.DisableCombined)` | search include selection |
| Widget mode guard | `String.IsEqual(Skin.String(HomeSwitcher.$PARAM[window].Mode),Wall|Combined|Standard)` | hub include selection |
| Runtime profile guard | `String.IsEmpty(Skin.String(SkinVariables.SkinUser))` | generated include load in `Includes.xml` |
| Power menu guard | `parts_visible` rules (e.g., hide profile-switch action if disabled) | `setup/powermenu_item.xml` |

## 6) Migration-priority tags for menu contracts

| Contract cluster | Tag | Why |
|---|---|---|
| Home switcher click paths (`HomeSwitcher.*.Shortcut.Path/Target`) | Velocity-ready (high) | Central navigation contract; replace provider path while keeping shell behavior |
| Spotlight path (`HomeSwitcher.*.Spotlight.Path/Target`) | Velocity-ready (high) | Needed for pagination-safe spotlight/feed split |
| Search selector discover `RunPlugin(...TMDbHelper...)` | TMDbHelper-bound (high) | Direct helper dependency in user-facing search menu |
| `DefaultSearch-TMDB*` aliases | TMDbHelper-bound (high) | Core search widget items for current UX |
| `Stacked_*` recommendation aliases in generator setup | TMDbHelper-bound (medium/high) | Widget chaining currently helper-specific |
| Non-provider UI navigation (ActivateWindow / builtins / power actions) | Kodi-native (stable) | Typically unaffected by provider migration |
| `script.skinvariables` node/editing actions | SkinVariables-core (stable) | Keep unless architecture changes |

## 7) Coverage checklist

- Home switcher: covered.
- Spotlight and widgets: covered.
- Search widget/selector menus: covered.
- Settings landing menu items: covered.
- Power and submenu generated menus: covered.
- Generator pipeline and runtime include consumption: covered.
