#!/bin/bash
# gammastep-preset — switch gammastep presets on the fly
# usage: gammastep-preset [focus|night-owl|dawn|neutral]
# if no arg, shows current preset

PRESET_DIR="$HOME/.config/gammastep/presets"
ACTIVE_LINK="$HOME/.config/gammastep/config.ini"
STATE_FILE="$HOME/.local/state/gammastep-preset"

show_usage() {
    echo "usage: gammastep-preset [focus|night-owl|dawn|neutral]"
    echo ""
    echo "presets:"
    echo "  focus     — sesi ngoding siang (5500K/4000K, γ0.85)"
    echo "  night-owl — late night grind  (4500K/2700K, γ0.75)"
    echo "  dawn      — pagi sebelum kopi (5000K/3500K, γ0.80)"
    echo "  neutral   — design/color work (6500K/5000K, γ0.95)"
    echo ""
    if [ -f "$STATE_FILE" ]; then
        echo "current: $(cat "$STATE_FILE")"
    fi
}

if [ -z "$1" ]; then
    show_usage
    exit 0
fi

PRESET="$1"
PRESET_FILE="$PRESET_DIR/$PRESET.ini"

if [ ! -f "$PRESET_FILE" ]; then
    echo "error: preset '$PRESET' not found"
    echo "available: focus, night-owl, dawn, neutral"
    exit 1
fi

# stop current instance
pkill gammastep 2>/dev/null
pkill -f gammastep-indicator 2>/dev/null
sleep 0.3

# apply preset
cp "$PRESET_FILE" "$ACTIVE_LINK"
echo "$PRESET" > "$STATE_FILE"

# restart indicator (it will spawn gammastep)
nohup gammastep-indicator > /dev/null 2>&1 &

echo "✓ preset switched to: $PRESET"
