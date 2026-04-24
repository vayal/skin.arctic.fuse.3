# Tech Context — Velocity Plugin

## Technologies Used

### Core Stack
- **Language**: Python 3 (strict type hints, defensive programming)
- **ORM**: Peewee (SQLite database access)
- **HTTP**: Requests (Daemon API communication)
- **Kodi API**: xbmc, xbmcgui (UI rendering, logging)

### Heavy Computation Libraries
- **scipy**: FFT audio fingerprinting
- **numpy**: Numerical computations
- **cv2 (OpenCV)**: Frame sampling
- **ffmpeg**: Media analysis

### Database
- **SQLite**: Local zero-latency storage
- **Location**: `/home/mfuch/.var/app/tv.kodi.Kodi/data/userdata/addon_data/plugin.video.velocity2/velocity.db`

### Skin Integration
- **Arctic Fuse 3**: Base skin fork
- **Generator**: `shortcuts/generator/data/` for skin updates
- **Skinvariables**: `skinvariables-startup.json` for shortcuts

## Development Setup

### Kodi Environment
- **Platform**: Flatpak sandbox (`tv.kodi.Kodi`)
- **Database path**: `userdata/addon_data/plugin.video.velocity2/velocity.db`
- **Log path**: `temp/kodi.log`

### Tools
- **Git**: Version control for skin and addon
- **wsl-sqlite**: MCP tool for database queries
- **grep**: Helper debt auditing
- **execute_command**: CLI operations

## Technical Constraints

### SQLite Thread Safety
- Complex calculations must use hybrid approach (Peewee + Python)
- Avoid locking SQLite thread with complex queries
- Use hybrid approach for "Up Next" and similar computations

### HTTP Range Requests
- NEVER download full media files for analysis
- Use HTTP Range Requests for byte chunks (e.g., first 50MB for intros)

### Graceful Failures
- Wrap heavy library imports in `try/except ImportError`
- Kodi hardware varies; addon must fail gracefully
- Log failures via `xbmc.log()`

### Daemon Port
- Default: `65432`
- Configurable via `daemon_port` setting

### Database Models
- `lib/db/models_catalog.py`: Media metadata
- `lib/db/models_user.py`: User state
- Primary tables: `CatalogMedia`, `UserState`, `SearchHistory`, `CatalogList`

## Dependency Management

### Required Dependencies
- Python 3.x
- Peewee ORM
- Requests HTTP library
- Kodi xbmc/xbmcgui

### Optional Dependencies (Heavy Computation)
- scipy (FFT)
- numpy (numerical)
- cv2/OpenCV (frame sampling)
- ffmpeg (media analysis)

### Third-Party Helpers (NOT Used)
- `plugin.video.tmdbhelper`: NOT used (self-sufficient)
- `script.skinvariables`: NOT used (generator-driven)
- `script.extendedinfo`: NOT used

## Tool Usage Patterns

### Database Queries
- Use `wsl-sqlite` MCP tool for SELECT queries
- Verify data exists before assuming XML broken
- Reference `catalog_list` and `list_item` tables

### Daemon Communication
- Use `Router` class with `try/finally`
- Prevent socket leaks
- Daemon port configurable via settings

### Logging
- Backend: `xbmc.log(message, xbmc.LOGINFO|WARNING)`
- User errors: `xbmcgui.Dialog().ok('Velocity', str(e))`
- Silent success: `xbmcgui.Dialog().notification()`
- NEVER use `print()` (fails in Kodi)

### URL Encoding
- Always use `urllib.parse.quote(var, safe='')`
- Pass strings (queries, IDs) into URLs safely
