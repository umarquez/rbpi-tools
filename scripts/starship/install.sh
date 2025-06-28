#!/usr/bin/env bash

set -euo pipefail

# Exit early if Starship is already installed
if command -v starship >/dev/null 2>&1; then
  echo "🛑 Starship is already installed – skipping installation."
  exit 0
fi

curl -sS https://starship.rs/install.sh | sh -s -- -y
