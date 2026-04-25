# AGENTS.md — Dotfiles Repository

Personal Hyprland dotfiles forked from ML4W Dotfiles, customized with Catppuccin Mocha theming.

**All `~/.config/*` directories are symlinks into this repo.** Always reference `dotfiles/config/…` paths, never `~/.config/`.

## Project Layout

```
dotfiles/config/          # 33 config directories, symlinked to ~/.config/
  hypr/                   # Hyprland WM — main config system
    hyprland.conf         # Entry point (sources everything via ~/.config/hypr/ paths)
    colors.conf           # Catppuccin Mocha color variables
    hyprtoolkit.conf      # Theme variables (ARGB hex) for hyprtoolkit apps
    scripts/              # 24 shell scripts (wallpaper, gamemode, keybindings, etc.)
    effects/wallpaper/    # 14 wallpaper effect presets (blur, blackwhite, negate variants)
    conf/                 # Modular configs — each sources a variation from its subdir
  hyprpanel/              # Status bar (JSON + SCSS) — active bar
  ml4w/                   # Helper scripts, listeners, settings (legacy ML4W infra)
    library.sh            # Shared logging: exports _writeLog() only
    listeners.sh          # Starts all listener scripts
    listeners/            # 2 listener scripts (gtk-theme-switcher, low-bat-notification)
    settings/             # 59 plain-text setting files (not scripts)
    scripts/              # 13 utility scripts
  opencode/               # OpenCode agent config (AGENTS.md, rules, agents, models)
  rofi/ waybar/ kitty/ alacritty/ swaync/ tmux/ walker/ ashell/ …
dotfiles.json             # System package dependencies manifest
opencode.json             # Root OpenCode config (model override only)
```

## Hyprland Module System

`hyprland.conf` uses `source =` to compose configs. Each `conf/*.conf` is a one-liner that sources a variation file from its subdirectory. To switch variations, change the `source` path in the parent conf.

| Module | Variations | Active |
|--------|-----------|--------|
| `conf/monitors/` | 12 | `highres.conf` |
| `conf/environments/` | 3 | `default.conf` |
| `conf/decorations/` | 10 | — |
| `conf/windows/` | 13 | — |
| `conf/animations/` | 10 | — |
| `conf/keybindings/` | 2 | `default.conf` |
| `conf/layouts/` | 2 | — |
| `conf/windowrules/` | 2 | — |
| `conf/workspaces/` | 1 | — |

Additional non-switchable conf files: `autostart.conf`, `cursor.conf`, `keyboard.conf`, `misc.conf`, `ml4w.conf`, `workspace.conf`, `custom.conf` (empty — user overrides go here).

**Note:** `hyprland.conf` sources via `~/.config/hypr/…` paths (symlink), not repo-relative paths.

## Build / Lint / Test

**None.** No test framework, no linters, no task runners, no Makefile.

### CI/CD

Single workflow: `.github/workflows/docs.yml` — deploys VitePress docs to GitHub Pages.
- Triggers on push to `main` branch (active branch is `master` — workflow currently unreachable)
- Commands: `bun install` → `bun run docs:build`
- Output: `docs/.vitepress/dist`

## Bash Script Conventions

~109 user-authored `.sh` files across the repo (plus ~70 in `tmux/plugins/` — gitignored dependencies).

**Target conventions** (inconsistently followed — treat as goals, not current state):

- Shebang: `#!/usr/bin/env bash` (3 scripts use `#!/bin/bash` instead)
- Quote variables: `"$var"` not `$var`
- Prefer `[[ ]]` over `[ ]`
- UPPERCASE for globals, `local` + lowercase for function locals
- Check file existence before sourcing: `[ -f ... ]`
- `library.sh` provides `_writeLog()` — only 1 script currently sources it

## Config File Conventions

- **Hyprland `.conf`**: 2-space indent, `$camelCase` variables, `bind = MOD, KEY, dispatcher, arg`
- **JSON**: 2-space indent, no trailing commas
- **Naming**: kebab-case for scripts and config files, lowercase directories

## Git

- Single branch: `master` (never force push)
- Conventional commits: `type(scope): description` with emojis
  - Types: `feat`, `fix`, `style`, `chore`, `docs`, `refactor`
  - Scopes: component name (`hyprland`, `wallpaper`, `ashell`, `hyprpanel`, etc.)
- 1 submodule: `alacritty/themes` (HTTPS)
  - Init with: `git submodule update --init --recursive`

## Wallpaper System

hyprpaper (backend) → waypaper (manager, folder: `~/Pictures/wallpapers`) → `wallpaper.sh` (post-command: caching, blur effects). Cache: `~/.cache/ml4w/hyprland-dotfiles/`.

## Key Dependencies

Declared in `dotfiles.json`: hyprland, hyprctl, hyprpaper, hypridle, hyprlock, hyprpanel, hyprlauncher, rofi, alacritty, waypaper, swaync, wl-clipboard, inotify-tools, jq, pavucontrol, brightnessctl, playerctl, gamemode.

## OpenCode Setup

Config at `dotfiles/config/opencode/`:
- `opencode.jsonc` — main config (model, MCP servers, agents, instruction rules)
- `rules/code-implementation.md` — **never run build/test commands; never uncomment code without permission**
- `rules/commit-guidelines.md` — conventional commits with emojis; never stage new files
- `agents/ask.md` — read-only research agent (web search, no file edits)
- `agents/debug.md` — read-only troubleshooter (searches online first, runs diagnostic commands, cites sources)
- `agents/scout.md` — read-only idea explorer (researches libraries, compares approaches, recommends options)
- `agents/designer.md` — read-only UI/UX advisor (specific colors, spacing, CSS/config snippets, accessibility)
- `agents/xposter.md` — X/Twitter poster (drafts tweets, posts after approval via agent-twitter-client-mcp)
- `agents/slave.md` — passive executor (does exactly what told, LSP verification)
- Hermes agent — git specialist with `git-master` skill (see `AGENTS.md` in opencode dir)
- `oh-my-openagent.json` — model mappings for agent categories (GitHub Copilot models)
