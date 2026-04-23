# Phase 3 & 4 Gap Analysis Report

**Date:** 2026-04-22  
**Scope:** Audit of Batch A removals and Batch B plumbing replacements post-rollback

---

## Executive Summary

The rollback has **NOT** cleanly removed legacy helper properties. Both Batch A (PVR/Weather removals) and Batch B (TMDbHelper plumbing replacements) have surviving references that must be re-implemented.

---

## Bucket A — Generator Sources (Batch A Removals: PVR, Weather)

### PVR References (SURVIVED — 11 instances)

| File | Lines | Context |
|------|-------|---------|
| `1080i/Dialog_DialogShortcuts.xml` | 736-796 | 7 instances of `<visible>System.HasPVRAddon + PVR.HasTVChannels</visible>` |
| `1080i/Includes_Home.xml` | 120, 428, 493 | HomeSwitcher PVR toggle enable/visibility conditions |

**Action Required:** Remove `PVR.HasTVChannels` references and replace with Velocity-native alternatives (e.g., `System.HasAddon(plugin.video.velocity2)` + live TV content detection).

---

### Weather References (SURVIVED — 6 instances)

| File | Lines | Context |
|------|-------|---------|
| `1080i/Dialog_DialogWeather.xml` | 25 | `<param name="label">$INFO[Weather.Location]</param>` |
| `1080i/MyWeather.xml` | 16, 104 | Weather.LocationNext onclick and label display |
| `1080i/Includes_Weather.xml` | 118 | `<property name="CustomInfo02">$INFO[Weather.Location]</property>` |
| `1080i/Custom_1109_Settings.xml` | 14, 69 | Weather.LocationNext and label display |

**Action Required:** Remove `Weather.Location` references and replace with Velocity-native weather integration (e.g., `plugin://plugin.video.velocity2/?action=weather`).

---

## Bucket B — Base Screens (Batch B Plumbing: TMDbHelper Properties)

### Includes_Paths.xml (SURVIVED — ~100+ references)

**Categories of surviving properties:**

| Property Pattern | Count | Purpose |
|------------------|-------|---------|
| `TMDbHelper.ListItem.base_*` | ~15 | Context menu base labels, plot, title, tvshowtitle |
| `TMDbHelper.ListItem.Monitor.*` | ~10 | Monitor TMDb_ID, TMDb_Type, Season, Episode |
| `TMDbHelper.Player.*` | ~8 | Player TMDb_ID, TVShow TMDb_ID, CropImage, ClearArt, Status |
| `TMDbHelper.WidgetContainer` | ~6 | Spotlight widget container management |
| `TMDbHelper.UserDiscover.*` | ~2 | Search user discover folderpath |
| `TMDbHelper.Instance` / `TMDbHelper.Position` | ~2 | Instance tracking |

**Action Required:** Replace all `TMDbHelper.ListItem.*` properties with Velocity's native `ListItem.Property(tmdb_*)` and `Window(Home).Property(Velocity.ListItem.*)` properties.

---

### Includes_Overlay.xml (SURVIVED — ~20 references)

**Surviving properties:**
- `TMDbHelper.WidgetContainer` — 16 references (all home windows: 10000-11109, videos, music, pictures, programs, games, tvchannels, tvsearch, tvguide, tvrecordings, tvtimers)
- `TMDbHelper.ListItem.base_*` — 2 references (title, year)
- `TMDbHelper.ListItem.Monitor.*` — 1 reference (TMDb_ID, TMDb_Type, Season, Episode)
- `TMDbHelper.Instance` / `TMDbHelper.Position` — 1 reference

**Action Required:** Replace WidgetContainer tracking with Velocity's native window property system (`Window(Home).Property(Velocity.WidgetContainer.*)`).

---

### Includes_Hubs.xml (SURVIVED — ~15 references)

**Surviving properties:**
- `TMDbHelper.WidgetContainer` — 10+ references (spotlight target setup and WidgetContainer value checks)

**Action Required:** Replace with Velocity-native spotlight container properties.

---

### Includes_Images.xml (SURVIVED — ~30 references)

**Surviving properties:**
- `TMDbHelper.ListITem.CropImage` / `ListITem.Current.CropImage` — 3 references
- `TMDbHelper.ListItem.Base_Icon` / `Base_Poster` — 2 references
- `TMDbHelper.Player.ClearArt` — 1 reference
- `TMDbHelper.Player.Status` — 8 references (Returning Series, Post Production, Canceled, Ended, Released, In Production, Planned)
- `TMDbHelper.ListItem.Status` — 8 references
- `TMDbHelper.SimpleBackground.BlurImage` — 2 references
- `TMDbHelper.ListItem.Current.BlurImage` — 2 references
- `TMDbHelper.WidgetContainer` — 1 reference (value 301)

**Action Required:** Replace with Velocity-native image properties (`ListItem.Property(tmdb_cropimage)`, `Velocity.Player.Status`, etc.).

---

### Includes_OSD.xml (SURVIVED — 2 references)

**Surviving properties:**
- `TMDbHelper.Player.CropImage` — 2 references

**Action Required:** Replace with Velocity-native player property.

---

### DialogVideoInfo.xml (SURVIVED — 5 references)

**Surviving properties:**
- `TMDbHelper.EnableExtendedProperties` — 1 reference
- `TMDbHelper.IsData` — 4 references

**Action Required:** Replace with Velocity-native expressions.

---

### DialogPVRGuideSearch.xml, Custom_1180_Dialog_Bumper.xml, Custom_1123_Dialog_Trailer.xml, Custom_1113_Dialog_Plot.xml, Custom_1114_Dialog_CustomPlot.xml, Custom_1160_Dialog_Favourites.xml, script-wikipedia.xml (SURVIVED — 4 references each)

**Surviving properties:**
- `TMDbHelper.ContextMenu` — 1 reference each (onload SetProperty)

**Action Required:** Replace with Velocity-native context menu setup.

---

### Includes_Hubs.xml, Includes_Views_Combined.xml, Includes_Views_List.xml (SURVIVED — 10+ references)

**Surviving properties:**
- `TMDbHelper.WidgetContainer` — 10+ references (focus/setproperty/clearproperty)

**Action Required:** Replace with Velocity-native container management.

---

### Custom_1140_OSD_Playlist.xml (SURVIVED — 3 references)

**Surviving properties:**
- `TMDbHelper.WidgetContainer` — 2 references (onfocus/setproperty, onunfocus/clearproperty)
- `TMDbHelper.ListItem.Plot` — 1 reference

**Action Required:** Replace with Velocity-native properties.

---

### Custom_1141_OSD_Cast.xml (SURVIVED — 5 references)

**Surviving properties:**
- `TMDbHelper.WidgetContainer` — 2 references
- `TMDbHelper.ListItem.Plot` — 1 reference

**Action Required:** Replace with Velocity-native properties.

---

### Custom_1105_Search.xml (SURVIVED — 3 references)

**Surviving properties:**
- `TMDbHelper.UserDiscover.FolderPath` — 2 references (onload SetProperty)
- `TMDbHelper.UserDiscover.FolderPath.Name` — 1 reference

**Action Required:** Replace with Velocity-native search properties.

---

### Includes_Overlay.xml (SURVIVED — 1 reference)

**Surviving properties:**
- `TMDbHelper.EnableExtendedProperties` — 1 reference (onload SetProperty)

**Action Required:** Replace with Velocity-native extended properties.

---

## Summary Table

| Category | Count | Status |
|----------|-------|--------|
| PVR references | 11 | SURVIVED |
| Weather references | 6 | SURVIVED |
| TMDbHelper.ListItem.* | ~50+ | SURVIVED |
| TMDbHelper.Player.* | ~15+ | SURVIVED |
| TMDbHelper.WidgetContainer | ~30+ | SURVIVED |
| TMDbHelper.ContextMenu | ~7 | SURVIVED |
| TMDbHelper.IsData / EnableExtendedProperties | ~7 | SURVIVED |
| TMDbHelper.UserDiscover.* | ~3 | SURVIVED |

**Total surviving references: 120+**

---

## Recommended Next Steps

1. **Create a Velocity-native property mapping document** — Map each TMDbHelper property to its Velocity equivalent
2. **Batch A cleanup first** — Remove PVR and Weather references (lower risk, isolated to Home.xml and shortcut dialogs)
3. **Batch B plumbing migration** — Systematically replace TMDbHelper properties in Includes_Paths.xml and Includes_Overlay.xml (highest impact, requires careful testing)
4. **Create a regression test suite** — Verify browse-to-play journey, context menu, spotlight widgets, and OSD cast info after each migration batch