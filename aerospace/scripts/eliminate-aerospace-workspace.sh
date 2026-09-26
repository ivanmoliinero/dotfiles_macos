#!/bin/bash
set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Aerospace: Remove Workspace
# @raycast.mode compact
# @raycast.argument1 {"type": "text", "placeholder": "Workspace name"}

# Optional parameters:
# @raycast.icon ➖
# @raycast.packageName Aerospace

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

WORKSPACE_NAME=$(echo "$1" | tr '[:lower:]' '[:upper:]')
if [ -z "$WORKSPACE_NAME" ]; then
  echo "Usage: $0 <workspace-name>"
  exit 1
fi

WINDOWS=$(aerospace list-windows --workspace "$WORKSPACE_NAME" 2>/dev/null || true)
if [ -n "$WINDOWS" ]; then
  echo "Error: workspace '$WORKSPACE_NAME' has windows open. Move them out first."
  exit 1
fi

python3 - "$WORKSPACE_NAME" << 'EOF'
import sys, re, pathlib

name = sys.argv[1].strip()

# Target configuration files to keep synchronized
candidate_paths = [
    pathlib.Path.home() / '.aerospace.toml',
    pathlib.Path.home() / '.config/aerospace/aerospace.toml',
    pathlib.Path.home() / 'setup-config/dotfiles_macos/aerospace/.aerospace.toml',
]

processed_files = set()

for path in candidate_paths:
    if not path.exists():
        continue
    resolved = path.resolve()
    if resolved in processed_files:
        continue
    processed_files.add(resolved)

    raw = path.read_text(encoding='utf-8')

    # 1. Update persistent-workspaces array
    match = re.search(r'(^\s*persistent-workspaces\s*=\s*)\[(.*?)\]', raw, re.MULTILINE | re.DOTALL)
    if match:
        prefix = match.group(1)
        inner = match.group(2)
        tokens = re.findall(r'["\']([^"\']+)["\']', inner)
        # Filter out target workspace (case-insensitive) and empty tokens
        workspaces = [w.strip() for w in tokens if w.strip() and w.strip().upper() != name.upper()]
        new_list = ', '.join(f'"{w}"' for w in workspaces)
        raw = raw[:match.start()] + f'{prefix}[{new_list}]' + raw[match.end():]

    # 2. Remove workspace navigation bindings (exec-and-forget or workspace command)
    pattern_nav = rf'^\s*ctrl-\S+\s*=.*?(?:exec-and-forget\s+.+?|workspace\s+)["\']?{re.escape(name)}["\']?\s*[\'"]\s*\n'
    raw = re.sub(pattern_nav, '', raw, flags=re.MULTILINE)

    # 3. Remove move-node-to-workspace bindings
    pattern_move = rf'^\s*ctrl-shift-\S+\s*=.*?move-node-to-workspace\s+["\']?{re.escape(name)}["\']?\s*[\'"]\s*\n'
    raw = re.sub(pattern_move, '', raw, flags=re.MULTILINE)

    # 4. Clean extra trailing blank lines before sections
    raw = re.sub(r'\n{3,}(\s*#\s*Monitor interaction)', r'\n\n\1', raw)

    path.write_text(raw, encoding='utf-8')
EOF

aerospace reload-config

if command -v sketchybar >/dev/null 2>&1; then
  sketchybar --trigger aerospace_workspace_list_changed
fi

echo "Workspace '$WORKSPACE_NAME' removed"
