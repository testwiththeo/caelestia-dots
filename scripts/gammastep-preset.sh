#!/usr/bin/env bash
set -euo pipefail

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

PRESET_DIR="$CONFIG_HOME/gammastep/presets"
ACTIVE_CONFIG="$CONFIG_HOME/gammastep/config.ini"
STATE_FILE="$STATE_HOME/gammastep-preset"
BACKEND_FILE="$STATE_HOME/gammastep-backend"
SHADER_DIR="$CONFIG_HOME/hypr/shaders"

CANONICAL_PRESETS=(focus night morning neutral reading)

preset_desc() {
    case "$1" in
        focus) echo "Coding mode (clear, balanced warmth)" ;;
        night) echo "Night mode (low strain, warm)" ;;
        morning) echo "Morning mode (soft warm start)" ;;
        neutral) echo "Color check mode (more accurate)" ;;
        reading) echo "Reading mode (extra eye comfort)" ;;
        *) echo "Custom mode" ;;
    esac
}

resolve_preset() {
    case "${1:-}" in
        ""|-h|--help|help) echo "__help" ;;
        list|ls|--list) echo "__list" ;;
        current|status|--current) echo "__current" ;;
        focus|coding) echo "focus" ;;
        night|night-mode|nightmode|night-owl) echo "night" ;;
        morning|dawn|sunrise) echo "morning" ;;
        neutral|design|accurate) echo "neutral" ;;
        reading|relax|eyecare|eye-care) echo "reading" ;;
        *) echo "__unknown:$1" ;;
    esac
}

extract_value() {
    local key="$1"
    local file="$2"
    awk -F '=' -v k="$key" '$1==k {gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2; exit}' "$file"
}

show_list() {
    echo "Available presets:"
    for p in "${CANONICAL_PRESETS[@]}"; do
        printf "  %-8s - %s\n" "$p" "$(preset_desc "$p")"
    done
    echo ""
    echo "Aliases:"
    echo "  coding -> focus"
    echo "  night-owl -> night"
    echo "  dawn -> morning"
    echo "  design -> neutral"
    echo "  relax -> reading"
}

show_current() {
    local active="unknown"
    local backend="unknown"

    if [ -f "$STATE_FILE" ]; then
        active="$(cat "$STATE_FILE")"
    fi

    if [ -f "$BACKEND_FILE" ]; then
        backend="$(cat "$BACKEND_FILE")"
    fi

    if [ -f "$ACTIVE_CONFIG" ]; then
        local d n g
        d="$(extract_value temp-day "$ACTIVE_CONFIG")"
        n="$(extract_value temp-night "$ACTIVE_CONFIG")"
        g="$(extract_value gamma "$ACTIVE_CONFIG")"
        echo "Current preset: $active"
        echo "Backend: $backend"
        echo "Current values: day=${d}K night=${n}K gamma=${g}"
    else
        echo "Current preset: $active"
        echo "Backend: $backend"
        echo "No active config found at $ACTIVE_CONFIG"
    fi
}

show_usage() {
    echo "Usage: gammastep-preset <preset|list|current>"
    echo ""
    show_list
    echo ""
    show_current
}

write_state() {
    mkdir -p "$STATE_HOME"
    echo "$1" > "$STATE_FILE"
    echo "$2" > "$BACKEND_FILE"
}

supports_wayland_gamma() {
    local target="$1"
    local probe

    if ! command -v gammastep >/dev/null 2>&1; then
        return 1
    fi

    probe="$(timeout 2 gammastep -v -P -m wayland -O "$target" 2>&1 || true)"

    if printf '%s' "$probe" | grep -qi "Zero outputs support gamma adjustment"; then
        return 1
    fi

    if printf '%s' "$probe" | grep -qi "do not support gamma adjustment"; then
        return 1
    fi

    return 0
}

restart_gammastep() {
    pkill -x gammastep 2>/dev/null || true
    pkill -f gammastep-indicator 2>/dev/null || true
    sleep 0.2

    nohup gammastep -c "$ACTIVE_CONFIG" >/dev/null 2>&1 &
}

apply_shader_fallback() {
    local preset="$1"
    local shader="$SHADER_DIR/vibrancy-${preset}.glsl"
    local base_shader="$SHADER_DIR/vibrancy.glsl"

    if [ ! -f "$shader" ]; then
        shader="$base_shader"
    fi

    pkill -x gammastep 2>/dev/null || true
    pkill -f gammastep-indicator 2>/dev/null || true

    if command -v hyprctl >/dev/null 2>&1; then
        hyprctl keyword decoration:screen_shader "$shader" >/dev/null
        write_state "$preset" "shader"
        echo "Applied preset: $preset"
        echo "Backend: shader fallback"
        echo "Shader: $shader"
    else
        write_state "$preset" "none"
        echo "warning: hyprctl not found, could not apply shader fallback"
        exit 1
    fi
}

apply_preset() {
    local preset="$1"
    local file="$PRESET_DIR/$preset.ini"

    if [ ! -f "$file" ]; then
        echo "error: preset file not found: $file"
        exit 1
    fi

    cp "$file" "$ACTIVE_CONFIG"

    local target
    target="$(extract_value temp-night "$file")"

    if supports_wayland_gamma "$target"; then
        restart_gammastep

        if command -v hyprctl >/dev/null 2>&1 && [ -f "$SHADER_DIR/vibrancy.glsl" ]; then
            hyprctl keyword decoration:screen_shader "$SHADER_DIR/vibrancy.glsl" >/dev/null 2>&1 || true
        fi

        write_state "$preset" "gammastep"

        local d n g
        d="$(extract_value temp-day "$file")"
        n="$(extract_value temp-night "$file")"
        g="$(extract_value gamma "$file")"

        echo "Applied preset: $preset"
        echo "Backend: gammastep"
        echo "Values: day=${d}K night=${n}K gamma=${g}"
    else
        apply_shader_fallback "$preset"
    fi
}

choice="$(resolve_preset "${1:-}")"
case "$choice" in
    __help)
        show_usage
        ;;
    __list)
        show_list
        ;;
    __current)
        show_current
        ;;
    __unknown:*)
        echo "error: preset '${choice#__unknown:}' not recognized"
        echo "run: gammastep-preset list"
        exit 1
        ;;
    *)
        apply_preset "$choice"
        ;;
esac
