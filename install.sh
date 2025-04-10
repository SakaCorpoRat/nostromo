#!/bin/bash

set -e

CONFIG_DIR="/home/deckard/.config"
BIN_DIR="/home/deckard/.local/bin"

echo "[ Cassette Linux Setup ]"
echo "Installing packages..."

sudo apt update && sudo apt install -y \
  i3 kitty conky polybar neofetch feh \
  mpv xlockmore-gl fonts-terminus dmenu

echo "[ Creating config directories... ]"
mkdir -p "$CONFIG_DIR"/{i3,kitty,polybar,conky,neofetch} "$BIN_DIR"

# Write i3 config
cat > "$CONFIG_DIR/i3/config" << 'EOF'
set $mod Mod4
font pango:Terminus 12

# Keybindings
bindsym $mod+Return exec kitty
bindsym $mod+d exec dmenu_run
bindsym $mod+Shift+q kill
bindsym $mod+Shift+r restart
bindsym $mod+Shift+e exit
bindsym $mod+f fullscreen toggle
bindsym $mod+space floating toggle
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# Autostart
exec_always --no-startup-id $HOME/.config/polybar/launch.sh
exec --no-startup-id conky
exec --no-startup-id $HOME/.local/bin/boot-sound.sh

# Appearance
gaps inner 10
gaps outer 10
smart_gaps on
default_border pixel 2
new_window pixel 2

client.focused          #ffbf00 #ffbf00 #ffffff #ffbf00 #ffbf00
client.unfocused        #1a1a1a #1a1a1a #ffffff #1a1a1a #1a1a1a
client.urgent           #ff0000 #ff0000 #ffffff #ff0000 #ff0000
EOF

# Write kitty config
cat > "$CONFIG_DIR/kitty/kitty.conf" << 'EOF'
font_family Terminus
font_size 12
foreground #ffffff
background #000000
cursor #ffbf00
color0  #000000
color1  #ff0000
color2  #00ff00
color3  #ffbf00
color4  #0087ff
color5  #ff00ff
color6  #00ffff
color7  #d0d0d0
color8  #808080
color9  #ff0000
color10 #00ff00
color11 #ffbf00
color12 #0087ff
color13 #ff00ff
color14 #00ffff
color15 #ffffff
EOF

# Write polybar config
cat > "$CONFIG_DIR/polybar/config.ini" << 'EOF'
[bar/top]
monitor = ${env:MONITOR:HDMI-1}
width = 100%
height = 28
background = #000000
foreground = #ffffff
font-0 = Terminus:size=12
modules-left = i3
modules-center = date
modules-right = pulseaudio memory

[module/i3]
type = internal/i3
format = <label-state>
label-focused = %name%
label-focused-foreground = #ffffff
label-focused-background = #ffbf00
label-unfocused = %name%
label-unfocused-foreground = #888888

[module/date]
type = internal/date
format = %Y-%m-%d %H:%M:%S
label = %date%

[module/pulseaudio]
type = internal/pulseaudio
format-volume = vol %percentage%%
label-volume = %percentage%%

[module/memory]
type = internal/memory
format = RAM %used%/%total%
EOF

# Write conky config
cat > "$CONFIG_DIR/conky/conky.conf" << 'EOF'
conky.config = {
    alignment = 'top_right',
    background = true,
    double_buffer = true,
    update_interval = 1.0,
    use_xft = true,
    font = 'Terminus:size=12',
    own_window = true,
    own_window_type = 'desktop',
    own_window_transparent = true,
    own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
    minimum_width = 300,
    default_color = '#ffffff',
    color1 = '#ffbf00',
    color2 = '#ff0000'
};

conky.text = [[
${color1}SYSTEM ${hr 2}
Host: $nodename
Kernel: $kernel
Uptime: $uptime

${color1}CPU ${hr 2}
CPU: ${cpu}%
${cpubar}

${color1}MEMORY ${hr 2}
RAM: $mem/$memmax
${membar}

${color1}DISK ${hr 2}
Root: ${fs_used /}/${fs_size /}
${fs_bar /}

${color1}NETWORK ${hr 2}
Up: ${upspeed enp0s3}
Down: ${downspeed enp0s3}
]]
EOF

# Write neofetch config
cat > "$CONFIG_DIR/neofetch/config.conf" << 'EOF'
display_distro=false
image_backend=ascii
ascii_distro="Debian"
ascii_colors=(4 1 3 7 7 3)
color_blocks="on"
bold="on"
underline="on"
EOF

# Create launch script for polybar
mkdir -p "$CONFIG_DIR/polybar"
cat > "$CONFIG_DIR/polybar/launch.sh" << 'EOF'
#!/bin/bash
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
polybar top &
EOF
chmod +x "$CONFIG_DIR/polybar/launch.sh"

# Create boot sound script
cat > "$BIN_DIR/boot-sound.sh" << 'EOF'
#!/bin/bash
mpv --no-video /home/deckard/.config/sounds/boot.ogg &
EOF
chmod +x "$BIN_DIR/boot-sound.sh"

# Create matrix lock script
cat > "$BIN_DIR/matrix-lock.sh" << 'EOF'
#!/bin/bash
xlock -mode matrix -fg green -bg black
EOF
chmod +x "$BIN_DIR/matrix-lock.sh"

echo "[ Done ] All config files written directly to /home/deckard/.config"
echo "Launch i3 and enjoy the retrofuture."
