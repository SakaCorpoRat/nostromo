#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="/home/deckard/.config"
BIN_DIR="/home/deckard/.local/bin"

echo "[ Cassette Linux Setup ]"
echo "Installing packages..."

sudo apt update && sudo apt install -y \
  i3 kitty conky polybar neofetch feh \
  fonts-terminus dmenu

echo "[ Creating config directories... ]"
mkdir -p "$CONFIG_DIR"/{i3,kitty,polybar,conky,neofetch} "$BIN_DIR"

backup_and_copy() {
  local src="$1"
  local dest="$2"
  if [ ! -f "$src" ]; then
    echo "ERROR: Source file not found: $src"
    exit 1
  fi
  if [ -f "$dest" ]; then
    mv "$dest" "$dest.backup.$(date +%s)"
    echo "[ Backed up $dest ]"
  fi
  cp "$src" "$dest"
  echo "[ Installed: $dest ]"
}

echo "[ Copying configs... ]"
backup_and_copy "$SCRIPT_DIR/i3/config" "$CONFIG_DIR/i3/config"
backup_and_copy "$SCRIPT_DIR/kitty/kitty.conf" "$CONFIG_DIR/kitty/kitty.conf"
backup_and_copy "$SCRIPT_DIR/polybar/config.ini" "$CONFIG_DIR/polybar/config.ini"
backup_and_copy "$SCRIPT_DIR/conky/conky.conf" "$CONFIG_DIR/conky/conky.conf"
backup_and_copy "$SCRIPT_DIR/neofetch/config.conf" "$CONFIG_DIR/neofetch/config.conf"

echo "[ Installing scripts... ]"
cp -r "$SCRIPT_DIR/scripts/"* "$BIN_DIR/"
chmod +x "$BIN_DIR/"*

echo "[ Done ] Configuration installed to /home/deckard/.config and /home/deckard/.local/bin."
