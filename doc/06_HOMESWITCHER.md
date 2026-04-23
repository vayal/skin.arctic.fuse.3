# HomeSwitcher System

## Overview

HomeSwitcher is the core navigation system of the Arctic Fuse 3 Velocity fork. It manages hub switching, widget rendering, and the overall home screen experience.

---

## 1. Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    HomeSwitcher                              │
├─────────────────────────────────────────────────────────────┤
│  Hub Types:                                                  │
│    • Spotlight                                              │
│    • In Progress (Series/Movies)                             │
│    • Continue Watching                                       │
│    • Recently Added                                          │
│    • Recently Watched                                        │
│    • Active Shows                                            │
│    • Up Next                                                 │
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
├─────────────────────────────────────────────────────────────┤
│  Hub Switcher Windows:                                       │
│    • 1101 - Spotlight Hub                                   │
│    • 1102 - In Progress Series                              │
│    • 1103 - In Progress Movies                              │
│    • 1104 - Continue Watching                               │
│    • 1106 - Search                                          │
│    • 1107 - Live TV                                         │
│    • 1108 - Addons                                          │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. Hub Types

### Spotlight Hub

The spotlight hub is the primary hero/featured content area.

| Attribute | Description |
|---|---|
| **Type** | Spotlight |
| **Contract** | `home_spotlight_mixed` |
| **View** | Row |
| **Widget** | Spotlight |

### In Progress Hubs

Track content the user is actively watching.

| Hub | Description |
|---|---|
| In Progress Series | Series currently being watched |
| In Progress Movies | Movies currently being watched |

### Continue Watching

Shows the next episode/scene for content in progress.

| Attribute | Description |
|---|---|
| **Type** | Continue Watching |
| **Contract** | `home_continue_watching` |
| **View** | Row |
| **Widget** | Standard |

### Recently Added

Shows newly added content to the library.

| Attribute | Description |
|---|---|
| **Type** | Recently Added |
| **Contract** | `home_recently_added` |
| **View** | Wall |
| **Widget** | Standard |

### Recently Watched

Shows recently watched content.

| Attribute | Description |
|---|---|
| **Type** | Recently Watched |
| **Contract** | `home_recently_watched` |
| **View** | Wall |
| **Widget** | Standard |

### Active Shows

Shows shows the user is actively following.

| Attribute | Description |
|---|---|
| **Type** | Active Shows |
| **Contract** | `home_active_shows` |
| **View** | Wall |
| **Widget** | Standard |

### Up Next

Shows upcoming episodes and movies.

| Attribute | Description |
|---|---|
| **Type** | Up Next |
| **Contract** | `home_up_next` |
| **View** | Wall |
| **Widget** | Standard |

---

## 3. Widget Types

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

## 4. View Modes

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

## 5. Hub Switcher Windows

### 1101 - Spotlight Hub

Primary spotlight hub window.

| Attribute | Description |
|---|---|
| **Window** | 1101 |
| **Type** | Spotlight |
| **Contract** | `home_spotlight_mixed` |
| **View** | Row |
| **Widget** | Spotlight |

### 1102 - In Progress Series

In progress series hub window.

| Attribute | Description |
|---|---|
| **Window** | 1102 |
| **Type** | In Progress Series |
| **Contract** | `home_in_progress_series` |
| **View** | Wall |
| **Widget** | Standard |

### 1103 - In Progress Movies

In progress movies hub window.

| Attribute | Description |
|---|---|
| **Window** | 1103 |
| **Type** | In Progress Movies |
| **Contract** | `home_in_progress_movies` |
| **View** | Wall |
| **Widget** | Standard |

### 1104 - Continue Watching

Continue watching hub window.

| Attribute | Description |
|---|---|
| **Window** | 1104 |
| **Type** | Continue Watching |
| **Contract** | `home_continue_watching` |
| **View** | Row |
| **Widget** | Standard |

### 1106 - Search

Search hub window.

| Attribute | Description |
|---|---|
| **Window** | 1106 |
| **Type** | Search |
| **Contract** | `search_movies`, `search_tvshows` |
| **View** | Row |
| **Widget** | Standard |

### 1107 - Live TV

Live TV hub window.

| Attribute | Description |
|---|---|
| **Window** | 1107 |
| **Type** | Live TV |
| **Contract** | PVR contracts |
| **View** | Row |
| **Widget** | Standard |

### 1108 - Addons

Addons hub window.

| Attribute | Description |
|---|---|
| **Window** | 1108 |
| **Type** | Addons |
| **Contract** | Addon contracts |
| **View** | Row |
| **Widget** | Standard |

---

## 6. HomeSwitcher Variables

### Core Variables

| Variable | Description |
|---|---|
| `HomeSwitcher.Home.Spotlight.List` | Spotlight widget list |
| `HomeSwitcher.Home.InProgress` | In progress hub visibility |
| `HomeSwitcher.DisableSearch` | Disable search setting |
| `HomeSwitcher.LoopBack` | Loop back counter |

### Hub Toggle Variables

| Variable | Description |
|---|---|
| `HomeSwitcher.1101.Toggle` | Spotlight hub toggle |
| `HomeSwitcher.1102.Toggle` | In Progress Series toggle |
| `HomeSwitcher.1103.Toggle` | In Progress Movies toggle |
| `HomeSwitcher.1104.Toggle` | Continue Watching toggle |
| `HomeSwitcher.1106.Toggle` | Search toggle |
| `HomeSwitcher.1107.Toggle` | Live TV toggle |
| `HomeSwitcher.1108.Toggle` | Addons toggle |

### Visibility Variables

| Variable | Description |
|---|---|
| `HomeSwitcher.Home.Spotlight` | Spotlight hub visibility |
| `HomeSwitcher.Home.InProgress` | In progress hub visibility |
| `HomeSwitcher.Home.ContinueWatching` | Continue watching visibility |
| `HomeSwitcher.Home.RecentlyAdded` | Recently added visibility |
| `HomeSwitcher.Home.RecentlyWatched` | Recently watched visibility |
| `HomeSwitcher.Home.ActiveShows` | Active shows visibility |
| `HomeSwitcher.Home.UpNext` | Up next visibility |

---

## 7. HomeSwitcher States

### Active States

| State | Description |
|---|---|
| `HomeSwitcher.Active.Spotlight` | Spotlight hub is active |
| `HomeSwitcher.Active.InProgressSeries` | In progress series hub is active |
| `HomeSwitcher.Active.InProgressMovies` | In progress movies hub is active |
| `HomeSwitcher.Active.ContinueWatching` | Continue watching hub is active |
| `HomeSwitcher.Active.Search` | Search hub is active |
| `HomeSwitcher.Active.LiveTV` | Live TV hub is active |
| `HomeSwitcher.Active.Addons` | Addons hub is active |

### Loading States

| State | Description |
|---|---|
| `HomeSwitcher.Loading.Spotlight` | Spotlight hub is loading |
| `HomeSwitcher.Loading.InProgressSeries` | In progress series hub is loading |
| `HomeSwitcher.Loading.InProgressMovies` | In progress movies hub is loading |
| `HomeSwitcher.Loading.ContinueWatching` | Continue watching hub is loading |
| `HomeSwitcher.Loading.Search` | Search hub is loading |
| `HomeSwitcher.Loading.LiveTV` | Live TV hub is loading |
| `HomeSwitcher.Loading.Addons` | Addons hub is loading |

---

## 8. HomeSwitcher Actions

### Navigation Actions

| Action | Description |
|---|---|
| `ActivateWindow(HomeSwitcher.Home.Spotlight)` | Activate spotlight hub |
| `ActivateWindow(HomeSwitcher.Home.InProgressSeries)` | Activate in progress series hub |
| `ActivateWindow(HomeSwitcher.Home.InProgressMovies)` | Activate in progress movies hub |
| `ActivateWindow(HomeSwitcher.Home.ContinueWatching)` | Activate continue watching hub |
| `ActivateWindow(HomeSwitcher.Home.Search)` | Activate search hub |
| `ActivateWindow(HomeSwitcher.Home.LiveTV)` | Activate live TV hub |
| `ActivateWindow(HomeSwitcher.Home.Addons)` | Activate addons hub |

### Control Actions

| Action | Description |
|---|---|
| `Skin.Reset(HomeSwitcher.Home.Spotlight.List)` | Reset spotlight list |
| `Skin.Reset(HomeSwitcher.1101.Toggle)` | Reset spotlight toggle |
| `Skin.Reset(HomeSwitcher.LoopBack)` | Reset loop back counter |
| `Skin.Reset(DefaultConfig.InitDone)` | Reset init done flag |
| `ActivateWindow(Startup)` | Activate startup window |

---

## 9. HomeSwitcher Events

### Navigation Events

| Event | Description |
|---|---|
| `HomeSwitcher.Navigate.Spotlight` | Navigate to spotlight hub |
| `HomeSwitcher.Navigate.InProgressSeries` | Navigate to in progress series hub |
| `HomeSwitcher.Navigate.InProgressMovies` | Navigate to in progress movies hub |
| `HomeSwitcher.Navigate.ContinueWatching` | Navigate to continue watching hub |
| `HomeSwitcher.Navigate.Search` | Navigate to search hub |
| `HomeSwitcher.Navigate.LiveTV` | Navigate to live TV hub |
| `HomeSwitcher.Navigate.Addons` | Navigate to addons hub |

### Widget Events

| Event | Description |
|---|---|
| `HomeSwitcher.Widget.Spotlight.Click` | Spotlight widget clicked |
| `HomeSwitcher.Widget.Standard.Click` | Standard widget clicked |
| `HomeSwitcher.Widget.Spotlight.Select` | Spotlight widget selected |
| `HomeSwitcher.Widget.Standard.Select` | Standard widget selected |

---

## 10. HomeSwitcher Best Practices

### Navigation

1. **Use hub toggle variables** - Track which hub is active
2. **Reset on navigation** - Clear stale state when switching hubs
3. **Use loop back** - Implement loop back for infinite scrolling

### Visibility

1. **Use visibility conditions** - Hide inactive hubs
2. **Use loading states** - Show loading indicators during data fetch
3. **Use active states** - Highlight active hub

### Widget Rendering

1. **Use view mode enforcement** - Ensure correct view mode
2. **Use contract data** - Fetch data from Velocity contracts
3. **Use progress tracking** - Track watch progress for in progress hubs

### Performance

1. **Defer loading** - Load widgets only when needed
2. **Cache data** - Cache contract data to reduce API calls
3. **Batch requests** - Batch contract requests when possible

---

## 11. HomeSwitcher Common Patterns

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

*See also: [Core Architecture](01_CORE_ARCHITECTURE.md), [Hubs](07_HUBS.md), [Variables & Includes](04_VARIABLES_INCLUDES.md)*