# Why This Skin Fork Exists

## Problem Statement

The original Arctic Fuse 3 skin relies heavily on `plugin.video.themoviedb.helper` addon for:
- Metadata fetching and display
- Row and widget data generation
- Progress tracking (watched status, continue watching)
- Context menu expansion
- OSD and playback overlays

This creates several issues:
1. **TMDbHelper is unmaintained** - slow updates, breaking changes
2. **Dual dependency complexity** - skin + addon both needing updates
3. **Data contract fragility** - skin changes break when addon schema changes
4. **No vendor control** - can't customize behavior to match product vision

## Solution: Velocity Addon

**Velocity** (`plugin.video.velocity2`) is a proprietary addon that:
- Provides stable, well-documented list contracts (D-015)
- Exposes native pagination semantics (`items/page/has_more/next_page`)
- Supplies progress fields natively (`last_watched_at`, `percent_watched`, etc.)
- Uses Kodi-native `ListItem` properties where possible
- Has a clear roadmap and active development

## How It Works Now

### Before (TMDbHelper Era)

```
User clicks row → Kodi calls TMDbHelper → TMDbHelper fetches from TMDB API
→ Returns data → Skin renders via helper properties
```

### After (Velocity Era)

```
User clicks row → Kodi calls Velocity → Velocity returns structured data
→ Skin renders via native Kodi properties (ListItem, Container)
→ Velocity handles pagination server-side
```

## User Experience Goals

1. **Seamless browsing** - Home, Series, Movies hubs with consistent spotlight + row patterns
2. **Provider mini-hubs** - Netflix, Disney+, Prime, Apple TV+, Hulu, Max, Paramount+, Peacock, BBC
3. **Smart progress tracking** - Continue watching, in-progress shows/movies, recently watched
4. **Genre navigation** - Fixed genre set (Action, Comedy, Drama, Thriller, Romance, Sci-Fi, Crime, Animation)
5. **Image-only cards** - No metadata clutter on row cards
6. **Non-paginated spotlights** - Hero surfaces never show "Next Page"

## Screen-by-Screen Contract

See [`doc/target/screen-by-screen-build-contract.md`](../doc/target/screen-by-screen-build-contract.md) for the complete surface-by-surface specification.

### Home Hub
- Spotlight: Mixed movies/series hero
- Rows: In-progress series (tabbed), In-progress movies (tabbed)

### Series Hub
- Spotlight: Trending show hero
- Rows: Continue watching episodes, In-progress shows, Global trending, Provider icons, Genre buttons

### Movies Hub
- Spotlight: Trending movie hero
- Rows: In-progress, Global trending, Provider icons, Genre buttons

### Provider Mini-Hubs
- Spotlight, Trending, Popular, Genre rows (up to 4)

## What Was Removed

Phase 04 removed:
- Expanded context menu items (D-021)
- OSD cast dialog
- PVR surfaces (Batches A)
- Wikipedia/crew selection flows
- Helper-only settings entry points
- Small plot dialog (1113)
- Shortcut editor from user-facing settings

## What Remains (Documented Exceptions)

See [`doc/reference/d038-legacy-property-ledger.md`](../doc/reference/d038-legacy-property-ledger.md) §4 for:
- Helper-named discover property key in search (keep-temporary)
- Writer/director crew strip bindings
- OSD crop image binding
- Background blur toggle
- Shortcut generator presets

## Future Considerations

- Phase 07 freeze will lock all remaining helper bindings
- Generator pipeline may need trimming of library DB tabs (videodb://, musicdb://)
- Full details screen is canonical info destination (no small info dialog UX)