# Milestone 0 — NE Italy + Austria reference-build experiment

## Objective

Prove that we can create three reproducible Valhalla builds from controlled inputs and establish the data foundation needed to compare the Coccau/Tarvisio border topology.

This milestone does **not** modify RoadPilot graphs and does **not** attempt to splice `.gph` records.

## Inputs

Two OSM PBF extracts:

- NE Italy, matching the RoadPilot `italy-nord-est` regional source as closely as practical;
- Austria, matching the RoadPilot `geofabrik-austria` source.

The exact URLs/versions used for an experiment must be recorded in the experiment notes or build manifest.

## Builds

The same Valhalla installation/configuration produces:

```text
work/builds/italy-nord-est/
work/builds/austria/
work/builds/italy-nord-est__austria/
```

The pair build passes both PBFs to the same `valhalla_build_admins` and `valhalla_build_tiles` invocation.

## Acceptance criteria

Milestone 0 is complete when:

- all three builds finish successfully;
- each build has a generated config and tile extract;
- SHA-256 hashes of every input PBF are recorded;
- a Valhalla toolchain fingerprint is recorded;
- graph inventories are produced by `scripts/compare-builds.sh`;
- the three build manifests are retained locally for later topology analysis;
- no PBF or generated graph tile is committed to Git.

## Next milestone

Milestone 1 will add graph inspection around a configurable frontier window, beginning with the Coccau/Tarvisio crossing. It will compare physical/OSM road chains across the standalone and combined builds and produce a structured difference report.
