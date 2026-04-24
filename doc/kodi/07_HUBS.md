# Hub Architecture

## Overview

Hubs are the primary content containers in Kodi skins. They organize content into themed sections and use widgets to display content in specific view modes.

---

## 1. Hub Types

### Spotlight Hub

The spotlight hub is the hero/featured content area, typically displaying a large featured item.

| Attribute | Description |
|---|---|
| **Type** | Spotlight |
| **Contract** | `home_spotlight_mixed` |
| **View** | Row |
| **Widget** | Spotlight |
| **Description** | Hero/featured content display |

### In Progress Hubs

Track content the user is actively watching.

| Hub | Description | Contract | View | Widget |
|---|---|---|---|---|
| In Progress Series | Series currently being watched | `home_in_progress_series` | Wall | Standard |
| In Progress Movies | Movies currently being watched | `home_in_progress_movies` | Wall | Standard |

### Continue Watching

Shows the next episode/scene for content in progress.

| Attribute | Description |
|---|---|
| **Type** | Continue Watching |
| **Contract** | `home_continue_watching` |
| **View** | Row |
| **Widget** | Standard |
| **Description** | Next episode/scene display |

### Recently Added

Shows newly added content to the library.

| Attribute | Description |
|---|---|
| **Type** | Recently Added |
| **Contract** | `home_recently_added` |
| **View** | Wall |
| **Widget** | Standard |
| **Description** | Newly added content display |

### Recently Watched

Shows recently watched content.

| Attribute | Description |
|---|---|
| **Type** | Recently Watched |
| **Contract** | `home_recently_watched` |
| **View** | Wall |
| **Widget** | Standard |
| **Description** | Recently watched content display |

### Active Shows

Shows shows the user is actively following.

| Attribute | Description |
|---|---|
| **Type** | Active Shows |
| **Contract** | `home_active_shows` |
| **View** | Wall |
| **Widget** | Standard |
| **Description** | Active shows display |

### Up Next

Shows upcoming episodes and movies.

| Attribute | Description |
|---|---|
| **Type** | Up Next |
| **Contract** | `home_up_next` |
| **View** | Wall |
| **Widget** | Standard |
| **Description** | Upcoming content display |

---

## 2. Widget Types

### Spotlight Widget

The spotlight widget is the hero/featured content display.

| Attribute | Description |
|---|---|
| **Type** | Spotlight |
| **View** | Row |
| **Contract** | Varies by hub |
| **Description** | Hero/featured content |

### Standard Widget

Standard content widget for regular content lists.

| Attribute | Description |
|---|---|
| **Type** | Standard |
| **View** | Row or Wall |
| **Contract** | Varies by hub |
| **Description** | Regular content display |

### Combined Widget

Combined view widget for mixed content types.

| Attribute | Description |
|---|---|
| **Type** | Combined |
| **View** | Spotlight |
| **Contract** | Varies by hub |
| **Description** | Mixed content display |

---

## 3. View Modes

### Row View

Horizontal scrolling view for content lists.

| Attribute | Description |
|---|---|
| **Type** | Row |
| **Description** | Horizontal scrolling |
| **Usage** | Spotlight, Continue Watching |

### Wall View

Grid layout view for content lists.

| Attribute | Description |
|---|---|
| **Type** | Wall |
| **Description** | Grid layout |
| **Usage** | In Progress, Recently Added, Active Shows |

### Spotlight View

Hero/featured layout view.

| Attribute | Description |
|---|---|
| **Type** | Spotlight |
| **Description** | Hero/featured layout |
| **Usage** | Spotlight widget |

---

## 4. Hub Contract Families

### Home Contract Family

| Contract | Description |
|---|---|
| `home_spotlight_mixed` | Spotlight hub |
| `home_in_progress_series` | In progress series hub |
| `home_in_progress_movies` | In progress movies hub |
| `home_continue_watching` | Continue watching hub |
| `home_recently_added` | Recently added hub |
| `home_recently_watched` | Recently watched hub |
| `home_active_shows` | Active shows hub |
| `home_up_next` | Up next hub |

### Series Hub Contract Family

| Contract | Description |
|---|---|
| `series_spotlight_trending` | Series spotlight trending |
| `series_continue_watching_episodes` | Series continue watching episodes |
| `series_recently_added` | Series recently added |
| `series_recently_watched` | Series recently watched |
| `series_active_shows` | Series active shows |
| `series_up_next` | Series up next |

### Movies Hub Contract Family

| Contract | Description |
|---|---|
| `movies_spotlight_trending` | Movies spotlight trending |
| `movies_in_progress` | Movies in progress |
| `movies_continue_watching` | Movies continue watching |
| `movies_recently_added` | Movies recently added |
| `movies_recently_watched` | Movies recently watched |
| `movies_active_shows` | Movies active shows |
| `movies_up_next` | Movies up next |

### Provider Mini-Hub Contract Family

| Contract | Description |
|---|---|
| `provider_{id}_spotlight` | Provider spotlight |
| `provider_{id}_trending` | Provider trending |
| `provider_{id}_continue_watching` | Provider continue watching |
| `provider_{id}_recently_added` | Provider recently added |
| `provider_{id}_recently_watched` | Provider recently watched |
| `provider_{id}_active_shows` | Provider active shows |
| `provider_{id}_up_next` | Provider up next |

### Search Contract Family

| Contract | Description |
|---|---|
| `search_movies` | Search movies |
| `search_tvshows` | Search TV shows |
| `search_movies_in_progress` | Search movies in progress |
| `search_tvshows_in_progress` | Search TV shows in progress |

---

## 5. Hub Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    HUB ARCHITECTURE                          │
├─────────────────────────────────────────────────────────────┤
│  Hub Types:                                                  │
│    ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐                  │
│    │Spotlight│ │In Progress│ │Continue│ │Recently│            │
│    │ Hub   │ │ Series  │ │Watching │ │Added   │            │
│    └──────┘  └──────┘  └──────┘  └──────┘                  │
│    ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐                  │
│    │Recently│ │Active │ │Up Next │ │Search  │            │
│    │Watched│ │Shows  │ │      │ │      │                  │
│    └──────┘  └──────┘  └──────┘  └──────┘                  │
├─────────────────────────────────────────────────────────────┤
│  Widget Types:                                               │
│    ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐                  │
│    │Spotlight│ │Standard│ │Combined│ │Standard│            │
│    │Widget │ │Widget │ │Widget │ │Widget │            │
│    └──────┘  └──────┘  └──────┘  └──────┘                  │
├─────────────────────────────────────────────────────────────┤
│  View Modes:                                                 │
│    ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐                  │
│    │Row   │  │Wall  │  │Spotlight│ │Row   │            │
│    │View  │  │View  │  │View  │ │View  │            │
│    └──────┘  └──────┘  └──────┘  └──────┘                  │
├─────────────────────────────────────────────────────────────┤
│  Contract Families:                                          │
│    Home | Series | Movies | Provider | Search                │
└─────────────────────────────────────────────────────────────┘
```

---

## 6. Hub Widget Mapping

### Spotlight Hub

| Attribute | Description |
|---|---|
| **Hub Type** | Spotlight |
| **Widget Type** | Spotlight |
| **View Mode** | Row |
| **Contract** | `home_spotlight_mixed` |
| **Description** | Hero/featured content display |

### In Progress Series Hub

| Attribute | Description |
|---|---|
| **Hub Type** | In Progress Series |
| **Widget Type** | Standard |
| **View Mode** | Wall |
| **Contract** | `home_in_progress_series` |
| **Description** | Series currently being watched |

### In Progress Movies Hub

| Attribute | Description |
|---|---|
| **Hub Type** | In Progress Movies |
| **Widget Type** | Standard |
| **View Mode** | Wall |
| **Contract** | `home_in_progress_movies` |
| **Description** | Movies currently being watched |

### Continue Watching Hub

| Attribute | Description |
|---|---|
| **Hub Type** | Continue Watching |
| **Widget Type** | Standard |
| **View Mode** | Row |
| **Contract** | `home_continue_watching` |
| **Description** | Next episode/scene display |

### Recently Added Hub

| Attribute | Description |
|---|---|
| **Hub Type** | Recently Added |
| **Widget Type** | Standard |
| **View Mode** | Wall |
| **Contract** | `home_recently_added` |
| **Description** | Newly added content display |

### Recently Watched Hub

| Attribute | Description |
|---|---|
| **Hub Type** | Recently Watched |
| **Widget Type** | Standard |
| **View Mode** | Wall |
| **Contract** | `home_recently_watched` |
| **Description** | Recently watched content display |

### Active Shows Hub

| Attribute | Description |
|---|---|
| **Hub Type** | Active Shows |
| **Widget Type** | Standard |
| **View Mode** | Wall |
| **Contract** | `home_active_shows` |
| **Description** | Active shows display |

### Up Next Hub

| Attribute | Description |
|---|---|
| **Hub Type** | Up Next |
| **Widget Type** | Standard |
| **View Mode** | Wall |
| **Contract** | `home_up_next` |
| **Description** | Upcoming content display |

---

## 7. Hub Implementation Patterns

### Hub Definition

```xml
<!-- In Includes_Hubs.xml -->
<include name="Includes_Hubs.xml">
  <variable name="HomeSwitcher.Home.Spotlight.List" 
    value="$INFO[Skin.String(HomeSwitcher.Home.Spotlight.List)]" />
</include>
```

### Widget Rendering

```xml
<!-- In Home.xml -->
<control type="group" id="1001">
  <visible>IsVisible(HomeSwitcher.Home.Spotlight)</visible>
  <control type="list" id="1002">
    <label>Spotlight</label>
    <item>
      <label>$INFO[ListItem.Title]</label>
      <icon>$INFO[ListItem.Icon]</icon>
    </item>
  </control>
</control>
```

### View Mode Enforcement

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
```

---

## 8. Hub Best Practices

### Widget Selection

1. **Use spotlight widget for hero content** - Spotlight widgets are designed for featured content
2. **Use standard widget for regular content** - Standard widgets work well for most content types
3. **Use combined widget for mixed content** - Combined widgets handle mixed content types

### View Mode Selection

1. **Use row view for horizontal content** - Row view is ideal for carousels and horizontal lists
2. **Use wall view for grid content** - Wall view works well for galleries and grids
3. **Use spotlight view for hero content** - Spotlight view is designed for featured content

### Contract Usage

1. **Follow D-015 contracts** - Use the contract family structure
2. **Handle pagination** - Implement `has_more` and `next_page` properly
3. **Track progress** - Implement `last_watched_at` and `percent_watched`
4. **Test contract data** - Verify contract data in Kodi

### Performance

1. **Defer loading** - Load widgets only when needed
2. **Cache data** - Cache contract data to reduce API calls
3. **Batch requests** - Batch contract requests when possible
4. **Use view mode enforcement** - Ensure correct view mode to reduce rendering overhead

---

## 9. Hub Common Patterns

### Hub Switching

```xml
<!-- In Home.xml -->
<visible>
  <or>
    <condition expression="!Skin.HasSetting(HomeSwitcher.DisableSearch)" />
    <condition expression="IsVisible(HomeSwitcher.Home.InProgress)" />
  </or>
</visible>
```

### Widget List

```xml
<!-- In Includes_Hubs.xml -->
<include name="Includes_Hubs.xml">
  <variable name="HomeSwitcher.Home.Spotlight.List" 
    value="$INFO[Skin.String(HomeSwitcher.Home.Spotlight.List)]" />
</include>
```

### View Mode Enforcement

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

---

*See also: [Core Architecture](01_CORE_ARCHITECTURE.md), [Velocity surfaces inventory](../velocity/surfaces/README.md), [View Modes](08_VIEW_MODES.md)*