#!/usr/bin/env bash

# Exit early if FastFetch is already installed
if command -v fastfetch >/dev/null 2>&1; then
  echo "🛑 FastFetch is already installed – skipping installation."
  exit 0
fi

set -euo pipefail

echo "📦 Instalando dependencias..."
sudo apt update && sudo apt install -y \
  git cmake build-essential \
  libpci-dev libvulkan-dev libgl1-mesa-dev libdrm-dev

echo "📥 Clonando repositorio de fastfetch..."
git clone --depth 1 https://github.com/fastfetch-cli/fastfetch.git
cd fastfetch

echo "📁 Creando directorio de build..."
mkdir -p build && cd build

echo "🔧 Ejecutando cmake..."
cmake ..

echo "🧱 Compilando fastfetch..."
make -j$(nproc)

echo "📂 Instalando binario..."
sudo make install

# Limpiar archivos de build para mantener ordenado
cd ../../
rm -rf fastfetch

echo "✅ fastfetch instalado correctamente."
# Instruye al usuario a ejecutar fastfetch manualmente
echo "👉 Puedes ejecutarlo con el comando: fastfetch"
