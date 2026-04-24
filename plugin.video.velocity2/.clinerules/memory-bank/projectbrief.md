# Project Brief — Velocity Plugin

## Core Identity

`plugin.video.velocity2` is a **Thin Client / Smart Daemon** architecture Kodi addon that provides:
- Background SQLite syncing via Daemon (`lib/daemon/` & `service.py`)
- TMDb API hydration and Real-Debrid resolving
- Zero-latency UI rendering via local SQLite database
- Standard Kodi `ListItem` rendering via Client (`lib/client/` & `main.py`)

## Primary Goals

1. **Zero-latency UI**: All UI rendering relies on local SQLite database, not live API calls
2. **Self-sufficient**: No third-party helpers (`plugin.video.tmdbhelper`, `script.skinvariables`)
3. **Daemon-first**: All DB writes happen in Daemon; Client only reads
4. **Velocity-only**: All routes use `plugin://plugin.video.velocity2/?action=...`

## Scope Boundaries

### In Scope
- Daemon background services (syncing, TMDb hydration, Real-Debrid resolving)
- Client UI rendering (standard Kodi ListItem objects)
- Local SQLite database operations via Peewee ORM
- Heavy computation (FFT, OpenCV, ffmpeg) in background threads
- Generator-driven skin integration for `skin.velocity.af3`

### Out of Scope
- Web requests or scraping in client code paths
- Direct database writes in client code
- Standard Kodi addon patterns (not a "normal" addon)
- Third-party helper dependencies (except D-038 exceptions)

## Success Criteria

- [ ] All UI renders from local SQLite (zero API latency)
- [ ] No undeclared TMDbHelper dependencies remain
- [ ] Daemon handles all DB writes; Client only reads
- [ ] All routes use Velocity `plugin://` format
- [ ] Heavy computation runs asynchronously
- [ ] Generator discipline enforced (source first, regenerate, commit together)

## Phase Context

See `ROADMAP_MASTER.md` and `doc/roadmap/` for current program status:
- Phase 0: Historic implementation audit (planned)
- Phase 1: Contract and IA baseline (planned)
- Phase 2: List implementation alignment (planned)
- Phase 3: Non-list surfaces implementation (planned)
- Phase 4: Freeze and runtime verification (blocked)
- Phase 5: Debt cleanup and policy closure (planned)

## Key Constraints

- **Generator-driven**: NEVER edit `1080i/` directly; use `shortcuts/generator/data/`
- **Route format**: `plugin://plugin.video.velocity2/?action=<endpoint>[&key=value...]`
- **Pagination**: Spotlight non-paginated; row cap 10, full list 40/page
- **No helpers**: Velocity is 100% self-sufficient
- **Thread safety**: No blocking main Kodi thread

## Database

Location: `/home/mfuch/.var/app/tv.kodi.Kodi/data/userdata/addon_data/plugin.video.velocity2/velocity.db`

Core models: `CatalogMedia`, `UserState`, `SearchHistory`, `CatalogList`

Polymorphic JSON: Cast/Crew/Genres/Trailers stored in `metadata` field, not relational tables.
