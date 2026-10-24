# RoadPilot Seam Compiler — rejected, superseded and inconclusive approaches

Read `docs/ARCHITECTURE_MEMORY.md` for the required evidence template. These entries document known boundaries, **not fabricated failed test runs**.

## RSC-001 — Splice independently built Valhalla .gph IDs directly
- Status: REJECTED_BY_DESIGN
- Recorded: 2026-10-24
- Objective: connect independently built regions.
- Considered approach: transplant raw Valhalla graph identifiers or merge incompatible tile graphs.
- Evidence: `AGENTS.md`, `CHAT_HANDOFF.md` prohibit raw .gph splicing; no experimental failure is asserted here.
- Decision: use isolated comparisons and validated RoadPilot-owned transitions rather than raw cross-build GraphId assumptions.
- Reconsider only if: approved ADR, versioned compatibility proof and routing regressions demonstrate correctness.

## RSC-002 — Duplicate Graph Studio production border tooling
- Status: SUPERSEDED
- Recorded: 2026-10-24
- Objective: investigate border mismatches using combined-pair reference builds.
- Historical status: experimental PR #1; follow the **live PR state** rather than assuming it has merged.
- Evidence: `CHAT_HANDOFF.md` says work is parked pending a comparison with Graph Studio's Border Inspector and boundary-diff features.
- Decision: keep this separate only if a controlled experiment answers a question not already covered by Graph Studio.
- Reconsider only if: the gap is documented and a reproducible test plan shows unique research value.
