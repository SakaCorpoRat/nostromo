#!/bin/bash

set -e

echo "[ Cassette Linux Setup ]"
echo "Installing dependencies..."

sudo apt update && sudo apt install -y \
  i3 kitty conky polybar neofetch feh \
  fonts-terminus dmenu

mkdir -p ~/.config/{i3,kitty,polybar,conky,neofetch} ~/.local/bin

backup_and_copy() {
  local src=$1
  local dest=$2
  if [ -f "$dest" ]; then
    mv "$dest" "$dest.backup.$(date +%s)"
    echo "[ Backed up: $dest ]"
  fi
  cp "$src" "$dest"
}

echo "Copying dotfiles..."
backup_and_copy i3/config ~/.config/i3/config
backup_and_copy kitty/kitty.conf ~/.config/kitty/kitty.conf
backup_and_copy polybar/config.ini ~/.config/polybar/config.ini
backup_and_copy conky/conky.conf ~/.config/conky/conky.conf
backup_and_copy neofetch/config.conf ~/.config/neofetch/config.conf

cp -r scripts/* ~/.local/bin/
chmod +x ~/.local/bin/*

echo "[ Done ] Welcome to the retrofuture."
echo "You can launch your session and tweak from ~/.config/i3/config."
