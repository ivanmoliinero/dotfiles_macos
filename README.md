# Dotfiles ivanmoliinero MacOS
This repository contains the config files for some of the utilites of the MacOS dev platform of ivanmoliinero.
References taken from https://github.com/agenttank/dotfiles_macos

## Raycast
Improved Spotlight with better shortcut management, extensions for better integration with some utils and more.
Better app uninstallation (instead of dragging into recycle bin, uninstall app + extra files).

## AeroSpace
Tile manager for MacOS, inspired in i3 for Linux.

## Browser
The browser currently being used is **qutebrowser** (installed via Homebrew). Vim like, accessible with keyboard.

## Terminal
Ghostty terminal. Fast, written in Zig. I am using Starship to make the initial shell prompt more custom. I have not modified it in depth although for the moment.

## Sketchybar
New bar to see stats and other configurations for AeroSpace workspaces of the system.
NOTE: Currently not being used. I am using Stats.app (via Homebrew) to retrieve system stats.

## JankyBorders
Paints the borders of the actual selected window being focused.
https://github.com/FelixKratz/JankyBorders

## Nix Package Manager
Allows to have utils and commands without directly installing them on the system. Useful for smoke tests with uncommonly used utilities.
Planning on switching to NixOS (OS based entirely on this) on my desktop in the near future.
