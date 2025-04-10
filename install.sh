#!/bin/bash

set -e

echo "[ Cassette Linux Setup ]"
echo "Installing packages..."

sudo apt update && sudo apt install -y \
  i3 kitty conky polybar neofetch feh \
  fonts-terminus dmenu

# Just make sure the right folders exist
echo "[ Ensuring directories exist... ]"
mkdir -p /home/deckard/.config/{i3,kitty,polybar,conky,neofetch}
mkdir -p /home/deckard/.local/bin

# Optional: Copy scripts if they don't exist
if [ -f /home/deckard/.local/bin/boot-sound.sh ]; then
  echo "[ boot-sound.sh already exists — skipping copy ]"
else
  echo '#!/bin/bash\nmpv --no-video /home/deckard/.config/sounds/boot.ogg &' > /home/deckard/.local/bin/boot-sound.sh
  chmod +x /home/deckard/.local/bin/boot-sound.sh
  echo "[ Installed boot-sound.sh ]"
fi

if [ -f /home/deckard/.local/bin/matrix-lock.sh ]; then
  echo "[ matrix-lock.sh already exists — skipping copy ]"
else
  echo '#!/bin/bash\nxlock -mode matrix -fg green -bg black' > /home/deckard/.local/bin/matrix-lock.sh
  chmod +x /home/deckard/.local/bin/matrix-lock.sh
  echo "[ Installed matrix-lock.sh ]"
fi

echo "[ Done ] Nothing was copied into 'nostromo' or any temp folder."
echo "[ System is using /home/deckard/.config directly. All good. ✅ ]"
