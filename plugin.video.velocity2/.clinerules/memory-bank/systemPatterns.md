# System Patterns — Velocity Plugin

## Architecture Overview

### Thin Client / Smart Daemon Pattern

```
┌─────────────────────────────────────────────────────────────┐
│                      Kodi UI Layer                            │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │                    Client (main.py)                      │ │
│  │  - Reads from local SQLite via Daemon API                │ │
│  │  - Renders standard Kodi ListItem objects                │ │
│  │  - NO direct DB writes, NO web requests, NO scraping     │ │
│  └────────────────────────────────────────────────────────┘ │
│                              ▲                                 │
│                              │ Daemon API (HTTP)               │
│                              ▼                                 │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │                   Daemon (service.py)                    │ │
│  │  - Background SQLite syncing                              │ │
│  │  - TMDb API hydration                                     │ │
│  │  - Real-Debrid resolving                                  │ │
│  │  - Heavy computations (FFT, OpenCV, ffmpeg)              │ │
│  │  - ONLY component allowed to write to DB                  │ │
│  └─────────────────────────────────────────────────────────┘ │
│                              ▲                                 │
│                              │ SQLite                          │
│                              ▼                                 │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │              velocity.db (local SQLite)                  │ │
│  │  - CatalogMedia, UserState, SearchHistory, CatalogList   │ │
│  │  - Polymorphic JSON for Cast/Crew/Genres/Trailers        │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Component Relationships

### Daemon Responsibilities
- Background SQLite syncing (TMDb → local DB)
- TMDb API hydration (metadata enrichment)
- Real-Debrid URL resolution
- Heavy computations (FFT audio fingerprinting, OpenCV frame sampling)
- Predictive buffering
- ONLY performs `INSERT`, `UPDATE`, `DELETE` operations

### Client Responsibilities
- Queries Daemon API via HTTP
- Renders standard Kodi `ListItem` objects
- Handles UI navigation and focus
- NO direct database access
- NO web requests or scraping

### Database Schema
- `CatalogMedia`: Media metadata (polymorphic JSON for Cast/Crew/Genres/Trailers)
- `UserState`: Watch progress, favorites, settings
- `SearchHistory`: User search queries
- `CatalogList`: List contract instances

## Critical Implementation Paths

### List Request Flow
1. Skin requests list via `plugin://plugin.video.velocity2/?action=list&list_id=...`
2. Client instantiates `Router`, queries Daemon API
3. Daemon queries local SQLite (pre-populated)
4. Daemon returns `ListItem` objects
5. Client closes Router in `finally` block
6. Kodi renders items from cached metadata

### Playback Flow
1. User clicks item → Client resolves `action=play&id=...`
2. Daemon queries `CatalogMedia` for media ID
3. Daemon resolves Real-Debrid URL
4. Daemon returns playable URL
5. Kodi plays URL

### Sync Flow
1. Daemon runs continuously in background
2. Queries TMDb API for new/updated content
3. Updates local SQLite via Peewee ORM
4. Handles failures gracefully (retry, log, skip)

## Design Patterns

### Router Pattern (Client → Daemon)
```python
router = Router(port=int(cfg.get_setting('daemon_port', '65432')))
try:
    data = router.get_json('/api/endpoint')
finally:
    router.close()  # Prevent socket leaks
```

### Hybrid Calculation Pattern (Up Next)
```python
# Use Peewee to grab base IDs, then sort/filter in Python
ids = CatalogMedia.select(CatalogMedia.id).where(...)
# Complex sorting/filtering in pure Python to avoid SQLite thread locking
```

### Polymorphic JSON Pattern
```python
# Cast/Crew/Genres/Trailers stored in metadata JSON blob
# NOT relational tables
metadata = {
    'title': '...',
    'cast': [...],  # JSON array
    'crew': [...],  # JSON array
    'genres': [...],  # JSON array
    'trailers': [...]  # JSON array
}
```

## Component Boundaries

### NEVER Cross These Boundaries
- Client → Direct DB write (violation)
- Client → Web request (violation)
- Client → Scraping function (violation)
- Daemon → Blocking main Kodi thread (violation)

### ALWAYS Enforce These Boundaries
- All DB writes → Daemon only
- All heavy computation → Daemon threads
- All HTTP requests → Daemon only
- Client → Daemon API only (HTTP)
