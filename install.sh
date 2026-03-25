#!/bin/bash
# Install repo-link to ~/.local/bin and add to PATH if needed
set -euo pipefail

INSTALL_DIR="${HOME}/.local/bin"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$INSTALL_DIR"
cp "$SCRIPT_DIR/repo-link" "$INSTALL_DIR/repo-link"
chmod +x "$INSTALL_DIR/repo-link"

# Check if ~/.local/bin is in PATH
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$INSTALL_DIR"; then
  # Detect shell config file
  if [[ -f "$HOME/.bashrc" ]]; then
    SHELL_RC="$HOME/.bashrc"
  elif [[ -f "$HOME/.bash_profile" ]]; then
    SHELL_RC="$HOME/.bash_profile"
  elif [[ -f "$HOME/.profile" ]]; then
    SHELL_RC="$HOME/.profile"
  else
    SHELL_RC="$HOME/.bashrc"
  fi

  echo '' >> "$SHELL_RC"
  echo '# repo-link' >> "$SHELL_RC"
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
  echo "Added ~/.local/bin to PATH in $SHELL_RC"
  echo "Run 'source $SHELL_RC' or open a new terminal to use repo-link."
else
  echo "~/.local/bin is already in PATH."
fi

echo "Installed repo-link to $INSTALL_DIR/repo-link"
