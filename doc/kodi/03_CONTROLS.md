# Kodi Skin Controls Reference

## Overview

Kodi skin controls are the building blocks of the user interface. Each control type has specific attributes and behaviors.

---

## Control Type Cheat Sheet

| Type | Description | Common Uses |
|---|---|---|
| **Group** | Container for other controls | Layout organization, visibility grouping |
| **Button** | Clickable button | Navigation, actions |
| **Label** | Text display | Titles, descriptions, infolabels |
| **Image** | Static image | Thumbnails, backgrounds, icons |
| **List** | Scrollable list | Content browsing, navigation |
| **TextButton** | Text-based button | Compact navigation |
| **Toggle** | On/off switch | Settings, toggles |
| **Slider** | Range selector | Volume, progress |
| **ProgressBar** | Progress indicator | Loading, buffering |
| **TextList** | Labeled list | Settings, options |
| **Edit** | Text input | Search, configuration |
| **SpinControl** | Increment/decrement | Selection, quantity |
| **ColorControl** | Color picker | Color selection |
| **ContextMenu** | Context menu | Right-click menus |
| **Dialog** | Modal window | Confirmations, selections |
| **Overlay** | Background overlay | Blur, transparency |

---

## 1. Group

Container for organizing other controls.

### Attributes

| Attribute | Description | Example |
|---|---|---|
| `type` | `group` | `group` |
| `id` | Control ID | `100` |
| `posx` | X position | `posx="50"` |
| `posy` | Y position | `posy="100"` |
| `width` | Width | `width="1920"` |
| `height` | Height | `height="1080"` |
| `visible` | Visibility condition | `visible="IsVisible(101)"` |
| `focus` | Focus behavior | `focus="1"` |

### Example

```xml
<control type="group" id="100">
  <posx>50</posx>
  <posy>100</posy>
  <width>1920</width>
  <height>1080</height>
  
  <control type="label" id="101">
    <label>Home</label>
  </control>
  
  <control type="button" id="102">
    <label>Settings</label>
  </control>
</control>
```

---

## 2. Button

Clickable button control.

### Attributes

| Attribute | Description | Example |
|---|---|---|
| `type` | `button` | `button` |
| `id` | Control ID | `1001` |
| `label` | Button text | `label="Play"` |
| `onclick` | Click action | `onclick="ActivateWindow(home)"` |
| `focusedbackground` | Focused background | `focusedbackground="skin://textures/buttons/focused.png"` |
| `unfocusedbackground` | Unfocused background | `unfocusedbackground="skin://textures/buttons/unfocused.png"` |
| `texturefocus` | Focused texture | `texturefocus="skin://textures/buttons/focus.png"` |
| `textureunfocused` | Unfocused texture | `textureunfocused="skin://textures/buttons/unfocus.png"` |
| `select` | Select on click | `select="1"` |

### Example

```xml
<control type="button" id="1001">
  <posx>50</posx>
  <posy>100</posy>
  <width>300</width>
  <height>60</height>
  <label>Play</label>
  <onclick>ActivateWindow(home)</onclick>
  <focusedbackground>skin://textures/buttons/focused.png</focusedbackground>
  <unfocusedbackground>skin://textures/buttons/unfocused.png</unfocusedbackground>
  <select>1</select>
</control>
```

### Button Types

| Type | Description |
|---|---|
| `button` | Standard clickable button |
| `textbutton` | Text-based button (compact) |
| `toggle` | On/off switch |
| `slider` | Range selector |
| `progressbar` | Progress indicator |

---

## 3. Label

Text display control.

### Attributes

| Attribute | Description | Example |
|---|---|---|
| `type` | `label` | `label` |
| `id` | Control ID | `1001` |
| `label` | Text content | `label="Title"` or `$INFO[Player.Info.Title]` |
| `align` | Text alignment | `align="center"` |
| `font` | Font name | `font="font14"` |
| `size` | Font size | `size="24"` |
| `color` | Text color | `color="FF000000"` |
| `wrap` | Word wrapping | `wrap="true"` |
| `visible` | Visibility | `visible="IsVisible(1001)"` |

### Infolabels

Common infolabels for dynamic content:

| Infolabel | Description |
|---|---|
| `$INFO[Player.Info.Title]` | Current media title |
| `$INFO[Player.Info.Artist]` | Current media artist |
| `$INFO[Player.Info.Duration]` | Current media duration |
| `$INFO[Player.Playback.Position]` | Current playback position |
| `$INFO[Player.Playback.Duration]` | Total playback duration |
| `$INFO[Player.Info.Plot]` | Current media plot/synopsis |
| `$INFO[ListItem.Title]` | Selected list item title |
| `$INFO[ListItem.Art(TV)]` | Selected list item TV art |
| `$INFO[ListItem.Icon]` | Selected list item icon |
| `$INFO[Skin.String(variable)]` | Skin variable value |
| `$EXP[Expression]` | Evaluated expression |

### Example

```xml
<control type="label" id="1001">
  <posx>50</posx>
  <posy>100</posy>
  <width>1920</width>
  <height>60</height>
  <label>$INFO[Player.Info.Title]</label>
  <align>center</align>
  <font>font14</font>
  <size>24</size>
  <color>FF000000</color>
</control>
```

---

## 4. Image

Static image display control.

### Attributes

| Attribute | Description | Example |
|---|---|---|
| `type` | `image` | `image` |
| `id` | Control ID | `1001` |
| `texture` | Image file path | `texture="skin://textures/images/bg.png"` |
| `posx` | X position | `posx="50"` |
| `posy` | Y position | `posy="100"` |
| `width` | Width | `width="1920"` |
| `height` | Height | `height="1080"` |
| `aspectratio` | Aspect ratio | `aspectratio="stretch"` |
| `zorder` | Z-order (layering) | `zorder="1"` |

### Aspect Ratio Options

| Value | Description |
|---|---|
| `stretch` | Stretch to fit container |
| `keep` | Keep aspect ratio, fill container |
| `zoom` | Zoom to fill container |
| `scale` | Scale to fit container |

### Example

```xml
<control type="image" id="1001">
  <posx>0</posx>
  <posy>0</posy>
  <width>1920</width>
  <height>1080</height>
  <texture>skin://textures/images/bg.png</texture>
  <aspectratio>stretch</aspectratio>
  <zorder>1</zorder>
</control>
```

---

## 5. List

Scrollable list control for content browsing.

### Attributes

| Attribute | Description | Example |
|---|---|---|
| `type` | `list` | `list` |
| `id` | Control ID | `1001` |
| `label` | List title | `label="Movies"` |
| `posx` | X position | `posx="50"` |
| `posy` | Y position | `posy="100"` |
| `width` | Width | `width="1920"` |
| `height` | Height | `height="600"` |
| `itemheight` | Item height | `itemheight="60"` |
| `itemwidth` | Item width | `itemwidth="1920"` |
| `focus` | Focus behavior | `focus="1"` |
| `scrolltime` | Scroll animation time | `scrolltime="300"` |

### List Types

| Type | Description |
|---|---|
| `list` | Standard scrollable list |
| `textlist` | Labeled list with descriptions |
| `spincontrol` | Increment/decrement control |

### Example

```xml
<control type="list" id="1001">
  <posx>50</posx>
  <posy>100</posy>
  <width>1920</width>
  <height>600</height>
  <label>Movies</label>
  <itemheight>60</itemheight>
  <itemwidth>1920</itemwidth>
  <focus>1</focus>
  <scrolltime>300</scrolltime>
</control>
```

---

## 6. TextButton

Compact text-based button.

### Attributes

| Attribute | Description | Example |
|---|---|---|
| `type` | `textbutton` | `textbutton` |
| `id` | Control ID | `1001` |
| `label` | Button text | `label="Play"` |
| `onclick` | Click action | `onclick="ActivateWindow(home)"` |
| `width` | Width | `width="100"` |
| `height` | Height | `height="40"` |
| `align` | Text alignment | `align="center"` |

### Example

```xml
<control type="textbutton" id="1001">
  <posx>50</posx>
  <posy>100</posy>
  <width>100</width>
  <height>40</height>
  <label>Play</label>
  <onclick>ActivateWindow(home)</onclick>
  <align>center</align>
</control>
```

---

## 7. Toggle

On/off switch control.

### Attributes

| Attribute | Description | Example |
|---|---|---|
| `type` | `toggle` | `toggle` |
| `id` | Control ID | `1001` |
| `label` | Switch label | `label="Enable"` |
| `onclick` | Click action | `onclick="Skin.SetSetting(HomeSwitcher.DisableSearch,true)"` |
| `width` | Width | `width="100"` |
| `height` | Height | `height="40"` |

### Example

```xml
<control type="toggle" id="1001">
  <posx>50</posx>
  <posy>100</posy>
  <width>100</width>
  <height>40</height>
  <label>Enable</label>
  <onclick>Skin.SetSetting(HomeSwitcher.DisableSearch,true)</onclick>
</control>
```

---

## 8. Slider

Range selector control.

### Attributes

| Attribute | Description | Example |
|---|---|---|
| `type` | `slider` | `slider` |
| `id` | Control ID | `1001` |
| `label` | Slider label | `label="Volume"` |
| `onclick` | Click action | `onclick="Player.Control.SetVolume(50)"` |
| `width` | Width | `width="1920"` |
| `height` | Height | `height="40"` |
| `min` | Minimum value | `min="0"` |
| `max` | Maximum value | `max="100"` |

### Example

```xml
<control type="slider" id="1001">
  <posx>50</posx>
  <posy>100</posy>
  <width>1920</width>
  <height>40</height>
  <label>Volume</label>
  <onclick>Player.Control.SetVolume(50)</onclick>
  <min>0</min>
  <max>100</max>
</control>
```

---

## 9. TextList

Labeled list control.

### Attributes

| Attribute | Description | Example |
|---|---|---|
| `type` | `textlist` | `textlist` |
| `id` | Control ID | `1001` |
| `label` | List title | `label="Settings"` |
| `posx` | X position | `posx="50"` |
| `posy` | Y position | `posy="100"` |
| `width` | Width | `width="1920"` |
| `height` | Height | `height="600"` |
| `itemheight` | Item height | `itemheight="60"` |
| `itemwidth` | Item width | `itemwidth="1920"` |

### Example

```xml
<control type="textlist" id="1001">
  <posx>50</posx>
  <posy>100</posy>
  <width>1920</width>
  <height>600</height>
  <label>Settings</label>
  <itemheight>60</itemheight>
  <itemwidth>1920</itemwidth>
</control>
```

---

## 10. Edit

Text input control.

### Attributes

| Attribute | Description | Example |
|---|---|---|
| `type` | `edit` | `edit` |
| `id` | Control ID | `1001` |
| `label` | Input label | `label="Search:"` |
| `posx` | X position | `posx="50"` |
| `posy` | Y position | `posy="100"` |
| `width` | Width | `width="1920"` |
| `height` | Height | `height="40"` |
| `text` | Default text | `text="Enter search..."` |
| `maxlength` | Maximum characters | `maxlength="100"` |

### Example

```xml
<control type="edit" id="1001">
  <posx>50</posx>
  <posy>100</posy>
  <width>1920</width>
  <height>40</height>
  <label>Search:</label>
  <text>Enter search...</text>
  <maxlength>100</maxlength>
</control>
```

---

## 11. Overlay

Background overlay control.

### Attributes

| Attribute | Description | Example |
|---|---|---|
| `type` | `overlay` | `overlay` |
| `id` | Control ID | `1001` |
| `texture` | Overlay texture | `texture="skin://textures/overlay/blur.png"` |
| `posx` | X position | `posx="0"` |
| `posy` | Y position | `posy="0"` |
| `width` | Width | `width="1920"` |
| `height` | Height | `height="1080"` |
| `zorder` | Z-order | `zorder="1"` |
| `effect` | Overlay effect | `effect="blur"` |

### Example

```xml
<control type="overlay" id="1001">
  <posx>0</posx>
  <posy>0</posy>
  <width>1920</width>
  <height>1080</height>
  <texture>skin://textures/overlay/blur.png</texture>
  <zorder>1</zorder>
  <effect>blur</effect>
</control>
```

---

## Control Attributes Summary

### Position & Size

| Attribute | Description |
|---|---|
| `posx` | X position |
| `posy` | Y position |
| `width` | Width |
| `height` | Height |
| `aspectratio` | Aspect ratio behavior |

### Appearance

| Attribute | Description |
|---|---|
| `label` | Text content |
| `texture` | Image/texture file |
| `font` | Font name |
| `size` | Font size |
| `color` | Text color |
| `align` | Text alignment |
| `wrap` | Word wrapping |

### Behavior

| Attribute | Description |
|---|---|
| `onclick` | Click action |
| `focus` | Focus behavior |
| `select` | Select on click |
| `scrolltime` | Scroll animation |
| `zorder` | Z-order (layering) |

### Visibility

| Attribute | Description |
|---|---|
| `visible` | Visibility condition |
| `focusedbackground` | Focused background |
| `unfocusedbackground` | Unfocused background |
| `texturefocus` | Focused texture |
| `textureunfocused` | Unfocused texture |

---

## Supplement: control attribute quick reference

*Merged from the former `KODI_SKINS_DEEP_DOCUMENTATION.md` (2026-04).*

### Group controls

| Attribute | Description |
|-----------|-------------|
| id | Unique identifier |
| visible | Visibility condition |
| posx, posy | X, Y position in pixels |
| width, height | Width, height in pixels |
| zorder | Z-axis layering |
| animation | Fade, slide, zoom |
| fadetime | Animation duration in milliseconds |

### List controls

| Attribute | Description |
|-----------|-------------|
| content | Playlist, directory, list, image |
| onselect | Action on item selection |
| onfocus | Action on focus |
| onup, ondown | Action on movement |
| highlight | Highlighted item appearance |
| selecteditemhighlight | Selected item appearance |
| itemheight | Height of each item |

### Button controls

| Attribute | Description |
|-----------|-------------|
| label | Text displayed |
| onclick | Action on click |
| onfocus | Action on focus |
| onhover | Action on hover |
| texture | Background image |
| textcolor | Text color |

### Label controls

| Attribute | Description |
|-----------|-------------|
| label | Static text or infolabel |
| font | Font definition |
| textcolor | Text color |
| align | left, center, right |
| halign | left, center, right |
| wrap | Wrap text |

### Image controls

| Attribute | Description |
|-----------|-------------|
| texture | Image source |
| aspectratio | stretch, keep, zoom, etc. |
| zpos | Z-axis position |
| fadetime | Fade animation time |

---

*See also: [Core Architecture](01_CORE_ARCHITECTURE.md), [Components](02_CORE_COMPONENTS.md)*