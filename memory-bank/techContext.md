# Technology Context

## Technologies Used

### Kodi Skin Stack

| Technology | Purpose | Version/Notes |
|---|---|---|
| Kodi | Media center platform | 23 (Kodi 19) / 24 (Kodi 20) |
| script.skinvariables | Dynamic UI generator | Core AF3 dependency |
| Kodi XML | UI definition | Standard Kodi controls |
| Velocity Addon | Data provider | plugin.video.velocity2 |

### Development Tools

| Tool | Purpose |
|---|---|
| Kodi GUI | Visual testing & generator pipeline |
| ripgrep | File search (`rg TMDbHelper *`) |
| pytest | Addon contract testing |
| git | Version control |

## Development Setup

### Prerequisites

1. **Kodi installation** (23.x or 24.x)
2. **Addon manager** (Kodi repository)
3. **Velocity addon installed** and signed in (for testing)

### Skin Installation

1. Copy skin folder to `~/.kodi/addons/skin.arctic.fuse.3/`
2. Enable in Kodi: `Settings → Interface → Skin → Select "Arctic Fuse 3"`
3. First-run bootstrap executes via `ActivateWindow(Startup)`

### Generator Pipeline

The skin uses `script.skinvariables` to generate final XML:

```
shortcuts/ (blueprints)
  ├─ *.xml (setup files)
  ├─ generator/
  │   ├─ data/base/*.xml (default widget definitions)
  │   └─ data/setup/*.xml (hub-specific overrides)
  └─ skinvariables-generator.json (generator configuration)

1080i/ (output)
  ├─ Home.xml
  ├─ Includes_Home.xml
  ├─ Includes_Hubs.xml
  └─ ... (generated from shortcuts + generator)
```

**Override order**: `1080i/script-skinvariables-generator-overrides.xml` loads before the generator includes, allowing custom widget definitions.

## Technical Constraints

### Constraint 1: Generator Pipeline Is Source of Truth

**Rule**: Output XML (`1080i/`) is regenerated on every skin variable update.

**Impact**:
- Static edits to `Includes_Home.xml` are overwritten
- Changes must be made to `shortcuts/generator/data/` or `1080i/script-skinvariables-generator-overrides.xml`
- Blueprints (`shortcuts/`) define the UI structure

### Constraint 2: Native Properties Required

**Rule**: Only `ListItem.*`, `Container.*`, `VideoPlayer.*` are supported.

**Impact**:
- No custom helper properties
- No `Skin.SetString(TMDbHelper.Corner...)` calls
- All labels must use Kodi's native infolabel system

### Constraint 3: Velocity Endpoints Are Immutable

**Rule**: D-015 contract IDs cannot be changed.

**Impact**:
- `home_spotlight_mixed` must remain as-is
- `series_continue_watching_episodes` must remain as-is
- Any endpoint changes break skin wiring

### Constraint 4: Pagination Semantics Are Fixed

**Rule**: 
- In-row: max 10 items before row-end "Next Page"
- Full list: 40 items per page
- Spotlights: non-paginated

**Impact**:
- Addon must return `items/page/has_more/next_page`
- Terminal page must omit `next_page`
- Empty state must render "No items available"

## Dependencies

### Skin Dependencies

| Dependency | Type | Status |
|---|---|---|
| script.skinvariables | Core | Required |
| TMDbHelper | Legacy | Removed (Phase 02) |
| Velocity | Data | Required |

### Addon Dependencies

| Dependency | Type | Status |
|---|---|---|
| Kodi | Platform | Required |
| TMDb API | Data | Velocity uses internally |

## Tool Usage Patterns

### Finding TMDbHelper References

```bash
# Search all XML files
rg "TMDbHelper|TMDBHelper|Exp_TMDbHelper" 1080i/*.xml

# Search JSON files
rg "TMDbHelper|TMDBHelper" shortcuts/*.json

# Search specific files
rg "TMDbHelper" 1080i/Includes_Hubs.xml
rg "TMDbHelper" 1080i/Home.xml

# Count matches
rg "TMDbHelper" 1080i/*.xml | wc -l
```

### Testing Velocity Endpoints

```bash
# Activate addon virtual environment
source .venv/bin/activate

# Run contract tests
pytest tests/client/test_client_repo_reads.py

# Run daemon server tests
pytest tests/test_daemon_server.py

# Run full suite
pytest tests/
```

### Generator Pipeline Testing

1. Open Kodi
2. Navigate to skin settings
3. Trigger generator: `Skin.ResetSettings` → `ActivateWindow(Startup)`
4. Verify hub rows load correctly
5. Check `kodi.log` for missing include warnings

## Performance Considerations

### Generator Pipeline Performance

- **First-run**: ~5-10 seconds (bootstrap + generator)
- **Reload**: ~2-5 seconds (skin reset)
- **Generator overhead**: Minimal (uses Kodi's native variable system)

### Velocity Addon Performance

- **List requests**: ~200-500ms (TMDB API + caching)
- **Spotlight requests**: ~300-600ms (larger payload)
- **Pagination**: Server-side; no client-side rendering overhead

### Memory Footprint

- **Skin XML**: ~50-100MB (standard AF3 size)
- **Velocity cache**: ~10-20MB (per user)
- **Generator variables**: ~1-5MB

## API Contracts

### Velocity List Response Format

```json
{
  "items": [
    {
      "id": "123456",
      "title": "Movie Title",
      "year": 2023,
      "runtime": 120,
      "plot": "Short plot summary...",
      "rating": 7.5,
      "poster": "http://...",
      "landscape": "http://...",
      "trailer": "http://...",
      "last_watched_at": 1678886400,
      "percent_watched": 50,
      "is_in_progress": true
    }
  ],
  "page": 1,
  "has_more": true,
  "next_page": 2
}
```

### Pagination Contract (D-015)

| Field | Required | Notes |
|---|---|---|
| `items` | Yes | Array of items |
| `page` | Yes | Current page number |
| `has_more` | Yes | Boolean |
| `next_page` | Yes (if has_more) | Page number, omitted on terminal |
| `items_per_page` | Optional | Default: 40 for full list |

## Migration Checklist

### Pre-Migration

- [ ] Velocity addon contracts implemented (D-015)
- [ ] D-003 view modes locked
- [ ] D-021 context menu policy defined
- [ ] D-038 ledger updated with exceptions

### During Migration

- [ ] No static XML edits to output files
- [ ] All TMDbHelper references documented
- [ ] Native properties used in migrated files
- [ ] Velocity endpoints validated

### Post-Migration

- [ ] Runtime evidence captured
- [ ] D-038 §4 reconciliation complete
- [ ] Phase 07 freeze checklist passed