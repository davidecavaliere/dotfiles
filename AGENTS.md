# AGENTS.md — Dotfiles Repository Guidelines

## Repository Overview

Personal Hyprland dotfiles forked from ML4W Dotfiles, customized with Catppuccin Mocha theming. All configuration lives under `dotfiles/config/` and is symlinked into `~/.config/`.

**IMPORTANT:** All `~/.config/*` directories are symlinks into this repo. When working with configs, always reference paths relative to this repo (e.g., `dotfiles/config/hypr/...`), NOT `~/.config/`.

## Project Structure

```
dotfiles/
  config/
    hypr/           # Hyprland WM (entry: hyprland.conf, modular via source)
    hyprpanel/      # Status bar (JSON + SCSS)
    waybar/         # Alternative status bar
    rofi/           # App launcher (.rasi files)
    kitty/          # Terminal (with alacritty-theme submodule)
    alacritty/      # Alternative terminal
    ml4w/           # Helper scripts, listeners, settings, wallpapers
    swaync/         # Notification center
    wlogout/        # Logout menu (with catppuccin submodule)
    waypaper/       # Wallpaper manager
    tmux/           # Terminal multiplexer
    walker/         # App launcher
    ashell/         # Shell panel
    ...             # GTK, Qt6, starship, ohmyposh, etc.
dotfiles.json       # System dependencies manifest (package.json-style)
```

## Hyprland Configuration Architecture

Entry point: `dotfiles/config/hypr/hyprland.conf` — uses `source` to compose modular configs:

```
hyprland.conf
  → conf/monitor.conf → conf/monitors/highres.conf
  → conf/environment.conf → conf/environments/default.conf
  → conf/keybinding.conf → conf/keybindings/default.conf
  → conf/decoration.conf → conf/decorations/default.conf
  → conf/window.conf → conf/windows/default.conf
  → conf/animation.conf → conf/animations/default.conf
  → conf/layout.conf → conf/layouts/default.conf
  → conf/autostart.conf, conf/misc.conf, conf/ml4w.conf, etc.
  → colors.conf (Catppuccin Mocha variables)
  → conf/custom.conf (user overrides, currently empty)
```

**Switchable variations** exist for monitors (12), environments (3), decorations (10), windows/borders (13), animations (10), keybindings (2), and layouts (2). Change the `source` line in the parent conf to swap.

## Build / Lint / Test

### No formal build, lint, or test infrastructure exists.

- **No test framework** — zero test files, no bats, no pytest, no jest
- **No linters configured** — no shellcheck, shfmt, prettier, or editorconfig
- **No task runners** — no Makefile, justfile, or Taskfile

### CI/CD

Single workflow: `.github/workflows/docs.yml`
- Triggers on push to `main` (note: active branch is `master`)
- Uses Bun + Node.js 20 + VitePress to build and deploy docs to GitHub Pages

### Documentation (if working on docs/)

```bash
bun install          # Install deps
bun run docs:dev     # Run dev server
bun run docs:build   # Build static site
```

## Code Style Guidelines

### Bash Scripts (`.sh`) — Primary language, 70+ scripts

- **Shebang:** Always `#!/usr/bin/env bash`
- **Variables:** UPPERCASE for globals, lowercase for locals
- **Quoting:** Always quote variables: `"$var"`, not `$var`
- **Conditionals:** Use `[[ ]]` over `[ ]`, `==` for string comparison
- **Functions:** Define before use, use `local` for scope
- **Error handling:** Check file existence with `[ -f ... ]` before sourcing/reading
- **Logging:** Source `library.sh` from `~/.config/ml4w/` for `_writeLog` and `_writeError`
- **No comments on obvious code** — only explain non-obvious logic
- **No emojis in scripts** unless part of user-facing output (notifications)

### Hyprland Configs (`.conf`)

- **Indentation:** 2 spaces
- **Variables:** `$variableName` (camelCase), defined before use
- **Comments:** Use `#` for section headers and explanations
- **Binding format:** `bind = MOD, KEY, dispatcher, arg`
- **Conventional modifiers:** `$mainMod` (SUPER), `$mainMod SHIFT`, `$mainMod CTRL`, `$mainMod ALT`

### JSON Configs

- 2-space indentation
- Trailing commas: NOT allowed
- Keys: camelCase or snake_case (follow existing file convention)

### TOML Configs

- Follow existing file patterns (starship.toml, walker, rio, ashell)
- Group related settings under `[section]` headers

### RASI (Rofi) Configs

- Use `*` selector for global styles
- Follow Catppuccin color variable references from included themes

### Naming Conventions

- **Scripts:** kebab-case (`wallpaper-restore.sh`, `set-window-width.sh`)
- **Config files:** kebab-case or descriptive (`default.conf`, `highres.conf`)
- **Hyprland variables:** camelCase (`$mainMod`, `$ml4w_cache_folder`)
- **Directories:** lowercase, no spaces

## Git Workflow

### Commit Messages — Conventional Commits

```
type(scope): description
```

**Types used:** `fix`, `feat`, `style`, `chore`, `docs`, `refactor`
**Scopes:** `hyprland`, `ashell`, `wallpaper`, `hyprpanel`, `waybar`, etc.

Examples:
```
fix(wallpaper): remove status bar reload on wallpaper change
style(hyprland): update to 0.54 settings + minor style adjustments
chore: get rid of matugen
```

### Branch Strategy

- Active branch: `master`
- No feature branches currently in use
- NEVER force push to `master`

### Git Submodules (2)

1. `dotfiles/config/alacritty/themes` → alacritty/alacritty-theme
2. `dotfiles/config/wlogout/themes/catppuccin` → catppuccin/wlogout

Always initialize and update submodules: `git submodule update --init --recursive`

## Key File Locations

| Purpose | Path |
|---------|------|
| Hyprland entry | `dotfiles/config/hypr/hyprland.conf` |
| Color variables | `dotfiles/config/hypr/colors.conf` |
| Theme variables | `dotfiles/config/hypr/hyprtoolkit.conf` |
| Wallpaper config | `dotfiles/config/hypr/hyprpaper.conf` |
| Waypaper config | `dotfiles/config/waypaper/config.ini` |
| Keybindings | `dotfiles/config/hypr/conf/keybindings/default.conf` |
| Autostart apps | `dotfiles/config/hypr/conf/autostart.conf` |
| Hypr scripts | `dotfiles/config/hypr/scripts/` (24 scripts) |
| ML4W library | `dotfiles/config/ml4w/library.sh` |
| Dependencies | `dotfiles.json` |

## Wallpaper System

- **Backend:** hyprpaper (configured in `hyprpaper.conf`)
- **Manager:** waypaper (config at `waypaper/config.ini`, folder: `~/Pictures/wallpapers`)
- **Post-command:** runs `wallpaper.sh` which handles caching, blur effects, matugen theming
- **Effects:** 14 presets in `conf/effects/wallpaper/` (blur, blackwhite, negate variants)
- **Cache:** `~/.cache/ml4w/hyprland-doticons/` (generated wallpapers, blurred versions)

## Dependencies

System packages declared in `dotfiles.json`. Key tools:
- hyprland, hyprctl, hyprpaper, hypridle, hyprlock
- waypaper, rofi, alacritty, kitty
- hyprpanel, swaync, wl-clipboard, inotify-tools
- pavucontrol, brightnessctl, playerctl, gamemode
