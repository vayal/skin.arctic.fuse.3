# View Mode Enforcement

## Overview

View mode enforcement is a critical aspect of Kodi skin development. It ensures that content is displayed in the correct layout (row, wall, spotlight) and maintains consistency across the UI.

---

## 1. View Mode Types

### Row View

Horizontal scrolling view for content lists.

| Attribute | Description |
|---|---|
| **Type** | Row |
| **Description** | Horizontal scrolling |
| **Usage** | Spotlight, Continue Watching |
| **Item Height** | 60 |
| **Item Width** | 1920 |

### Wall View

Grid layout view for content lists.

| Attribute | Description |
|---|---|
| **Type** | Wall |
| **Description** | Grid layout |
| **Usage** | In Progress, Recently Added, Active Shows |
| **Item Height** | 180 |
| **Item Width** | 480 |

### Spotlight View

Hero/featured layout view.

| Attribute | Description |
|---|---|
| **Type** | Spotlight |
| **Description** | Hero/featured layout |
| **Usage** | Spotlight widget |
| **Item Height** | 1080 |
| **Item Width** | 1920 |

---

## 2. View Mode Enforcement

### Enforcement Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    VIEW MODE ENFORCEMENT                      │
├─────────────────────────────────────────────────────────────┤
│  Input:                                                      │
│    • Widget type (spotlight, standard, combined)              │
│    • Hub type (spotlight, in progress, recently added)        │
│    • Contract family (home, series, movies, provider)         │
├─────────────────────────────────────────────────────────────┤
│  Processing:                                                 │
│    • Map widget + hub → view mode                             │
│    • Apply view mode to list control                          │
│    • Enforce item dimensions                                  │
├─────────────────────────────────────────────────────────────┤
│  Output:                                                     │
│    • List control with correct view mode                      │
│    • Consistent item dimensions                               │
│    • Proper horizontal/vertical scrolling                     │
└─────────────────────────────────────────────────────────────┘
```

### View Mode Mapping

| Widget | Hub | View Mode | Item Height | Item Width |
|---|---|---|---|---|
| Spotlight | Spotlight | Spotlight | 1080 | 1920 |
| Standard | In Progress Series | Wall | 180 | 480 |
| Standard | In Progress Movies | Wall | 180 | 480 |
| Standard | Continue Watching | Row | 60 | 1920 |
| Standard | Recently Added | Wall | 180 | 480 |
| Standard | Recently Watched | Wall | 180 | 480 |
| Standard | Active Shows | Wall | 180 | 480 |
| Standard | Up Next | Wall | 180 | 480 |

---

## 3. View Mode Implementation

### View Mode Definition

```xml
<!-- In Includes_Views.xml -->
<view mode="row">
  <controls>
    <control type="list" id="1001">
      <itemheight>60</itemheight>
      <itemwidth>1920</itemwidth>
    </control>
  </controls>
</view>

<view mode="wall">
  <controls>
    <control type="list" id="1001">
      <itemheight>180</itemheight>
      <itemwidth>480</itemwidth>
    </control>
  </controls>
</view>

<view mode="spotlight">
  <controls>
    <control type="list" id="1001">
      <itemheight>1080</itemheight>
      <itemwidth>1920</itemwidth>
    </control>
  </controls>
</view>
</view>
```

### View Mode Enforcement in Code

```xml
<!-- In Home.xml -->
<control type="group" id="1001">
  <visible>IsVisible(HomeSwitcher.Home.Spotlight)</visible>
  <view mode="spotlight">
    <controls>
      <control type="list" id="1002">
        <itemheight>1080</itemheight>
        <itemwidth>1920</itemwidth>
      </control>
    </controls>
  </view>
</control>
```

### View Mode Switching

```xml
<!-- In Includes_Views.xml -->
<view mode="row">
  <controls>
    <control type="list" id="1001">
      <itemheight>60</itemheight>
      <itemwidth>1920</itemwidth>
    </control>
  </controls>
</view>

<view mode="wall">
  <controls>
    <control type="list" id="1001">
      <itemheight>180</itemheight>
      <itemwidth>480</itemwidth>
    </control>
  </controls>
</view>

<!-- View mode switching based on widget type -->
<visible>
  <or>
    <condition expression="IsVisible(HomeSwitcher.Home.Spotlight)" />
    <condition expression="IsVisible(HomeSwitcher.Home.ContinueWatching)" />
  </or>
</visible>
<view mode="row">
  <controls>
    <control type="list" id="1001">
      <itemheight>60</itemheight>
      <itemwidth>1920</itemwidth>
    </control>
  </controls>
</view>
```

---

## 4. View Mode Best Practices

### Widget Selection

1. **Use spotlight widget for hero content** - Spotlight widgets use spotlight view mode
2. **Use standard widget for regular content** - Standard widgets use row or wall view modes
3. **Use combined widget for mixed content** - Combined widgets handle mixed view modes

### View Mode Selection

1. **Use row view for horizontal content** - Row view is ideal for carousels and horizontal lists
2. **Use wall view for grid content** - Wall view works well for galleries and grids
3. **Use spotlight view for hero content** - Spotlight view is designed for featured content

### View Mode Enforcement

1. **Always enforce view mode** - Use `<view mode="...">` in all list controls
2. **Use item dimensions** - Set `itemheight` and `itemwidth` explicitly
3. **Use visibility conditions** - Hide inactive view modes
4. **Use view mode switching** - Switch view modes based on widget type

### Performance

1. **Defer view mode loading** - Load view modes only when needed
2. **Cache view mode data** - Cache view mode configurations
3. **Batch view mode requests** - Batch view mode requests when possible
4. **Use view mode enforcement** - Ensure correct view mode to reduce rendering overhead

---

## 5. View Mode Common Patterns

### View Mode Definition

```xml
<!-- In Includes_Views.xml -->
<view mode="row">
  <controls>
    <control type="list" id="1001">
      <itemheight>60</itemheight>
      <itemwidth>1920</itemwidth>
    </control>
  </controls>
</view>
```

### View Mode Enforcement

```xml
<!-- In Home.xml -->
<control type="group" id="1001">
  <visible>IsVisible(HomeSwitcher.Home.Spotlight)</visible>
  <view mode="spotlight">
    <controls>
      <control type="list" id="1002">
        <itemheight>1080</itemheight>
        <itemwidth>1920</itemwidth>
      </control>
    </controls>
  </view>
</control>
```

### View Mode Switching

```xml
<!-- In Includes_Views.xml -->
<visible>
  <or>
    <condition expression="IsVisible(HomeSwitcher.Home.Spotlight)" />
    <condition expression="IsVisible(HomeSwitcher.Home.ContinueWatching)" />
  </or>
</visible>
<view mode="row">
  <controls>
    <control type="list" id="1001">
      <itemheight>60</itemheight>
      <itemwidth>1920</itemwidth>
    </control>
  </controls>
</view>
```

---

## 6. View Mode Troubleshooting

### Common Issues

| Issue | Cause | Solution |
|---|---|---|
| Content not displaying | View mode not enforced | Add `<view mode="...">` |
| Wrong item dimensions | Item dimensions not set | Set `itemheight` and `itemwidth` |
| Horizontal scrolling issues | Row view not enforced | Use `<view mode="row">` |
| Grid layout issues | Wall view not enforced | Use `<view mode="wall">` |
| Hero content not full screen | Spotlight view not enforced | Use `<view mode="spotlight">` |

### Debugging View Mode

```xml
<!-- Debug view mode -->
<visible>
  <or>
    <condition expression="IsVisible(HomeSwitcher.Home.Spotlight)" />
    <condition expression="IsVisible(HomeSwitcher.Home.ContinueWatching)" />
  </or>
</visible>
<view mode="row">
  <controls>
    <control type="list" id="1001">
      <itemheight>60</itemheight>
      <itemwidth>1920</itemwidth>
    </control>
  </controls>
</view>
```

---

## 7. View Mode Reference

### Row View

| Attribute | Value |
|---|---|
| **Type** | Row |
| **Item Height** | 60 |
| **Item Width** | 1920 |
| **Scrolling** | Horizontal |
| **Usage** | Spotlight, Continue Watching |

### Wall View

| Attribute | Value |
|---|---|
| **Type** | Wall |
| **Item Height** | 180 |
| **Item Width** | 480 |
| **Scrolling** | Vertical |
| **Usage** | In Progress, Recently Added, Active Shows |

### Spotlight View

| Attribute | Value |
|---|---|
| **Type** | Spotlight |
| **Item Height** | 1080 |
| **Item Width** | 1920 |
| **Scrolling** | None |
| **Usage** | Spotlight widget |

---

*See also: [Core Architecture](01_CORE_ARCHITECTURE.md), [Hubs](07_HUBS.md), [D-003 view mode matrix](../roadmap/d003-view-mode-matrix.md)*