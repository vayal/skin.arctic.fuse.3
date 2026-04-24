# Appendix - Verification Checklists

Use these reusable checklists across phases.

## 1) Contract Wiring Checklist

- [ ] all required D-015 contract families exist
- [ ] route naming matches frozen contract IDs/patterns
- [ ] pagination payload includes `items/page/has_more/next_page`
- [ ] `next_page` omitted on terminal page
- [ ] strict IDs and progress fields are present where required

## 2) Hub and Mini-Hub UX Checklist

- [ ] Home/Series/Movies spotlight routes resolve correctly
- [ ] provider icon row opens provider mini-hub targets
- [ ] provider hub rows use standardized route families
- [ ] genre rows use fixed genre set and open filtered lists

## 3) Paging and List Behavior Checklist

- [ ] in-row cap behavior matches contract
- [ ] row header opens full list as defined
- [ ] full list page size is 40
- [ ] no next-page artifact in spotlight feeds
- [ ] empty rows render expected empty-state behavior

## 4) Details and OSD Checklist

- [ ] details action opens full details flow
- [ ] no unintended small info dialog regression
- [ ] OSD normal controls behavior preserved
- [ ] pause strip shows minimal title + plot
- [ ] OSD overlay to full-details escalation works

## 5) Context and Removal Policy Checklist

- [ ] D-021 policy enforced (skin expanded items removed)
- [ ] removed PVR surfaces are unreachable
- [ ] removed weather surfaces (if phase-complete scope includes them) are unreachable
- [ ] removed helper-only wiki/crew surfaces are unreachable

## 6) Metadata Rendering Checklist

- [ ] row cards remain image-only
- [ ] spotlight metadata fields render correctly
- [ ] labels render from Velocity/native properties
- [ ] overlays and info panels no longer depend on helper-only branches
- [ ] trailer surfaces (if retained) use non-helper metadata

## 7) Residual Dependency Checklist

- [ ] no undeclared `TMDbHelper.*` / `TMDBHelper.*` references in active migrated surfaces
- [ ] no undeclared helper addon-id references in active settings/actions
- [ ] all remaining references are documented in D-038 as approved exceptions

## 8) Freeze Readiness Checklist

- [ ] phases 01-07 accepted
- [ ] traceability matrix complete
- [ ] no unresolved P0/P1 blockers
- [ ] all temporary exceptions have explicit rationale and follow-up

