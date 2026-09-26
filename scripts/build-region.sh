#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <build-id> <input.osm.pbf> [additional.osm.pbf ...]" >&2
  exit 64
fi

BUILD_ID="$1"
shift
PBFS=("$@")

for tool in valhalla_build_config valhalla_build_timezones valhalla_build_admins valhalla_build_tiles valhalla_build_extract sha256sum; do
  command -v "$tool" >/dev/null 2>&1 || {
    echo "Missing required tool: $tool" >&2
    exit 69
  }
done

for pbf in "${PBFS[@]}"; do
  [[ -f "$pbf" ]] || {
    echo "Input not found: $pbf" >&2
    exit 66
  }
done

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/work/builds/$BUILD_ID"
TILE_DIR="$BUILD_DIR/tiles"
CONFIG="$BUILD_DIR/valhalla.json"
MANIFEST="$BUILD_DIR/build-manifest.txt"

mkdir -p "$TILE_DIR"

if find "$TILE_DIR" -type f -print -quit | grep -q .; then
  echo "Refusing to reuse non-empty tile directory: $TILE_DIR" >&2
  echo "Remove the build directory explicitly before rebuilding." >&2
  exit 73
fi

echo "Generating Valhalla config..."
valhalla_build_config   --mjolnir-tile-dir "$TILE_DIR"   --mjolnir-tile-extract "$BUILD_DIR/tiles.tar"   --mjolnir-timezone "$TILE_DIR/timezones.sqlite"   --mjolnir-admin "$TILE_DIR/admins.sqlite"   > "$CONFIG"

echo "Building timezones..."
valhalla_build_timezones > "$TILE_DIR/timezones.sqlite"

echo "Building admin database..."
valhalla_build_admins -c "$CONFIG" "${PBFS[@]}"

echo "Building routing graph..."
valhalla_build_tiles -c "$CONFIG" "${PBFS[@]}"

echo "Building tile extract..."
valhalla_build_extract -c "$CONFIG" -v

{
  echo "build_id=$BUILD_ID"
  echo "created_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "host=$(uname -a)"
  echo "config_sha256=$(sha256sum "$CONFIG" | awk '{print $1}')"
  for pbf in "${PBFS[@]}"; do
    echo "pbf=$pbf"
    echo "pbf_sha256=$(sha256sum "$pbf" | awk '{print $1}')"
  done
  for tool in valhalla_build_config valhalla_build_tiles; do
    echo "tool_$tool=$(command -v "$tool")"
    "$tool" --help 2>&1 | head -n 1 | sed "s/^/tool_${tool}_banner=/" || true
  done
  echo "tile_file_count=$(find "$TILE_DIR" -type f | wc -l)"
  echo "tile_bytes=$(du -sb "$TILE_DIR" | awk '{print $1}')"
  if [[ -f "$BUILD_DIR/tiles.tar" ]]; then
    echo "extract_sha256=$(sha256sum "$BUILD_DIR/tiles.tar" | awk '{print $1}')"
    echo "extract_bytes=$(stat -c %s "$BUILD_DIR/tiles.tar")"
  fi
} > "$MANIFEST"

echo "Build complete: $BUILD_DIR"
echo "Manifest: $MANIFEST"
