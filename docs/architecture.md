# Architecture

## Principle

The Seam Compiler treats a combined Valhalla build as a **reference topology**, not as a source of raw graph records to paste into independently built regions.

For adjacent regions A and B:

```text
A.pbf ───────────────> standalone graph A
B.pbf ───────────────> standalone graph B

A.pbf + B.pbf ───────> combined reference graph A+B
                              │
                              ▼
                      topology comparison
                              │
                              ▼
                       RoadPilot seam proof
```

The output should describe real-world road identity and topology in portable terms such as OSM way/node identity, coordinates, direction, access modes, geometry, and proof metadata.

## Why not splice .gph records?

Valhalla graph records are build-local. Directed edges, opposing edges, hierarchy transitions, shortcuts, tile-local indexes, and GraphIds are generated as part of a complete build. A raw edge copied from A+B into A or B can carry references that are meaningless in the destination build.

The compiler therefore transfers **knowledge**, not graph bytes.

## Intended pipeline

### 1. Reproducible inputs

Every comparison records:

- source PBF path and SHA-256;
- Valhalla binary/version fingerprint;
- generated `valhalla.json`;
- build timestamp;
- region/pair identifier.

### 2. Three builds

For a pair A/B:

- standalone A;
- standalone B;
- combined A+B reference.

All three must use equivalent Valhalla configuration.

### 3. Boundary-focused graph inspection

Future graph-inspection tooling will extract candidate roads around the shared frontier and map them using stable physical/OSM evidence rather than GraphId equality.

Candidate evidence includes:

- OSM way/node IDs where available;
- edge geometry;
- endpoint coordinates;
- road class;
- forward/reverse access;
- travel modes;
- heading continuity;
- connected edge chains.

### 4. Difference classification

A boundary difference should fall into one of three broad classes:

1. **Representational difference** — both standalone graphs contain enough road geometry, but their natural handoff is difficult to infer.
2. **Missing standalone coverage/topology** — the combined graph contains a usable connected road chain that cannot be reproduced safely from the two standalone graphs.
3. **No valid crossing** — the combined graph itself does not prove the requested connection.

### 5. Compilation target

For class 1, emit a lightweight RoadPilot seam/corridor manifest.

For class 2, a later experiment may generate a small independently built border bridge graph plus its seam manifest.

For class 3, emit no routeable seam.

## Runtime relationship

RoadPilot should consume precompiled seam metadata when available. Existing runtime FRONTIER-SEAM/spatial discovery remains a fallback and diagnostic safety net.

The compiler must remain generic: no Italy/Austria-specific IDs or coordinates in core algorithms.
