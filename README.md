## My Personal Dotfiles

This repository contains my personal Hyprland configuration, originally forked from the **ML4W Dotfiles** project. Over time I’ve stripped out features I don’t use or like, added custom scripts and new functionality, and tailored everything to my workflow.

### Tracking Dependencies
All required system packages and tools are declared in `dotfiles.json` (inspired by a typical `package.json`). Before using these configs, install the dependencies listed there so each component (Hyprland, Ashell, hyprlauncher, scripts, etc.) will work correctly.

### Repository Structure
```
dotfiles/                       # All XDG config subfolders
  config/
    hypr/                       # Hyprland configs (input, autostart, themes)
    ashell/                     # Ashell status bar configuration
    ml4w/                       # ML4W scripts & listeners (legacy)
    waybar/                     # Waybar config (for fallback)
 hyprtoolkit.conf               # Theme variables for hyprtoolkit apps
 colors.conf                    # Hyprland color variables (Catppuccin Mocha)
 dotfiles.json                  # SystemDependencies manifest
 README.md                      # This file
```

### Setup
> **Note:** All config directories must be symlinked into your `~/.config/` manually.

```bash
# Clone repo
git clone https://github.com/yourusername/your-dotfiles.git ~/my-dotfiles

# Create symlinks
ln -s ~/my-dotfiles/dotfiles/config/hypr ~/.config/hypr
ln -s ~/my-dotfiles/dotfiles/config/ashell ~/.config/ashell
ln -s ~/my-dotfiles/hyprtoolkit.conf ~/.config/hypr/hyprtoolkit.conf
ln -s ~/my-dotfiles/colors.conf ~/.config/hypr/colors.conf

# Install dependencies listed in dotfiles.json (manual or via helper script)
# Reload Hyprland and restart Ashell/hyprlauncher
```

Enjoy your customized Hyprland setup!
and many more...
