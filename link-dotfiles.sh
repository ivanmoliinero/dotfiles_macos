#!/usr/bin/env bash
# link-dotfiles.sh
# Creates symbolic links (soft links) from dotfiles repository to standard macOS locations.
# Safely replaces existing hard links or copies without modifying repository files.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=0

usage() {
  cat << EOF
Usage: $0 [OPTIONS]

Options:
  -d, --dry-run    Preview linking actions without making changes
  -h, --help       Show this help message
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -d|--dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
done

link_resource() {
  local source_file="$1"
  local target_path="$2"

  if [ ! -e "$source_file" ]; then
    echo "[SKIP] Source file does not exist: $source_file"
    return 0
  fi

  local target_dir
  target_dir="$(dirname "$target_path")"

  # Check if target is already a valid symlink to source
  if [ -L "$target_path" ]; then
    local current_target
    current_target="$(readlink "$target_path")"
    if [ "$current_target" = "$source_file" ]; then
      echo "[OK] Symlink already in place: $target_path -> $source_file"
      return 0
    fi
  fi

  # Detect and handle existing files or hard links
  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    local nlinks
    nlinks=$(stat -f "%l" "$target_path" 2>/dev/null || echo 1)
    if [ "$nlinks" -gt 1 ]; then
      echo "[CONVERT] Unlinking hard link (inode count $nlinks): $target_path"
    else
      echo "[REPLACE] Overwriting existing path: $target_path"
    fi

    if [ "$DRY_RUN" -eq 0 ]; then
      rm -f "$target_path"
    fi
  fi

  # Create destination directory and symlink
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "[DRY-RUN] mkdir -p '$target_dir' && ln -s '$source_file' '$target_path'"
  else
    mkdir -p "$target_dir"
    ln -s "$source_file" "$target_path"
    echo "[LINK] Created soft link: $target_path -> $source_file"
  fi
}

echo "=== Dotfiles Symlink Manager (Branch: main) ==="
echo "Repository path: $DOTFILES_DIR"

# 1. AeroSpace (only ~/.aerospace.toml to prevent ambiguous config error)
link_resource "$DOTFILES_DIR/aerospace/.aerospace.toml" "$HOME/.aerospace.toml"
rm -f "$HOME/.config/aerospace/aerospace.toml" 2>/dev/null || true
link_resource "$DOTFILES_DIR/aerospace/scripts/change-aerospace-workspace.sh" "$HOME/.config/aerospace/scripts/change-aerospace-workspace.sh"
link_resource "$DOTFILES_DIR/aerospace/scripts/create-aerospace-workspace.sh" "$HOME/.config/aerospace/scripts/create-aerospace-workspace.sh"
link_resource "$DOTFILES_DIR/aerospace/scripts/eliminate-aerospace-workspace.sh" "$HOME/.config/aerospace/scripts/eliminate-aerospace-workspace.sh"

# Ensure aerospace scripts have execute permissions
if [ "$DRY_RUN" -eq 0 ]; then
  chmod +x "$DOTFILES_DIR"/aerospace/scripts/*.sh 2>/dev/null || true
fi

# 2. Hammerspoon
link_resource "$DOTFILES_DIR/hammerspoon/init.lua" "$HOME/.hammerspoon/init.lua"

# 3. Ghostty
link_resource "$DOTFILES_DIR/ghostty/config.ghostty" "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
link_resource "$DOTFILES_DIR/ghostty/config.ghostty" "$HOME/.config/ghostty/config"

# 4. Zsh & Powerlevel10k
link_resource "$DOTFILES_DIR/zshrc/.zshrc" "$HOME/.zshrc"
link_resource "$DOTFILES_DIR/zshrc/.p10k.zsh" "$HOME/.p10k.zsh"

# 5. Neovim (LazyVim)
link_resource "$DOTFILES_DIR/neovim/lazy.lua" "$HOME/.config/nvim/lua/config/lazy.lua"
link_resource "$DOTFILES_DIR/neovim/colorscheme.lua" "$HOME/.config/nvim/lua/plugins/colorscheme.lua"

echo "=== Symlink setup completed successfully ==="
