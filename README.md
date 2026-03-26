<div align="center">

```
  ██████╗ ██████╗ ████████╗███████╗
 ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝
 ██║  ██║██║   ██║   ██║   ███████╗
 ██║  ██║██║   ██║   ██║   ╚════██║
 ██████╔╝╚██████╔╝   ██║   ███████║
 ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝
```

# Caelestia Dotfiles Override

**Hyprland + Caelestia on CachyOS**

A compact, glassy, productivity-focused rice with practical daily ergonomics.

![Hyprland](https://img.shields.io/badge/Hyprland-0.54-blue?style=flat-square&color=cba6f7)
![OS](https://img.shields.io/badge/CachyOS-Arch-blue?style=flat-square&color=89b4fa)
![Shell](https://img.shields.io/badge/Shell-Fish-blue?style=flat-square&color=a6e3a1)
![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square&color=f38ba8)

</div>

---

## About

This repository is my personal override layer for Caelestia.
It focuses on three things:

- visual polish without sacrificing readability
- fast keyboard-driven workflow for real daily use
- eye comfort for long sessions on a matte FHD panel

This repo is intentionally scoped to user overrides and helper scripts.
The upstream Caelestia base remains external at `~/.local/share/caelestia/`.

---

## Design Goals

- Persistent compact sidebar (no auto-hide)
- iOS-inspired glass style with clean spacing
- Fast glanceable workspace state using glyph markers
- Profile-based color comfort for coding, night, reading, and design
- Stable behavior on NVIDIA hybrid laptop setup

Current workspace markers:

- empty: `◌`
- occupied: `◎`
- active: `⬤`

---

## Platform

| Item | Value |
|---|---|
| OS | CachyOS (Arch) |
| WM | Hyprland 0.54 |
| Shell | fish + oh-my-posh |
| Bar / Shell UI | Caelestia (quickshell) |
| Theme | Catppuccin Mocha |
| Icons | Papirus-Dark |
| Cursor | Bibata-Modern-Ice |
| UI Font | SF Pro |
| Mono Font | GeistMono Nerd Font |
| Terminal | Foot |
| Launcher | Rofi |
| GPU | NVIDIA RTX 3050 + Intel UHD |
| Display | 15.6" FHD 144Hz matte panel |

---

## Feature Summary

- Hybrid tiling profile with practical floating exceptions
- Compact sidebar tuned for low visual noise
- Dashboard, lock, and bar overrides from `shell.json`
- Gamma profile switcher via `gsset`
- Automatic fallback to Hyprland shaders when Wayland gamma is unsupported
- Dedicated per-mode shader variants (`focus`, `night`, `morning`, `reading`, `neutral`)

---

## Repository Layout

```text
~/.config/caelestia/
├── shell.json                      # Caelestia UI overrides
├── hypr-user.conf                  # User Hyprland additions
├── hypr-vars.conf                  # Gesture/variable overrides
├── cli.json                        # CLI-side hooks
├── hypr/
│   ├── hybrid-layout.conf
│   ├── animations.conf
│   └── notifications.conf
├── gammastep/
│   ├── config.ini                  # Base profile
│   └── presets/
│       ├── focus.ini
│       ├── night.ini
│       ├── morning.ini
│       ├── reading.ini
│       ├── neutral.ini
│       ├── dawn.ini                # alias compatibility -> morning
│       └── night-owl.ini           # alias compatibility -> night
├── shaders/
│   ├── vibrancy.glsl               # default shader
│   ├── vibrancy-focus.glsl
│   ├── vibrancy-night.glsl
│   ├── vibrancy-morning.glsl
│   ├── vibrancy-reading.glsl
│   └── vibrancy-neutral.glsl
└── scripts/
    └── gammastep-preset.sh         # preset manager + fallback logic
```

---

## Daily Commands

```fish
# restart shell UI
caer

# inspect and apply color profile
gsset list
gsset current
gsset focus
gsset night
gsset morning
gsset reading
gsset neutral

# compatibility aliases
gsset dawn
gsset night-owl
gsset coding
gsset design
```

---

## Gamma Profiles

| Preset | Day / Night | Gamma | Typical Use |
|---|---:|---:|---|
| `focus` | 5400K / 4100K | 0.90 | coding and IDE work |
| `night` | 4300K / 2800K | 0.82 | night session, dim room |
| `morning` | 5000K / 3600K | 0.88 | warm start |
| `reading` | 4800K / 3400K | 0.86 | docs and writing |
| `neutral` | 6500K / 5000K | 0.96 | color-sensitive tasks |

---

## Keybinds

| Key | Action |
|---|---|
| `Alt + Tab` | Hyprexpo workspace overview |
| `Alt + Shift + Tab` | Rofi window switcher |
| `Super + P` | Display settings |
| `Super + Ctrl + D` | Toggle Do Not Disturb |
| `Ctrl + Shift + S` | Flameshot screenshot |
| `Super + Shift + F` | Pseudotile toggle |
| `Super + Shift + V` | Toggle split direction |
| `Super + Shift + Enter` | Swap with master |

---

## Troubleshooting

If `gsset` updates config but your display looks unchanged:

1. Check current mode:
   ```fish
   gsset current
   ```
2. Check active shader path:
   ```fish
   hyprctl -j getoption decoration:screen_shader
   ```
3. If gamma ramps are unsupported on your output, fallback shader mode is expected behavior.

---

## Notes

- This repository tracks user-level overrides, not full upstream Caelestia source.
- Hyprexpo is managed by `hyprpm`.
- Shader files use `#version 320 es` for Hyprland compatibility.
- After Hyprland upgrades, run `hyprpm update`.

