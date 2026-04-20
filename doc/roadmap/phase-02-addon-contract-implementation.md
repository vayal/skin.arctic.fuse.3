# Phase 02 - Addon Contract Implementation

## Scope

Implement and validate addon list contracts defined in D-015 so skin migration can bind to stable outputs.

## Inputs and Prerequisite Checks

- [D-015 Addon Required Lists Contract](../d015-addon-required-lists-contract.md)
- [Screen-by-Screen Build Contract](../screen-by-screen-build-contract.md)
- [Skin Vision Blueprint](../skin-vision-blueprint-v0.md)
- [Inventory Journey: Browse to Play](../../inventory/journeys/browse-to-play.md)
- [Inventory Journey: Search to Play](../../inventory/journeys/search-to-play.md)
- [Traceability Matrix](./appendix-traceability-matrix.md)

Checks:

- [ ] Phase 01 accepted
- [ ] canonical route naming fixed
- [ ] provider slugs aligned to addon-native slugs

## File-Level Touch List

- addon repo contract/routing modules (external to this skin repo)
- optional docs updates:
  - `doc/roadmap/appendix-traceability-matrix.md`

## Step-by-Step Execution Tasks

1. Implement core family contracts:
   - Home spotlight/in-progress
   - Series spotlight/continue/in-progress/global/provider
   - Movies spotlight/in-progress/global/provider
2. Implement provider media-specific routes:
   - `provider_{provider_id}_{media}_*`
3. Implement genre families:
   - global fixed-genre lists
   - provider+media+genre lists
4. Implement search contracts:
   - `search_movies`
   - `search_tvshows`
   - params: `query`, `media_type`, `page`, `sort`
5. Enforce pagination payload:
   - `items`, `page`, `has_more`, `next_page`
   - omit `next_page` on terminal page
6. Enforce strict canonical IDs and progress fields:
   - `last_watched_at`, `percent_watched`, `resume_point`, `is_in_progress`
7. Validate ordering rules:
   - continue-watching order is addon-owned guaranteed behavior
8. Produce sample payload fixtures per contract family.

## Validation Checklist (Runtime + Static)

- [ ] Every D-015 contract ID has implementation mapping
- [ ] Spotlight feeds are non-paginated
- [ ] Row feeds obey page-size and has-more semantics
- [ ] sample payloads include required metadata for skin surfaces
- [ ] no generic `discover_root` dependency introduced

## Acceptance Criteria (Pass/Fail)

Pass only if all are true:

- [ ] contract families implemented and mapped
- [ ] schema guarantees match D-015 exactly
- [ ] sample payload validation completed for each family

## Abort / Rollback Guidance

- If a contract family cannot satisfy schema:
  - stop
  - document gap in traceability appendix
  - do not begin skin wiring with partial contract parity

## Common Failure Modes and Detection

- **Failure:** mixed media-type ambiguity in provider routes  
  **Detect:** verify provider contracts are media-specific where required.
- **Failure:** pagination mismatch between addon and skin expectations  
  **Detect:** test first/mid/last page payloads for each major list family.

## If Blocked, Stop and Report

Report:

1. contract ID
2. missing field or behavior
3. proposed fallback (if any) and why it violates current contract

## Handoff to Phase 03

When accepted, proceed to [Phase 03 - Skin Core Plumbing Migration](./phase-03-skin-core-plumbing-migration.md).

