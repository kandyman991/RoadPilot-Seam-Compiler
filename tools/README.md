# Tools

Milestone 1 will introduce graph inspection code here.

Planned capabilities:

- enumerate Valhalla graph edges/nodes inside a geographic window;
- extract OSM identity where retained/available;
- normalize edge geometry and access information;
- correlate standalone A, standalone B, and combined A+B roads;
- identify connected reference chains missing from or ambiguous in standalone builds;
- emit a structured seam proof conforming to `schemas/roadpilot-seam.schema.json`.

Core algorithms must not contain Italy/Austria-specific portal IDs or coordinates.
