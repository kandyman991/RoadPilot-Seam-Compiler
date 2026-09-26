# RoadPilot Seam Compiler

Experimental PC-side tooling for discovering, proving, and compiling safe handoffs between independently built Valhalla regional graphs.

The project starts from a simple observation: two standalone regional Valhalla graphs can lose useful cross-boundary topology even when a combined build from the same OSM extracts routes correctly. Instead of copying raw `.gph` records between builds, the Seam Compiler uses a combined build as a **topology oracle** and emits portable RoadPilot seam metadata.

## Goals

- Build region A, region B, and A+B reproducibly with the same Valhalla toolchain.
- Compare standalone and combined graph topology near their shared boundary.
- Identify real OSM road chains that explain missing or ambiguous handoffs.
- Prove directionality and travel-mode access independently.
- Emit a small, versioned seam manifest that RoadPilot can consume.
- Keep raw PBFs and Valhalla graph products outside Git.

## Non-goals

- No byte-level splicing of arbitrary Valhalla `.gph` tiles.
- No monolithic Europe/world graph requirement.
- No RoadPilot Android application code.
- No synthetic straight-line road connections.

## Milestone 0 — NE Italy + Austria reference build

The first experiment reproduces the border pair that motivated this project:

1. Build **NE Italy** standalone.
2. Build **Austria** standalone.
3. Build **NE Italy + Austria** together from both PBF inputs.
4. Record exact inputs, Valhalla version, configuration, checksums, and graph inventories.
5. Inspect the Coccau/Tarvisio frontier and determine what topology the combined build contains that the standalone builds do not expose equivalently.

See [docs/milestone-0.md](docs/milestone-0.md).

## Requirements

The scripts expect Valhalla command-line tools to be installed and on `PATH`:

- `valhalla_build_config`
- `valhalla_build_timezones`
- `valhalla_build_admins`
- `valhalla_build_tiles`
- `valhalla_build_extract`

Valhalla supports passing multiple PBF extracts to the build tools; the pair build uses that capability directly.

## Quick start

```bash
git clone https://github.com/kandyman991/RoadPilot-Seam-Compiler.git
cd RoadPilot-Seam-Compiler

mkdir -p data/pbf
# Put the two experiment PBF files in data/pbf/.

./scripts/build-region.sh italy-nord-est data/pbf/italy-nord-est.osm.pbf
./scripts/build-region.sh austria data/pbf/austria.osm.pbf
./scripts/build-pair.sh italy-nord-est__austria \
  data/pbf/italy-nord-est.osm.pbf \
  data/pbf/austria.osm.pbf

./scripts/compare-builds.sh \
  work/builds/italy-nord-est \
  work/builds/austria \
  work/builds/italy-nord-est__austria
```

Generated artifacts stay under `work/` and are ignored by Git.

## Project layout

```text
docs/                         Architecture and experiment notes
experiments/                  Reproducible experiment definitions
schemas/                      RoadPilot seam manifest schemas
scripts/                      Build and comparison helpers
tools/                        Future graph inspection/compiler code
work/                         Local generated data; ignored by Git
```

## License

Apache License 2.0.
