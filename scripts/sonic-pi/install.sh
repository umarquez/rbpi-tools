#!/usr/bin/env bash

set -euo pipefail

# Exit early if Sonic Pi is already installed
if command -v sonic-pi >/dev/null 2>&1; then
  echo "🛑 Sonic Pi is already installed – skipping installation."
  exit 0
fi

wget https://sonic-pi.net/files/releases/v4.5.1/sonic-pi_4.5.1_1_bookworm.arm64.deb
sudo apt install ./sonic-pi_4.5.1_1_bookworm.arm64.deb
rm sonic-pi_4.5.1_1_bookworm.arm64.deb