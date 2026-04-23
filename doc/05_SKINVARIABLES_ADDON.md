# script.skinvariables Addon Deep Dive

## Overview

script.skinvariables is a powerful Kodi addon that generates XML UI code from JSON configuration files. It's the core of the Arctic Fuse 3 Velocity fork's generator pipeline.

---

## 1. Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    script.skinvariables                      │
├─────────────────────────────────────────────────────────────┤
│  Reads:                                                      │
│    • shortcuts/*.xml         (shortcuts)                     │
│    • shortcuts/generator/*.xml (generator data)              │
│    • shortcuts/setup/*.xml  (setup data)                     │
│    • shortcuts/parts/*.xml  (parts data)                     │
├─────────────────────────────────────────────────────────────┤
│  Processes:                                                  │
│    • JSON configuration files                                │
│    • XML templates                                           │
│    • Velocity contract data                                  │
├─────────────────────────────────────────────────────────────┤
│  Produces:                                                   │
│    • 1080i/*.xml (final UI)                                  │
│    • HomeSwitcher system                                     │
│    • Hub widgets                                             │
│    • Search widgets                                          │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. File Structure

### Root Directory

```
shortcuts/
├── skinvariables-generator.json          # Generator configuration
├── skinvariables-shortcut-config.json    # Shortcut editor presets
├── skinvariables-shortcut-homewidgets.json # Home widget shortcuts
├── skinvariables-shortcut-searchwidgets.json # Search widget shortcuts
├── generator/                            # Generator data
│   ├── data/
│   │   ├── base/
│   │   │   ├── home_widgets.xml
│   │   │   ├── home_widgets_combined.xml
│   │   │   ├── home_widgets_standard.xml
│   │   │   ├── search_widgets.xml
│   │   │   ├── search_widgets_standard.xml
│   │   │   ├── power_main.xml
│   │   │   └── search_info.xml
│   │   ├── setup/
│   │   │   ├── widgets_row.xml
│   │   │   ├── widgets_spotlight.xml
│   │   │   ├── widgets_standard.xml
│   │   │   ├── onclick_path.xml
│   │   │   ├── search_path.xml
│   │   │   ├── search_row.xml
│   │   │   ├── widgets_include_row.xml
│   │   │   └── widgets_include_wall.xml
│   │   └── parts/
│   │       ├── widgets_row.xmltemplate
│   │       ├── widgets_spotlight.xmltemplate
│   │       ├── widgets_standard.xmltemplate
│   │       └── widgets_selector.xmltemplate
│   └── templates/
│       └── ...
└── setup/
    └── ...
```

### Generator Data

| File | Description |
|---|---|
| `home_widgets.xml` | Standard home widgets |
| `home_widgets_combined.xml` | Combined view widgets |
| `home_widgets_standard.xml` | Standard view widgets |
| `search_widgets.xml` | Search widgets |
| `search_widgets_standard.xml` | Standard search widgets |
| `power_main.xml` | Power menu widgets |
| `search_info.xml` | Search info widgets |

### Setup Data

| File | Description |
|---|---|
| `widgets_row.xml` | Row widget setup |
| `widgets_spotlight.xml` | Spotlight widget setup |
| `widgets_standard.xml` | Standard widget setup |
| `onclick_path.xml` | On-click path setup |
| `search_path.xml` | Search path setup |
| `search_row.xml` | Search row setup |
| `widgets_include_row.xml` | Row include setup |
| `widgets_include_wall.xml` | Wall include setup |

### Parts Data

| File | Description |
|---|---|
| `widgets_row.xmltemplate` | Row widget template |
| `widgets_spotlight.xmltemplate` | Spotlight widget template |
| `widgets_standard.xmltemplate` | Standard widget template |
| `widgets_selector.xmltemplate` | Selector widget template |

---

## 3. Generator Configuration

### skinvariables-generator.json

```json
{
  "name": "Arctic Fuse 3 Velocity",
  "version": "3.0.0",
  "shortcuts": [
    {
      "name": "Home Widgets",
      "file": "shortcuts/generator/data/base/home_widgets.xml",
      "type": "base"
    },
    {
      "name": "Search Widgets",
      "file": "shortcuts/generator/data/base/search_widgets.xml",
      "type": "base"
    }
  ],
  "setup": [
    {
      "name": "Row Setup",
      "file": "shortcuts/generator/data/setup/widgets_row.xml",
      "type": "setup"
    },
    {
      "name": "Spotlight Setup",
      "file": "shortcuts/generator/data/setup/widgets_spotlight.xml",
      "type": "setup"
    }
  ],
  "parts": [
    {
      "name": "Row Template",
      "file": "shortcuts/generator/data/parts/widgets_row.xmltemplate",
      "type": "parts"
    },
    {
      "name": "Spotlight Template",
      "file": "shortcuts/generator/data/parts/widgets_spotlight.xmltemplate",
      "type": "parts"
    }
  ]
}
```

### Configuration Types

| Type | Description | Files |
|---|---|
| `base` | Base widget definitions | `home_widgets.xml`, `search_widgets.xml` |
| `setup` | Setup configurations | `widgets_row.xml`, `widgets_spotlight.xml` |
| `parts` | Template parts | `widgets_row.xmltemplate`, `widgets_spotlight.xmltemplate` |

---

## 4. Generator Pipeline

### Pipeline Flow

```
┌─────────────┐
│ JSON Config │
└──────┬──────┘
       │
       ▼
┌─────────────────────┐
│  Read Configuration │
└──────┬──────────────┘
       │
       ▼
┌─────────────────────┐
│  Load Base Widgets  │
│  (home_widgets.xml) │
└──────┬──────────────┘
       │
       ▼
┌─────────────────────┐
│  Load Setup Data    │
│  (widgets_row.xml)  │
└──────┬──────────────┘
       │
       ▼
┌─────────────────────┐
│  Load Parts Data    │
│  (widgets_row.xmlt) │
└──────┬──────────────┘
       │
       ▼
┌─────────────────────┐
│  Process Velocity   │
│  Contract Data      │
└──────┬──────────────┘
       │
       ▼
┌─────────────────────┐
│  Generate XML       │
│  (1080i/*.xml)      │
└─────────────────────┘
```

### Generation Steps

1. **Read Configuration** - Load `skinvariables-generator.json`
2. **Load Base Widgets** - Read `home_widgets.xml`, `search_widgets.xml`
3. **Load Setup Data** - Read `widgets_row.xml`, `widgets_spotlight.xml`
4. **Load Parts Data** - Read `widgets_row.xmltemplate`, `widgets_spotlight.xmltemplate`
5. **Process Velocity Contracts** - Fetch data from Velocity addon
6. **Generate XML** - Produce final `1080i/*.xml` files

---

## 5. Velocity Contract Integration

### Contract Families

| Family | Description | Example |
|---|---|---|
| **Home contracts** | Home hub data | `home_spotlight_mixed` |
| **Series hub contracts** | Series hub data | `series_spotlight_trending` |
| **Movies hub contracts** | Movies hub data | `movies_spotlight_trending` |
| **Provider mini-hub contracts** | Provider data | `provider_{id}_spotlight` |
| **Search contracts** | Search results | `search_movies`, `search_tvshows` |

### Contract Data Flow

```
┌─────────────────────┐
│  Velocity Addon     │
│  (plugin.video.)    │
└──────┬──────────────┘
       │
       │  D-015 Contract Family
       │  items/page/has_more/next
       │  Progress: last_watched_at,
       │  percent_watched, etc.
       ▼
┌─────────────────────┐
│  script.skinvariables│
│  Generator Pipeline │
└──────┬──────────────┘
       │
       ▼
┌─────────────────────┐
│  Generate Widget    │
│  XML with contract  │
│  data               │
└─────────────────────┘
```

### Contract Example

```xml
<!-- In generated Home.xml -->
<control type="list" id="1001">
  <label>Home</label>
  <item>
    <label>$INFO[ListItem.Title]</label>
    <icon>$INFO[ListItem.Icon]</icon>
  </item>
</control>
```

---

## 6. HomeSwitcher System

### HomeSwitcher Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    HomeSwitcher                              │
├─────────────────────────────────────────────────────────────┤
│  Hub Types:                                                  │
│    • Spotlight                                              │
│    • In Progress (Series/Movies)                             │
│    • Continue Watching                                       │
│    • Recently Added                                          │
├─────────────────────────────────────────────────────────────┤
│  Widget Types:                                               │
│    • Spotlight                                              │
│    • Standard                                               │
│    • Combined                                               │
├─────────────────────────────────────────────────────────────┤
│  View Modes:                                                 │
│    • Row                                                     │
│    • Wall                                                    │
│    • Spotlight                                               │
└─────────────────────────────────────────────────────────────┘
```

### HomeSwitcher Variables

| Variable | Description |
|---|---|
| `HomeSwitcher.Home.Spotlight.List` | Spotlight widget list |
| `HomeSwitcher.Home.InProgress` | In progress hub visibility |
| `HomeSwitcher.DisableSearch` | Disable search setting |
| `HomeSwitcher.LoopBack` | Loop back counter |
| `HomeSwitcher.1101.Toggle` | Hub 1101 toggle |
| `HomeSwitcher.1102.Toggle` | Hub 1102 toggle |
| `HomeSwitcher.1103.Toggle` | Hub 1103 toggle |
| `HomeSwitcher.1104.Toggle` | Hub 1104 toggle |
| `HomeSwitcher.1106.Toggle` | Hub 1106 toggle |
| `HomeSwitcher.1107.Toggle` | Hub 1107 toggle |
| `HomeSwitcher.1108.Toggle` | Hub 1108 toggle |

### Bootstrap Reset

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

## 7. Shortcut Editor Presets

### skinvariables-shortcut-config.json

```json
{
  "presets": [
    {
      "name": "Home Widgets",
      "widgets": [
        {
          "name": "Spotlight",
          "type": "spotlight",
          "view": "row"
        },
        {
          "name": "In Progress Series",
          "type": "standard",
          "view": "wall"
        },
        {
          "name": "In Progress Movies",
          "type": "standard",
          "view": "wall"
        }
      ]
    },
    {
      "name": "Search Widgets",
      "widgets": [
        {
          "name": "Movies",
          "type": "standard",
          "view": "row"
        },
        {
          "name": "TV Shows",
          "type": "standard",
          "view": "row"
        }
      ]
    }
  ]
}
```

### Preset Types

| Preset | Description |
|---|---|
| Home Widgets | Home hub widget configuration |
| Search Widgets | Search widget configuration |

---

## 8. Widget Shortcuts

### skinvariables-shortcut-homewidgets.json

```json
{
  "homewidgets": [
    {
      "name": "Spotlight",
      "type": "spotlight",
      "view": "row",
      "contract": "home_spotlight_mixed"
    },
    {
      "name": "In Progress Series",
      "type": "standard",
      "view": "wall",
      "contract": "home_in_progress_series"
    },
    {
      "name": "In Progress Movies",
      "type": "standard",
      "view": "wall",
      "contract": "home_in_progress_movies"
    }
  ]
}
```

### Widget Types

| Type | Description |
|---|---|
| Spotlight | Spotlight widget (hero) |
| Standard | Standard widget (content) |
| Combined | Combined view widget |

### View Modes

| View | Description |
|---|---|
| Row | Horizontal scrolling |
| Wall | Grid layout |
| Spotlight | Hero/featured layout |

---

## 9. Best Practices

### Generator Files

1. **Use descriptive names** - Follow the `[category].[subcategory].[item].[property]` convention
2. **Organize by function** - Group related widgets together
3. **Document contracts** - Keep track of Velocity contract mappings
4. **Test in Kodi** - Always test generated XML in Kodi

### Configuration

1. **Keep it modular** - Design for easy extension and modification
2. **Use override files** - Don't modify base configuration directly
3. **Version control** - Track changes to generator files
4. **Document patterns** - Record common patterns for future reference

### Velocity Integration

1. **Follow D-015 contracts** - Use the contract family structure
2. **Handle pagination** - Implement `has_more` and `next_page` properly
3. **Track progress** - Implement `last_watched_at` and `percent_watched`
4. **Test contract data** - Verify contract data in Kodi

---

## 10. Common Patterns

### Widget Definition

```xml
<!-- In generator/data/base/home_widgets.xml -->
<widget name="Spotlight" type="spotlight" view="row" />
<widget name="In Progress Series" type="standard" view="wall" />
<widget name="In Progress Movies" type="standard" view="wall" />
```

### Setup Configuration

```xml
<!-- In generator/data/setup/widgets_row.xml -->
<setup name="Row" type="row" />
<setup name="Spotlight" type="spotlight" />
<setup name="Standard" type="standard" />
```

### Parts Template

```xml
<!-- In generator/data/parts/widgets_row.xmltemplate -->
<template name="Row" type="row">
  <!-- Template content -->
</template>
```

---

*See also: [Core Architecture](01_CORE_ARCHITECTURE.md), [Variables & Includes](04_VARIABLES_INCLUDES.md), [Hubs](07_HUBS.md)*