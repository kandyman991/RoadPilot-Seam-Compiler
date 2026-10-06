# Chat Handoff — RoadPilot Seam Compiler

_Last curated: 2026-10-06_

## Recovery procedure
When the user says “pick up Seam Compiler from the Git handoff”:
1. Read this file.
2. Read handoff/state.json.
3. Check PR #1 and live CI/branch status.
4. Compare the experiment with the current RoadPilot-Offline-Data roadmap before continuing, because Graph Studio now owns most production graph/border tooling.

## Role
Experimental PC-side project for comparing independently built Valhalla regions against a combined-pair reference build. It must not splice raw .gph files.

## Current status
Open PR #1 bootstraps Milestone 0 for Italy Nord-Est + Austria.

Milestone 0 target:
- build Italy Nord-Est standalone;
- build Austria standalone;
- build the pair together with the same toolchain;
- capture build/checksum evidence;
- compare graph inventories;
- prepare boundary-focused topology comparison around Coccau/Tarvisio.

## Relationship to Graph Studio
RoadPilot-Offline-Data / Graph Studio is now the canonical production workstation. Do not duplicate functionality here if Graph Studio already provides it.

Keep Seam Compiler only for experiments where a combined-pair reference graph materially helps us understand independent graph topology.

## Next exact action
If this repo is resumed, first decide whether PR #1 still answers a question not already covered by Graph Studio Border Inspector + issue #13 boundary diffing. If yes, execute Milestone 0; otherwise leave the experiment parked.

## Maintenance
Update this file when the experiment hypothesis or relationship to Graph Studio changes.
