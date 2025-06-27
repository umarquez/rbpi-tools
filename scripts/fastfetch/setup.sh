#!/bin/bash

set -e

echo "📦 Instalando dependencias..."
sudo apt update && sudo apt install -y \
  git cmake build-essential \
  libpci-dev libvulkan-dev libgl1-mesa-dev libdrm-dev

echo "📥 Clonando repositorio de fastfetch..."
git clone https://github.com/fastfetch-cli/fastfetch.git
cd fastfetch

echo "📁 Creando directorio de build..."
mkdir -p build && cd build

echo "🔧 Ejecutando cmake..."
cmake ..

echo "🧱 Compilando fastfetch..."
make -j$(nproc)

echo "📂 Instalando binario..."
sudo make install

echo "✅ fastfetch instalado correctamente."
echo "👉 Puedes ejecutarlo con el comando: fastfetch"

fastfetch