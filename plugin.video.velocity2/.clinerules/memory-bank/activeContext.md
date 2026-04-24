# Active Context — Velocity Plugin

## Current Work Focus

### Immediate Priorities
- **Phase 4 blocked**: Awaiting runtime evidence in Kodi for freeze gate
- **Phase 2/3 preparation**: List alignment and non-list surface decisions pending
- **Phase 5 preparation**: Helper debt and PVR policy decisions queued

### Recent Changes
- Roadmap phases consolidated into `doc/roadmap/` directory
- Phase files follow `PHASE_TEMPLATE.md` structure
- All roadmap detail now phase-owned (no standalone target/status docs)

### Active Decisions
- **D-003**: View mode locks active (Home/1101/1102 = `Combined`, search = `Custom_1105_Search.xml`)
- **D-015**: All contract families defined and documented
- **D-021**: Context menu policy pending implementation
- **D-038**: Legacy properties ledger pending cleanup

### Next Steps
1. **Phase 0**: Complete historic implementation audit mapping
2. **Phase 1**: Freeze IA, D-003, D-015 baselines
3. **Phase 2**: Align list wiring to D-015 contracts
4. **Phase 3**: Resolve non-list surface decisions
5. **Phase 4**: Execute runtime verification in Kodi
6. **Phase 5**: Close debt and policy decisions

## Recent Learnings

### Generator Discipline
- Generator output can overwrite direct XML edits if source discipline is skipped
- Always apply changes in generator source files first
- Regenerate includes and verify output matches intended updates
- Commit source + generated output together to prevent drift

### Runtime Verification
- Static audits can mask runtime focus and navigation failures
- Weak evidence discipline creates retest loops and ambiguous freeze decisions
- Phase 4 requires reproducible runtime evidence, not just static checks

### Helper Debt
- Helper replacement can break UX when dependency boundaries are implicit
- PVR policy needs explicit product acceptance, not technical defaulting
- Post-freeze cleanups can regress runtime behavior without retesting

## Important Patterns

### Thin Client / Smart Daemon
- Daemon handles all DB writes, TMDb hydration, Real-Debrid resolving
- Client only reads from local SQLite and renders ListItem objects
- NEVER write web requests or direct DB writes in client code

### Generator Pipeline
- Source first → Regenerate → Verify → Commit together
- Never edit `1080i/` directly
- Use `shortcuts/generator/data/` and `skinvariables-*.json` only

### Route Formatting
- All routes: `plugin://plugin.video.velocity2/?action=<endpoint>[&key=value...]`
- Spotlight feeds: STRICTLY non-paginated (no `page=` or `next=`)
- Row paging: cap 10 items in-row with next-page flow
- Full lists: 40 items per page

### Database Integrity
- ONLY Daemon performs write operations
- Client strictly reads from local SQLite
- Use `wsl-sqlite` MCP tool to verify data exists before assuming XML broken

### Python Standards
- Strict type hints on all function signatures
- Defensive JSON parsing (verify dict type before `.get()`)
- Router class with `try/finally` for Daemon communication
- Use `xbmc.log()` and `xbmcgui.Dialog()` - NEVER `print()`

## Project Insights

### Architecture Trade-offs
- Local SQLite enables zero-latency UI but requires background sync discipline
- Daemon-first pattern centralizes DB writes but adds complexity
- Generator-driven skin integration reduces drift but requires strict source discipline

### Phase Dependencies
- Phase 1 must close before Phase 2/3 can execute
- Phase 4 is the only freeze-approval authority
- Phase 5 depends on freeze output and Phase 3 deferred items

### Evidence Discipline
- Runtime evidence required for freeze gate (Phase 4)
- Static audits insufficient for navigation/focus verification
- Every failure must have owner, remediation, and retest condition
