#!/bin/bash

set -e

echo ">> Cassette Futurism Linux Setup"
echo ">> Installing dependencies..."

sudo apt update && sudo apt install -y \
  i3 kitty conky polybar neofetch feh \
  pulseaudio alsa-utils \
  fonts-terminus \
  x11-xserver-utils \
  mpv xlockmore

# If using TTF Terminus instead of bitmap:
# sudo apt install xfonts-terminus

echo ">> Copying dotfiles..."

mkdir -p ~/.config/i3 ~/.config/kitty ~/.config/polybar ~/.config/conky ~/.config/neofetch

cp -r i3/config ~/.config/i3/
cp -r kitty/kitty.conf ~/.config/kitty/
cp -r polybar/config ~/.config/polybar/
cp -r conky/conky.conf ~/.config/conky/
cp -r neofetch/config.conf ~/.config/neofetch/

echo ">> Installing custom scripts..."
mkdir -p ~/.local/bin
cp -r scripts/* ~/.local/bin/
chmod +x ~/.local/bin/*

echo ">> Setup complete. Enjoy the amber glow."
