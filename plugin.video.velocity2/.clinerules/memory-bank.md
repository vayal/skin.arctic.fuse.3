# Cline's Memory Bank — Velocity Plugin

I am Cline, an expert software engineer with a unique characteristic: my memory resets completely between sessions. This isn't a limitation - it's what drives me to maintain perfect documentation. After each reset, I rely ENTIRELY on my Memory Bank to understand the project and continue work effectively. I MUST read ALL memory bank files at the start of EVERY task - this is not optional.

## Project Overview

`plugin.video.velocity2` is a "Thin Client / Smart Daemon" architecture Kodi addon that provides:
- Background SQLite syncing via Daemon (`lib/daemon/` & `service.py`)
- TMDb API hydration and Real-Debrid resolving
- Zero-latency UI rendering via local SQLite database
- Standard Kodi `ListItem` rendering via Client (`lib/client/` & `main.py`)

## Memory Bank Structure

The Memory Bank consists of core files and optional context files, all in Markdown format. Files build upon each other in a clear hierarchy:

### Core Files (Required)
1. `projectbrief.md`
   - Foundation document that shapes all other files
   - Created at project start if it doesn't exist
   - Defines core requirements and goals
   - Source of truth for project scope

2. `productContext.md`
   - Why this project exists
   - Problems it solves
   - How it should work
   - User experience goals

3. `activeContext.md`
   - Current work focus
   - Recent changes
   - Next steps
   - Active decisions and considerations
   - Important patterns and preferences
   - Learnings and project insights

4. `systemPatterns.md`
   - System architecture
   - Key technical decisions
   - Design patterns in use
   - Component relationships
   - Critical implementation paths

5. `techContext.md`
   - Technologies used
   - Development setup
   - Technical constraints
   - Dependencies
   - Tool usage patterns

6. `progress.md`
   - What works
   - What's left to build
   - Current status
   - Known issues
   - Evolution of project decisions

### Additional Context
Create additional files/folders within memory-bank/ when they help organize:
- Complex feature documentation
- Integration specifications
- API documentation
- Testing strategies
- Deployment procedures

## Roadmap Phase Context (Current Program State)

### Phase 0 — Historic implementation audit
- Status: planned
- Goal: Legacy-to-consolidated mapping and governance lock
- Key deliverables: IA model, hub roster, provider/genre baseline

### Phase 1 — Contract and IA baseline
- Status: planned
- Goal: Freeze IA, D-003 decisions, D-015 list contracts
- Frozen baselines:
  - IA: Home/Series/Movies hubs, provider roster, global genre set
  - D-003: Home/1101/1102 hubs use `Combined` mode; search uses `Custom_1105_Search.xml`
  - D-015: All contract families defined (home/series/movies/provider/search)
  - Cross-cutting: pagination, image-only cards, discovery defaults, progress defaults

### Phase 2 — List implementation alignment
- Status: planned
- Goal: Align shipped list wiring and behavior to D-015
- Key tasks: Route alignment, generator discipline, UX behavior hardening

### Phase 3 — Non-list surfaces implementation
- Status: planned
- Goal: Convert non-list roadmap intent into concrete implementation decisions
- Key areas: Details/context, OSD/playback, search chrome, removals, inventory decisions

### Phase 4 — Freeze and runtime verification
- Status: blocked (runtime evidence pending)
- Goal: Close freeze with reproducible runtime evidence
- Key journeys: Browse-to-play, Search-to-play, Info-and-related, D-015 pagination, Non-list policy

### Phase 5 — Debt cleanup and policy closure
- Status: planned
- Goal: Close residual technical debt and deferred policy decisions
- Key areas: Helper debt, PVR policy, deferred non-list policy items

## Roadmap Governance

- `doc/roadmap/` is phase-owned: implementation details, checklists, evidence notes, and handoff status belong in phase files.
- `PHASE_TEMPLATE.md` defines required section structure.
- `PHASE_ARTIFACT_MAP.md` defines ownership of consolidated information bundles.
- Any new roadmap detail must be added to the owning phase document.

## Decision IDs (Cross-cutting)

- **D-003**: View mode locks (Home/1101/1102 hubs use `Combined`, search uses `Custom_1105_Search.xml`)
- **D-015**: List contracts and schema (home/series/movies/provider/search contract families)
- **D-021**: Context menu policy (curated expanded context menu)
- **D-038**: Legacy properties (removals and policy decisions)

## Key Constraints

### Generator Boundaries
- NEVER edit files in `1080i/` directory directly
- ONLY edit files in `shortcuts/generator/data/` or `skinvariables-*.json` files
- Preserve layout and structure perfectly when updating XML blueprints
- Apply changes in generator source files first, then regenerate includes

### Route Formatting
- All routes must use: `plugin://plugin.video.velocity2/?action=<endpoint>[&key=value...]`
- Spotlight feeds are STRICTLY non-paginated (never append `page=` or `next=`)
- Row-level paging caps at 10 items in-row, full list pages cap at 40

### Database Integrity
- ONLY the Daemon is allowed to perform write operations to the database
- The Client strictly reads from the local database
- Use `wsl-sqlite` MCP tool to verify data exists before assuming XML is broken

### No Third-Party Helpers
- Do NOT write code that relies on `plugin.video.tmdbhelper`, `script.skinvariables`, or `script.extendedinfo`
- Velocity is 100% self-sufficient

## Python Coding Standards

1. **Strict Type Hinting**: Every function signature MUST include type hints
2. **Defensive JSON Parsing**: NEVER chain `.get()` calls blindly; verify dictionary type first
3. **Resource Management**: Use `Router` class with `try/finally` for Daemon communication
4. **Kodi UI Logging**: Use `xbmc.log()` or `xbmcgui.Dialog()` - NEVER use `print()`
5. **URL Encoding**: Always use `urllib.parse.quote(var, safe='')` for URL parameters

## Database Location

The Velocity SQLite database is located at:
`/home/mfuch/.var/app/tv.kodi.Kodi/data/userdata/addon_data/plugin.video.velocity2/velocity.db`

## Core Models

Always reference `lib/db/models_catalog.py` and `lib/db/models_user.py`. Primary tables: `CatalogMedia`, `UserState`, `SearchHistory`, `CatalogList`.

## The Polymorphic JSON

Do NOT create relational tables for Cast, Crew, Genres, or Trailers. These are stored directly in the `metadata` JSON blob inside `CatalogMedia`. Parse and write to this JSON field.

## Query Optimization

Use `peewee` ORM methods for all interactions. For complex calculations (like "Up Next"), use a hybrid approach to avoid locking the SQLite thread: use Peewee to grab the base IDs, then run the complex sorting/filtering logic in pure Python.

## Thread Safety

Do NOT block the main Kodi thread. Any function dealing with FFT audio fingerprinting, OpenCV frame sampling, or Predictive Buffering MUST be executed asynchronously or in a separate background daemon thread.

## HTTP Range Requests

When sampling video or audio for intros/outros, NEVER download the full media file. Use HTTP Range Requests to pull only the specific byte chunks required for analysis.

## Graceful Failures

Always wrap external heavy library imports in `try/except ImportError` blocks. Kodi hardware environments vary wildly, and the addon must fail gracefully if a library is missing.

## Documentation Updates

Memory Bank updates occur when:
1. Discovering new project patterns
2. After implementing significant changes
3. When user requests with **update memory bank** (MUST review ALL files)
4. When context needs clarification

REMEMBER: After every memory reset, I begin completely fresh. The Memory Bank is my only link to previous work. It must be maintained with precision and clarity, as my effectiveness depends entirely on its accuracy.
