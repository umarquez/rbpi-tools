#!/usr/bin/env bash

set -euo pipefail

# 📌 Configura la versión y arquitectura con valores por defecto
VERSION="${VERSION:-1.24.4}"
ARCH="${ARCH:-arm64}"
TARFILE="go${VERSION}.linux-${ARCH}.tar.gz"
DOWNLOAD_URL="https://go.dev/dl/${TARFILE}"

echo "⬇️ Descargando Go ${VERSION} para ${ARCH}..."
wget -q --show-progress "$DOWNLOAD_URL"

echo "🧹 Eliminando versiones previas de Go en /usr/local/go..."
sudo rm -rf /usr/local/go

echo "📦 Extrayendo Go..."
sudo tar -C /usr/local -xzf "$TARFILE"

echo "🛠️ Configurando PATH..."
if ! grep -q "/usr/local/go/bin" ~/.profile; then
  echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
fi

# Aplicar cambios al entorno actual
source ~/.profile || true

echo "🧽 Eliminando archivo descargado..."
rm "$TARFILE"

echo "✅ Go ${VERSION} instalado correctamente."
go version
