# ML4W Dotfiles for Hyprland - Project Context

## Project Overview

ML4W Dotfiles for Hyprland is an advanced configuration of the Hyprland dynamic tiling window manager for Arch Linux-based distributions. This project provides a comprehensive desktop environment with adaptive material color themes based on selected wallpapers for all components. It includes a curated selection of applications with customizable configurations to suit personal needs.

The project is maintained by MyLinuxForWork (ML4W) and offers a full-featured desktop environment built around Hyprland, featuring:
- Adaptive material color themes based on wallpapers
- Comprehensive app selection with customization capabilities
- Support for multiple Linux distributions (Arch, Fedora, openSUSE Tumbleweed)
- Automated installation via the Dotfiles Installer (available on Flathub)

## Project Structure

The repository contains:
- `dotfiles/` - Main configuration files for Hyprland, terminals, shells, and various applications
- `docs/` - Documentation files (managed via VitePress)
- `.github/` - GitHub workflow configurations
- Various configuration files for development and documentation

Key configuration directories include:
- `hypr/` - Hyprland window manager configurations
- `waybar/` - Waybar panel configurations
- `kitty/` - Kitty terminal configurations
- `rofi/` - Application launcher configurations
- `wlogout/` - Logout menu configurations
- `swaync/` - Notification center configurations
- And many more application-specific configurations

## Technologies Used

- **Window Manager**: Hyprland (dynamic tiling WM)
- **Documentation**: VitePress (static site generator)
- **Package Manager**: Bun (JavaScript runtime)
- **Icons**: Devicon (development technology icons)
- **Shell Configurations**: Bash and Zsh
- **Terminal**: Kitty (default), with support for others
- **Display Server**: Wayland

## Building and Running

The project is designed to be installed as a complete desktop environment rather than built in the traditional sense. Installation is typically done through:

1. **Dotfiles Installer** (recommended):
   - Available on Flathub
   - Uses installation URLs provided in the README

2. **Manual Installation**:
   - Follow the setup scripts included for Arch Linux, Fedora, and openSUSE Tumbleweed
   - For other distributions, install dependencies manually following the documentation

3. **Development/Documentation**:
   ```bash
   # Install dependencies
   bun install
   
   # Run documentation locally
   bun run docs:dev
   
   # Build documentation
   bun run docs:build
   ```

## Development Conventions

- **Versioning**: The project follows semantic versioning as evidenced by the detailed changelog
- **Documentation**: Maintained in the `docs/` directory using VitePress
- **Licensing**: GPLv3 license
- **Code of Conduct**: Contributor Covenant Code of Conduct is enforced
- **Contributions**: Welcome via pull requests with proper attribution

## Key Features

- Dynamic tiling window management with Hyprland
- Adaptive theming based on wallpapers
- Comprehensive application ecosystem
- Cross-distribution support (Arch, Fedora, openSUSE)
- Automated installation and update mechanisms
- Modular configuration system
- Integration with various tools (waybar, rofi, kitty, etc.)

## Special Components

- **ML4W Settings App**: GTK4-based configuration application
- **ML4W Welcome App**: GTK4-based welcome and information application
- **Theme Selector**: Global theme support accessible via CTRL+ALT+T
- **Wallpaper Engine**: swww as the default wallpaper engine
- **Notification Center**: swaync with dark/light theme support

## Installation Notes

The project supports multiple Linux distributions with specific setup scripts:
- Arch Linux (with AUR helpers like yay or paru)
- Fedora (with COPR repository support)
- openSUSE Tumbleweed

For other distributions, manual dependency installation is required following the documentation at https://mylinuxforwork.github.io/dotfiles/

## Project History

Based on the changelog, this is an actively maintained project with regular updates focusing on:
- Hyprland compatibility improvements
- New themes and visual enhancements
- Performance optimizations
- Feature additions and bug fixes
- Cross-distribution support expansion

The project has evolved significantly since version 2.8, with major changes including the transition to swww as the default wallpaper engine, adoption of Kitty as the default terminal, and implementation of adaptive theming capabilities.