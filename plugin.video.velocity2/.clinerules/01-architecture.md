# Prime Directive: Separation of Concerns

Velocity is a "Thin Client / Smart Daemon" architecture. It is NOT a standard Kodi addon.

## Roadmap Phase Alignment

### Phase 1 Baseline Lock
- Architecture pattern frozen: Daemon handles all DB writes, Client only reads
- Database models locked in Phase 1 (CatalogMedia, UserState, SearchHistory, CatalogList)
- Polymorphic JSON schema for Cast/Crew/Genres/Trailers in metadata field

### Phase 2 List Alignment
- Daemon handles all list contract queries for D-015 families
- Client renders standard ListItem objects per contract schema
- No direct DB writes in client code paths

### Phase 3 Non-List Surfaces
- Details/context: Daemon resolves full details, Client renders dialogs
- OSD/playback: Daemon handles overlay transitions, Client renders controls
- Search chrome: Daemon executes search queries, Client renders results

### Phase 4 Freeze Verification
- Runtime evidence captures Daemon response times and payload shapes
- Client focus/navigation verified against Daemon-delivered ListItem objects

### Phase 5 Debt Closure
- Remove undeclared TMDbHelper dependencies from client code paths
- Keep only explicit D-038 exceptions with owner and rationale
- Reconcile remaining helper hits into D-038 exceptions ledger

## Core Models

Always reference `lib/db/models_catalog.py` and `lib/db/models_user.py`. Primary tables: `CatalogMedia`, `UserState`, `SearchHistory`, `CatalogList`.

## The Polymorphic JSON

Do NOT create relational tables for Cast, Crew, Genres, or Trailers. These are stored directly in the `metadata` JSON blob inside `CatalogMedia`. Parse and write to this JSON field.

## Query Optimization

Use `peewee` ORM methods for all interactions. For complex calculations (like "Up Next"), use a hybrid approach to avoid locking the SQLite thread: use Peewee to grab the base IDs, then run the complex sorting/filtering logic in pure Python.

## Database Location

The Velocity SQLite database is located at:
`/home/mfuch/.var/app/tv.kodi.Kodi/data/userdata/addon_data/plugin.video.velocity2/velocity.db`

## WSL SQLite Tool

If you are asked to debug missing UI items, use the `wsl-sqlite` MCP tool to run `SELECT` queries on the `catalog_list` and `list_item` tables to verify the data exists before assuming the XML is broken.
