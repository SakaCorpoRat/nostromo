#!/bin/bash

set -e

# Get the folder where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[ Cassette Linux Setup ]"
echo "Installing packages..."

sudo apt update && sudo apt install -y \
  i3 kitty conky polybar neofetch feh \
  fonts-terminus dmenu

echo "[ Creating user config directories... ]"
mkdir -p ~/.config/{i3,kitty,polybar,conky,neofetch} ~/.local/bin

# Function to back up existing config and replace it
backup_and_copy() {
  local src="$1"
  local dest="$2"
  if [ ! -f "$src" ]; then
    echo "ERROR: Source does not exist: $src"
    exit 1
  fi
  if [ -f "$dest" ]; then
    mv "$dest" "$dest.backup.$(date +%s)"
    echo "[ Backed up existing file: $dest ]"
  fi
  cp "$src" "$dest"
  echo "[ Installed: $dest ]"
}

echo "[ Installing configs... ]"
backup_and_copy "$SCRIPT_DIR/i3/config" "$HOME/.config/i3/config"
backup_and_copy "$SCRIPT_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
backup_and_copy "$SCRIPT_DIR/polybar/config.ini" "$HOME/.config/polybar/config.ini"
backup_and_copy "$SCRIPT_DIR/conky/conky.conf" "$HOME/.config/conky/conky.conf"
backup_and_copy "$SCRIPT_DIR/neofetch/config.conf" "$HOME/.config/neofetch/config.conf"

echo "[ Installing scripts... ]"
cp -r "$SCRIPT_DIR/scripts/"* "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/"*

echo "[ Setup complete! ] Launch i3 and bask in the amber glow."
