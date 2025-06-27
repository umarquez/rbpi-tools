#!/bin/bash

set -e

# Detectar shell actual
CURRENT_SHELL=$(basename "$SHELL")
RC_FILE=""

if [[ "$CURRENT_SHELL" == "bash" ]]; then
  RC_FILE="$HOME/.bashrc"
elif [[ "$CURRENT_SHELL" == "zsh" ]]; then
  RC_FILE="$HOME/.zshrc"
else
  echo "❌ Shell no compatible detectado: $CURRENT_SHELL"
  exit 1
fi

echo "🧪 Verificando instalaciones..."
command -v starship >/dev/null 2>&1 || { echo "❌ Starship no está instalado."; exit 1; }
command -v fastfetch >/dev/null 2>&1 || { echo "❌ Fastfetch no está instalado."; exit 1; }

echo "⚙️ Configurando $RC_FILE..."

# Elimina bloques antiguos si ya existen
sed -i '/# GLITX_PROMPT_BEGIN/,/# GLITX_PROMPT_END/d' "$RC_FILE"

# Agrega nueva configuración
cat << 'EOF' >> "$RC_FILE"
# GLITX_PROMPT_BEGIN
# Mostrar fastfetch solo una vez por sesión interactiva
if [ -z "$FASTFETCH_SHOWN" ]; then
  fastfetch
  export FASTFETCH_SHOWN=true
fi

# Activar starship
eval "$(starship init $CURRENT_SHELL)"
# GLITX_PROMPT_END
EOF

echo "✅ Integración completa."
echo "🔄 Aplica los cambios con: source $RC_FILE"
