#!/usr/bin/env bats

setup() {
  TMP_HOME="$(mktemp -d)"
  export HOME="$TMP_HOME"
  export SHELL="/bin/bash"
  export PATH="$TMP_HOME/bin:$PATH"
  mkdir -p "$TMP_HOME/bin"

  cat <<'EOFF' > "$TMP_HOME/bin/starship"
#!/bin/sh
exit 0
EOFF
  chmod +x "$TMP_HOME/bin/starship"

  cat <<'EOFF' > "$TMP_HOME/bin/fastfetch"
#!/bin/sh
exit 0
EOFF
  chmod +x "$TMP_HOME/bin/fastfetch"

  touch "$HOME/.bashrc"
}

teardown() {
  rm -rf "$TMP_HOME"
}

@test "config.sh appends GLITX_PROMPT block" {
  run scripts/config/config.sh
  [ "$status" -eq 0 ]
  grep -q "# GLITX_PROMPT_BEGIN" "$HOME/.bashrc"
  grep -q "# GLITX_PROMPT_END" "$HOME/.bashrc"
}
