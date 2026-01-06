#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

if ! command -v terraform-docs >/dev/null 2>&1; then
  echo "terraform-docs not found. Install it first:"
  echo "  macOS:  brew install terraform-docs"
  echo "  Windows: choco install terraform-docs"
  echo "  Linux: see terraform-docs releases"
  exit 1
fi

# Generate docs for all module directories that contain *.tf files
MODULE_DIRS=$(find "$ROOT_DIR/modules" -type f -name "*.tf" -print0 | xargs -0 -n1 dirname | sort -u)

for d in $MODULE_DIRS; do
  echo "Generating docs in: ${d#$ROOT_DIR/}"
  terraform-docs markdown table --output-file README.md --output-mode inject "$d"
done