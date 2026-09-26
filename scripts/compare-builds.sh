#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <standalone-a-dir> <standalone-b-dir> <combined-dir>" >&2
  exit 64
fi

A="$1"
B="$2"
AB="$3"

for dir in "$A" "$B" "$AB"; do
  [[ -d "$dir" ]] || {
    echo "Build directory not found: $dir" >&2
    exit 66
  }
done

inventory() {
  local label="$1"
  local dir="$2"
  local tiles="$dir/tiles"
  echo "[$label]"
  echo "path=$dir"

  if [[ -f "$dir/build-manifest.txt" ]]; then
    sed 's/^/manifest: /' "$dir/build-manifest.txt"
  fi

  if [[ -d "$tiles" ]]; then
    echo "gph_files=$(find "$tiles" -type f -name '*.gph' | wc -l)"
    echo "gph_bytes=$(find "$tiles" -type f -name '*.gph' -printf '%s\n' | awk '{s+=$1} END {print s+0}')"
    echo "all_tile_files=$(find "$tiles" -type f | wc -l)"
  fi

  echo
}

echo "# RoadPilot Seam Compiler build inventory"
echo "generated_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo
inventory "standalone_a" "$A"
inventory "standalone_b" "$B"
inventory "combined_ab" "$AB"

cat <<'EOF'
# NOTE
# This Milestone 0 report compares build identity and graph inventory only.
# Milestone 1 will inspect graph topology near a configurable frontier and
# correlate edges by OSM/physical evidence rather than by cross-build GraphId.
EOF
