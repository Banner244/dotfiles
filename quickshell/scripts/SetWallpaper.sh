#!/usr/bin/env bash

# are the params there?
if [ -z "$1" ]; then
    echo "❌ Fehler: Bitte gib den Pfad zum Wallpaper als Argument an."
    echo "Beispiel: ./set-wallpaper.sh /home/user/Pictures/Wallpapers/bild.jpg"
    exit 1
fi

WALLPAPER_PATH="$1"
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"

# folder exists?
mkdir -p "$(dirname "$CONFIG_FILE")"

# override config
cat > "$CONFIG_FILE" <<EOF
preload = $WALLPAPER_PATH
wallpaper = , $WALLPAPER_PATH
splash = false
EOF

# preview
echo "new hyprpaper.conf written:"
cat "$CONFIG_FILE"

# Hyprpaper reload
echo "Hyprpaper reloading..."
hyprctl hyprpaper reload ,"$WALLPAPER_PATH"

