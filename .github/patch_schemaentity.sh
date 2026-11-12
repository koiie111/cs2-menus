#!/usr/bin/env bash
# Apply the pinned SDK14197 schema compatibility patch to a clean dependency.
set -euo pipefail
patch_dir=$(cd -- "$(dirname -- "$0")" && pwd)
git -C "$1" apply --whitespace=nowarn "$patch_dir/../patches/schema-14197.patch"
