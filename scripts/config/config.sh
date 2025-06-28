#!/usr/bin/env bash

set -euo pipefail

# Detect current shell; fall back to environment checks if $SHELL is not set
if [ -n "${BASH_VERSION-}" ]; then
  CURRENT_SHELL="bash"
elif [ -n "${ZSH_VERSION-}" ]; then
  CURRENT_SHELL="zsh"
elif [ -n "${SHELL-}" ]; then
  CURRENT_SHELL=$(basename "$SHELL")
else
  CURRENT_SHELL=""
fi

RC_FILE=""

case "$CURRENT_SHELL" in
  bash) RC_FILE="$HOME/.bashrc" ;;
  zsh)  RC_FILE="$HOME/.zshrc" ;;
  *)
    echo "❌ Unsupported shell detected: $CURRENT_SHELL"
    exit 1
    ;;
esac

echo "🧪 Verifying required installations..."
command -v starship >/dev/null 2>&1 || { echo "❌ Starship is not installed."; exit 1; }
command -v fastfetch >/dev/null 2>&1 || { echo "❌ Fastfetch is not installed."; exit 1; }

echo "⚙️ Configuring $RC_FILE..."

# Remove previous GLITX prompt blocks if they exist
sed -i '/# GLITX_PROMPT_BEGIN/,/# GLITX_PROMPT_END/d' "$RC_FILE"

# Agrega nueva configuración
cat << 'EOF' >> "$RC_FILE"
# GLITX_PROMPT_BEGIN
# Show fastfetch only once per interactive session
if [ -z "${FASTFETCH_SHOWN-}" ]; then
  fastfetch
  export FASTFETCH_SHOWN=true
fi

# Activate starship
eval "$(starship init \"${CURRENT_SHELL}\")"
# GLITX_PROMPT_END
EOF

echo "✅ Integration complete."
echo "🔄 Apply the changes with: source $RC_FILE"
