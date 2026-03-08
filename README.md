<div align="center">

```
  ██████╗ ██████╗ ████████╗███████╗
 ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝
 ██║  ██║██║   ██║   ██║   ███████╗
 ██║  ██║██║   ██║   ██║   ╚════██║
 ██████╔╝╚██████╔╝   ██║   ███████║
 ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝
```

**hyprland · caelestia · catppuccin mocha**

![Hyprland](https://img.shields.io/badge/Hyprland-0.54-blue?style=flat-square&color=cba6f7)
![OS](https://img.shields.io/badge/CachyOS-Arch-blue?style=flat-square&color=89b4fa)
![Shell](https://img.shields.io/badge/Shell-Fish-blue?style=flat-square&color=a6e3a1)
![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square&color=f38ba8)

</div>

---

<!-- Replace with actual screenshot -->
> 📸 *screenshot goes here*

---

## system

| | |
|---|---|
| **OS** | CachyOS (Arch) |
| **WM** | Hyprland 0.54 |
| **Shell** | fish + oh-my-posh (M365Princess) |
| **Bar / Shell** | Caelestia (quickshell) |
| **Theme** | Catppuccin Mocha |
| **Icons** | Papirus-Dark |
| **Cursor** | Bibata-Modern-Ice |
| **Font (UI)** | SF Pro |
| **Font (Mono)** | GeistMono Nerd Font |
| **Terminal** | Foot |
| **Launcher** | Rofi |
| **GPU** | NVIDIA RTX 3050 + Intel UHD (hybrid) |
| **Display** | Chimei Innolux 15.6" FHD 144Hz (matte) |

---

## highlights

- **Hybrid tiling** — dwindle layout with pseudotile + float rules for common apps
- **Workspace labels** — `ε` empty · `λ` occupied · `Ω` active
- **Hyprexpo** — Alt+Tab mission control overview (managed via hyprpm)
- **Screen shader** — GLSL vibrancy boost tuned for 62.5% sRGB matte panel
- **Gammastep presets** — `gsset focus` / `night-owl` / `dawn` / `neutral`
- **Transparent bar** — 72% base opacity, compact 22px inner width
- **NVIDIA fixes** — `AQ_DRM_DEVICES`, software cursors, VRR disabled

---

## structure

```
~/.config/caelestia/
├── hypr-user.conf          # Hyprland user additions (cursor, GPU, keybinds)
├── hypr-vars.conf          # Gesture variable overrides
├── shell.json              # Caelestia bar / lock / dashboard config
├── cli.json                # Wallpaper post-hook
└── hypr/
    ├── hybrid-layout.conf  # Tiling layout + float rules
    ├── animations.conf     # Animation overrides
    └── notifications.conf  # Notification config

~/.config/hypr/
├── shaders/
│   └── vibrancy.glsl       # Screen saturation/contrast shader
└── scripts/
    └── gammastep-preset.sh # Night light preset switcher

~/.config/gammastep/
├── config.ini              # Main config (5200K/3600K, tuned for matte panel)
└── presets/
    ├── focus.ini           # 5200K/3800K — daytime coding
    ├── night-owl.ini       # 4500K/2700K — late night
    ├── dawn.ini            # 5000K/3500K — morning
    └── neutral.ini         # 6500K/5000K — color-accurate work
```

---

## keybinds

| Key | Action |
|---|---|
| `Alt + Tab` | Hyprexpo workspace overview |
| `Alt + Shift + Tab` | Rofi window switcher |
| `Super + P` | Display settings (nwg-displays) |
| `Super + Ctrl + D` | Toggle Do Not Disturb |
| `Ctrl + Shift + S` | Flameshot screenshot |
| `Super + Shift + F` | Pseudotile toggle |
| `Super + Shift + V` | Toggle dwindle split direction |
| `Super + Shift + Enter` | Swap with master window |

---

## gammastep presets

```fish
gsset focus      # daytime   — 5200K, γ0.88
gsset night-owl  # late night — 4500K, γ0.75
gsset dawn       # morning   — 5000K, γ0.80
gsset neutral    # design    — 6500K, γ0.95
```

---

## notes

- This repo only contains **user overrides** — the base Caelestia config lives in `~/.local/share/caelestia/` (do not edit)
- Hyprexpo is managed by **hyprpm**, not via `plugin =` in config
- Screen shader uses `#version 320 es` — required for Hyprland screen shaders on NVIDIA
- After any Hyprland update, run `hyprpm update` to rebuild plugins
- Caelestia shell restart: `caer` (fish alias → `caelestia shell -k && caelestia shell -d`)

