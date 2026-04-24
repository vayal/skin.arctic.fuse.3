# Product Context — Velocity Plugin

## Why This Project Exists

`plugin.video.velocity2` exists to provide a **self-sufficient, zero-latency** Kodi video addon that:
- Hydrates media metadata from TMDb API in background
- Resolves Real-Debrid URLs for playback
- Renders UI from local SQLite database (no live API calls)
- Integrates seamlessly with `skin.velocity.af3` via generator pipeline

## Problems It Solves

1. **Latency**: Standard addons make live API calls per item; Velocity pre-hydrates everything
2. **Dependency hell**: Eliminates reliance on `plugin.video.tmdbhelper` and other third-party helpers
3. **Performance**: Local SQLite enables instant UI rendering regardless of network conditions
4. **Maintainability**: Single codebase for skin and addon, coordinated via generator

## How It Should Work

### User Journey
1. User browses Home/Series/Movies hubs in skin
2. Skin requests list data via `plugin://plugin.video.velocity2/?action=list&list_id=...`
3. Daemon queries local SQLite (pre-populated) and returns `ListItem` objects
4. Kodi renders items instantly from cached metadata
5. User clicks item → Daemon resolves Real-Debrid URL → Playback starts

### Background Operations
- Daemon runs continuously, syncing TMDb data to SQLite
- Real-Debrid URLs are resolved and cached
- User state (watch progress, favorites) persists in SQLite
- Heavy computations (FFT, OpenCV) run in background threads

## User Experience Goals

- **Instant navigation**: No loading spinners for list browsing
- **Consistent behavior**: Same contract families across all hubs
- **Clean UI**: Image-only cards, lean details, curated context menu
- **Reliable playback**: Real-Debrid URLs always resolve
- **Self-contained**: No external dependencies required

## Key Differentiators

| Feature | Standard Addons | Velocity |
|---------|-----------------|-----------|
| Metadata source | Live API calls | Local SQLite |
| Latency | Network-dependent | Instant |
| Dependencies | TMDbHelper, etc. | None (self-sufficient) |
| Architecture | Standard addon | Thin Client / Smart Daemon |
| Generator-driven | No | Yes (skin integration) |

## Roadmap Alignment

All product decisions align with the 5-phase roadmap:
- Phase 1: Freeze baselines (IA, D-003, D-015)
- Phase 2: Align list behavior to contracts
- Phase 3: Implement non-list surfaces
- Phase 4: Runtime verification in Kodi
- Phase 5: Close debt and policy decisions
