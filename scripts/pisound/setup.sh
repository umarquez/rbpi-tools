#!/usr/bin/env bash

set -euo pipefail

# Exit early if Pisound tools are already installed
if command -v pisound-config >/dev/null 2>&1; then
  echo "🛑 Pisound is already installed – skipping installation."
  exit 0
fi

echo "========================="
echo "Installing Pisound"
echo "-------------------------"
curl https://blokas.io/pisound/install.sh | sh
sudo pisound-config
echo "========================="
echo "Pisound installation complete."
