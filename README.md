# Dotfiles ivanmoliinero MacOS
This repository contains the config files for some of the utilites of the MacOS dev platform of ivanmoliinero.
References taken from https://github.com/agenttank/dotfiles_macos

## Raycast
Improved Spotlight with better shortcut management, extensions for better integration with some utils and more.
Better app uninstallation (instead of dragging into recycle bin, uninstall app + extra files).

## AeroSpace
Tile manager for MacOS, inspired in i3 for Linux.

## Browser
The browser currently being used is Zen Browser, a fork of Mozilla Firefox. 
I was only using qutebrowser given that the previous browser I used (Orion) had some problems with AeroSpace tiling management, and qutebrowser supported vim-like shortcuts.
Vim-like shortcuts are good for some tasks and can accelerate the workflow, but generally moving inside website with the keyboard is a little bit odd for me. For now I am sticking with normal navigation.

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

## Automator shortcut to open Ghostty in finder
Whenever I am navigating through the finder and I want to quickly open a terminal inside a directory, I have to do it with the mouse by searching the respective button, which is hidden. Too slow.
With the Automator workflow included in this repo, with any desired shortcut the terminal is open. In the respective directory there is a CONFIG.md explaining how to set it up.

## Oh My Zsh
Zsh is not that bad, but this tool can really enhance its utils.
I am using some manual configuration. Check the specific directory in order to setup this util.

Planning on switching to NixOS (OS based entirely on this) on my desktop in the near future.
