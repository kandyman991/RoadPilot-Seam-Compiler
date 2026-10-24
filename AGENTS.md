# RoadPilot Seam Compiler — persistent continuity rules

1. Read `CHAT_HANDOFF.md`, `handoff/state.json` (snapshot only), and any `ROADMAP.md` and experiment docs.
2. Check live GitHub main SHA, PRs, issues and CI before selecting the next step.
3. This is a parked experimental companion, not production. Compare any new hypothesis against current RoadPilot-Offline-Data Graph Studio Border Inspector and exact boundary-diff capabilities before restarting PR #1. Never transplant or splice raw Valhalla .gph IDs.
4. Record the hypothesis, exact reproduction, results, failed approaches, verified commit/CI and next exact action in the curated `CHAT_HANDOFF.md` whenever an experiment changes.
5. `handoff/state.json` may be stale. GitHub is authoritative about current Git/CI; chat history is not automatically copied to the repo.
6. Never consume Android build resources or Actions artifact storage for documentation-only changes; keep secrets out of Git.

**Priority:** Favor current `kandyman991/RoadPilot-Offline-Data` production roadmap over reviving a parallel production pipeline here.

## Architecture memory and rejected experiments
- Before restarting a research/design hypothesis, review `docs/ARCHITECTURE_MEMORY.md`, `docs/FAILED_APPROACHES.md`, research logs and current production decisions in `kandyman991/RoadPilot-Offline-Data`. Confirm live GitHub state.
- For each material negative or inconclusive experiment record what was actually run, inputs/versions, observations, root-cause confidence, linked evidence and what would justify reconsideration. Unexecuted ideas are REJECTED_BY_DESIGN or INCONCLUSIVE, never reported as tested failures.
- Before PR merge, explain whether it revisits a recorded approach, why assumptions changed and the regression proof. Keep this research project isolated from production without explicit approval. Documentation-only work requires no heavy builds.
