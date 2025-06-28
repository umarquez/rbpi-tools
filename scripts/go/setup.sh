#!/usr/bin/env bash

set -euo pipefail

# Exit early if Go is already installed
if command -v go >/dev/null 2>&1; then
  echo "🛑 Go is already installed – skipping installation."
  go version
  exit 0
fi

# Set default version and architecture
VERSION="${VERSION:-1.24.4}"
ARCH="${ARCH:-arm64}"
TARFILE="go${VERSION}.linux-${ARCH}.tar.gz"
DOWNLOAD_URL="https://go.dev/dl/${TARFILE}"

echo "⬇️ Downloading Go ${VERSION} for ${ARCH}..."
wget -q --show-progress "$DOWNLOAD_URL"

echo "🧹 Removing previous Go versions in /usr/local/go..."
sudo rm -rf /usr/local/go

echo "📦 Extracting Go..."
sudo tar -C /usr/local -xzf "$TARFILE"

echo "🛠️ Setting PATH..."
if ! grep -q "/usr/local/go/bin" ~/.profile; then
  echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
fi

# Apply changes to current shell (temporarily disable nounset to avoid undefined variables)
set +u
source ~/.profile || true
set -u

echo "🧽 Removing downloaded archive..."
rm "$TARFILE"

echo "✅ Go ${VERSION} installed successfully."
go version
