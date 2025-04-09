#!/bin/bash

set -e

echo "[ Cassette Linux Setup ]"
echo "Installing required packages..."

sudo apt update && sudo apt install -y \
  i3 kitty conky polybar neofetch feh \
  fonts-terminus dmenu

echo "[ Creating user config directories... ]"
mkdir -p ~/.config/{i3,kitty,polybar,conky,neofetch} ~/.local/bin

# Backup and install config file
install_config() {
  local dest="$HOME/.config/$1"
  local content="$2"

  if [ -f "$dest" ]; then
    mv "$dest" "$dest.backup.$(date +%s)"
    echo "[ Backed up: $dest ]"
  fi

  echo "$content" > "$dest"
  echo "[ Installed: $dest ]"
}

# Example: Replace these variables with your actual config content (or load them from /etc/skel)
install_config "i3/config" "$(cat /etc/skel/.config/i3/config)"
install_config "kitty/kitty.conf" "$(cat /etc/skel/.config/kitty/kitty.conf)"
install_config "polybar/config.ini" "$(cat /etc/skel/.config/polybar/config.ini)"
install_config "conky/conky.conf" "$(cat /etc/skel/.config/conky/conky.conf)"
install_config "neofetch/config.conf" "$(cat /etc/skel/.config/neofetch/config.conf)"

echo "[ Copying user scripts... ]"
cp -r /etc/skel/.local/bin/* ~/.local/bin/
chmod +x ~/.local/bin/*

echo "[ Done ] Welcome to the retrofuture!"
