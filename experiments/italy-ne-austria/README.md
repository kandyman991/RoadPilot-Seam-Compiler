# Experiment: italy-nord-est ↔ austria

This is the first Seam Compiler reference experiment.

## Hypothesis

A combined Valhalla build created from the NE Italy and Austria OSM extracts contains connected border topology that can serve as ground truth when independently built regional graphs expose an ambiguous or incomplete handoff.

## Known validation area

The initial inspection area is the Coccau/Tarvisio frontier used during RoadPilot cross-region routing development.

The experiment intentionally avoids hard-coding the known RoadPilot portal IDs into compiler logic. Known coordinates/IDs may be used only as validation fixtures once generic extraction exists.

## Procedure

1. Acquire the two PBF inputs.
2. Record their source URLs and checksums.
3. Build each extract independently.
4. Build both extracts together.
5. Run `scripts/compare-builds.sh`.
6. Preserve the generated manifests under local `work/`.
7. In Milestone 1, inspect graph topology around the frontier.

## Expected outcome

We should be able to explain the standalone-vs-combined difference using stable road evidence rather than cross-build GraphId equality.
