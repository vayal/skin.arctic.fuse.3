# Kodi Skin Variables & Includes

## Overview

Skin variables and includes are fundamental to Kodi skin development, enabling dynamic content, code reuse, and modular design.

---

## 1. Skin Variables

Skin variables are dynamic values that can change at runtime. They are evaluated during skin rendering and are essential for the script.skinvariables addon.

### Variable Declaration

```xml
<variable name="HomeSwitcher.Home.Spotlight.List" value="$INFO[Skin.String(HomeSwitcher.Home.Spotlight.List)]" />
<variable name="HomeSwitcher.DisableSearch" value="false" />
<variable name="HomeSwitcher.LoopBack" value="1" />
```

### Variable Types

| Type | Example | Description |
|---|---|---|
| **String** | `$INFO[Skin.String(var)]` | Text values |
| **Boolean** | `Skin.Boolean(var)` | True/false values |
| **Integer** | `Skin.Integer(var)` | Numeric values |

### Variable Resolution Order

1. **Core variables** - Built-in Kodi variables
2. **Skin variables** - Variables defined in addon.xml
3. **Infolabels** - `$INFO[]` expressions
4. **Expressions** - `$EXP[]` evaluations

### Common Variable Patterns

```xml
<!-- Self-referencing variable (common in HomeSwitcher) -->
<variable name="HomeSwitcher.Home.Spotlight.List" 
  value="$INFO[Skin.String(HomeSwitcher.Home.Spotlight.List)]" />

<!-- Boolean toggle -->
<variable name="HomeSwitcher.DisableSearch" 
  value="!Skin.HasSetting(HomeSwitcher.DisableSearch)" />

<!-- Integer counter -->
<variable name="HomeSwitcher.LoopBack" 
  value="Skin.Integer(HomeSwitcher.LoopBack, 1)" />
```

### Variable Evaluation

```xml
<!-- In visible conditions -->
<visible>
  <or>
    <condition expression="!Skin.HasSetting(HomeSwitcher.DisableSearch)" />
    <condition expression="IsVisible(HomeSwitcher.Home.InProgress)" />
  </or>
</visible>

<!-- In onclick actions -->
<onclick>Skin.SetSetting(HomeSwitcher.DisableSearch,true)</onclick>

<!-- In labels -->
<label>$INFO[Skin.String(HomeSwitcher.Home.Spotlight.List)]</label>
```

### Built-in Variable Functions

| Function | Description | Example |
|---|---|---|
| `Skin.HasSetting(name)` | Check if setting is enabled | `Skin.HasSetting(HomeSwitcher.DisableSearch)` |
| `Skin.String(name)` | Get string variable value | `Skin.String(HomeSwitcher.Home.Spotlight.List)` |
| `Skin.Boolean(name)` | Get boolean variable value | `Skin.Boolean(HomeSwitcher.DisableSearch)` |
| `Skin.Integer(name, default)` | Get integer variable value | `Skin.Integer(HomeSwitcher.LoopBack, 1)` |
| `Skin.Reset(name)` | Reset variable | `Skin.Reset(HomeSwitcher.Home.Spotlight.List)` |
| `Skin.SetSetting(name, value)` | Set addon setting | `Skin.SetSetting(HomeSwitcher.DisableSearch,true)` |

### Variable Naming Conventions

```
[Category].[Subcategory].[Item].[Property]
  HomeSwitcher.Home.Spotlight.List
  HomeSwitcher.DisableSearch
  HomeSwitcher.LoopBack
```

---

## 2. Includes

Includes allow code reuse and modular design in Kodi skins. They are resolved in a specific order and can contain nested includes.

### Include Types

| Type | Description | Example |
|---|---|---|
| **Core includes** | Essential includes loaded first | `Includes.xml` |
| **Window-specific** | Includes for specific windows | `Includes_Home.xml` |
| **Widget definitions** | Hub row definitions | `Includes_Hubs.xml` |
| **Control definitions** | Button, list, label definitions | `Includes_Buttons.xml` |
| **Override files** | Loaded before generator includes | `script-skinvariables-generator-overrides.xml` |

### Include Resolution Order

1. `Includes.xml` - Core includes loaded first
2. Window-specific includes (e.g., `Includes_Home.xml`)
3. Widget definition includes (e.g., `Includes_Hubs.xml`)
4. Control definition includes (e.g., `Includes_Buttons.xml`)
5. Override files (e.g., `script-skinvariables-generator-overrides.xml`)

### Include Example

```xml
<!-- In Home.xml -->
<include name="Includes_Home.xml" />
<include name="Includes_Hubs.xml" />

<!-- In Includes_Home.xml -->
<include name="Includes_Hubs.xml" />
<include name="Includes_Buttons.xml" />
```

### Include Attributes

| Attribute | Description | Example |
|---|---|---|
| `name` | Include file name | `name="Includes_Home.xml"` |
| `file` | Include file path | `file="script-skinvariables-generator-overrides.xml"` |

### Include Best Practices

1. **Use includes for reusable code** - Define common control groups in includes
2. **Avoid circular includes** - Ensure includes don't reference each other in a loop
3. **Use override files for customizations** - Override default includes with custom ones
4. **Document include dependencies** - Keep track of which includes depend on which

### Override Files

Override files are loaded before generator includes and allow customizations:

```xml
<!-- In addon.xml -->
<requires>
  <import addon="xbmc.gui" version="5.0.0" />
  <import addon="script.skinvariables" version="3.0.0" />
</requires>

<!-- Override default includes -->
<include file="script-skinvariables-generator-overrides.xml" />
```

---

## 3. Include Categories

### Core Includes

| Include | Description |
|---|---|
| `Includes.xml` | Core includes loaded first |

### Window-Specific Includes

| Include | Description |
|---|---|
| `Includes_Home.xml` | Home hub includes |
| `Includes_Search.xml` | Search window includes |
| `Includes_LiveTV.xml` | Live TV includes |
| `Includes_NextAired.xml` | Next aired includes |
| `Includes_Weather.xml` | Weather includes |

### Widget Definition Includes

| Include | Description |
|---|---|
| `Includes_Hubs.xml` | Hub row definitions |
| `Includes_Views.xml` | View definitions |
| `Includes_Views_Combined.xml` | Combined view definitions |
| `Includes_Views_List.xml` | List view definitions |
| `Includes_Views_PVR.xml` | PVR view definitions |
| `Includes_Views_Row.xml` | Row view definitions |
| `Includes_Views_Wall.xml` | Wall view definitions |

### Control Definition Includes

| Include | Description |
|---|---|
| `Includes_Buttons.xml` | Button definitions |
| `Includes_Lists.xml` | List definitions |
| `Includes_Labels.xml` | Label definitions |
| `Includes_Images.xml` | Image definitions |
| `Includes_Overlay.xml` | Overlay definitions |
| `Includes_Widgets.xml` | Widget definitions |

### Other Includes

| Include | Description |
|---|---|
| `Includes_Actions.xml` | Action dispatch |
| `Includes_Animations.xml` | Animation definitions |
| `Includes_Background.xml` | Background definitions |
| `Includes_Constants.xml` | Constant definitions |
| `Includes_DialogInfo.xml` | Dialog info wiring |
| `Includes_Dimensions.xml` | Dimension definitions |
| `Includes_Expressions.xml` | Expression definitions |
| `Includes_Fallbacks.xml` | Fallback definitions |
| `Includes_Furniture.xml` | Furniture definitions |
| `Includes_Info.xml` | Info definitions |
| `Includes_Layouts.xml` | Layout definitions |
| `Includes_OSD.xml` | OSD includes |
| `Includes_Paths.xml` | Path contract variables |
| `Includes_Settings.xml` | Settings definitions |
| `Includes_SkinSettings.xml` | Skin settings definitions |
| `Includes_Textures.xml` | Texture definitions |
| `Includes_Weather.xml` | Weather includes |

---

## 4. Common Patterns

### Variable in Include

```xml
<!-- In Includes_Hubs.xml -->
<include name="Includes_Hubs.xml">
  <variable name="HomeSwitcher.Home.Spotlight.List" 
    value="$INFO[Skin.String(HomeSwitcher.Home.Spotlight.List)]" />
</include>
```

### Include with Conditions

```xml
<include name="Includes_Hubs.xml">
  <visible>IsVisible(HomeSwitcher.Home.Spotlight)</visible>
</include>
```

### Nested Includes

```xml
<!-- In Includes_Home.xml -->
<include name="Includes_Hubs.xml" />

<!-- In Includes_Hubs.xml -->
<include name="Includes_Buttons.xml" />

<!-- In Includes_Buttons.xml -->
<include name="Includes_Labels.xml" />
```

---

## 5. Expression Evaluation

Expressions are evaluated using `$EXP[]` and are commonly used in variables and conditions.

### Common Expressions

```xml
<!-- In variables -->
<variable name="HomeSwitcher.Home.Spotlight.List" 
  value="$EXP[Skin.String(HomeSwitcher.Home.Spotlight.List)]" />

<!-- In conditions -->
<visible>
  <condition expression="$EXP[IsVisible(HomeSwitcher.Home.Spotlight)]" />
</visible>

<!-- In onclick -->
<onclick>$EXP[Skin.SetSetting(HomeSwitcher.DisableSearch,true)]</onclick>
```

### Expression Functions

| Function | Description |
|---|---|
| `Skin.String(name)` | Get string variable value |
| `Skin.Boolean(name)` | Get boolean variable value |
| `Skin.Integer(name, default)` | Get integer variable value |
| `IsVisible(id)` | Check if control is visible |
| `Control.HasFocus(id)` | Check if control has focus |
| `GetFocus()` | Get focused control ID |

---

## 6. Best Practices

### Variables

1. **Use descriptive names** - Follow the `[Category].[Subcategory].[Item].[Property]` convention
2. **Avoid circular dependencies** - Ensure variables don't reference each other in a loop
3. **Use self-referencing for dynamic lists** - Common in HomeSwitcher for dynamic content
4. **Reset variables when needed** - Use `Skin.Reset()` to clear stale values

### Includes

1. **Organize by function** - Group related includes together
2. **Use override files for customizations** - Don't modify core includes directly
3. **Document dependencies** - Keep track of which includes depend on which
4. **Avoid deep nesting** - Keep include chains short and manageable

### General

1. **Test in Kodi** - Always test changes in Kodi to ensure proper rendering
2. **Use version control** - Track changes to variables and includes
3. **Document patterns** - Record common patterns for future reference
4. **Keep it modular** - Design for easy extension and modification

---

*See also: [Core Architecture](01_CORE_ARCHITECTURE.md), [Components](02_CORE_COMPONENTS.md), [Controls](03_CONTROLS.md)*