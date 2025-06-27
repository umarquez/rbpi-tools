#!/usr/bin/env bash

set -euo pipefail

echo "========================="
echo "Installing Pisound"
echo "-------------------------"
curl https://blokas.io/pisound/install.sh | sh
sudo pisound-config
echo "========================="
echo "Pisound installation complete."
