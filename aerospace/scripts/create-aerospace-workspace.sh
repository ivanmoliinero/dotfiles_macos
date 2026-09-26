#!/bin/bash
set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Aerospace: Add Workspace
# @raycast.mode compact
# @raycast.argument1 {"type": "text", "placeholder": "Workspace name"}
# @raycast.argument2 {"type": "text", "placeholder": "Key (e.g. 4, m)"}

# Optional parameters:
# @raycast.icon ➕
# @raycast.packageName Aerospace

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

WORKSPACE_NAME=$(echo "$1" | tr '[:lower:]' '[:upper:]')
KEY=$(echo "$2" | tr '[:lower:]' '[:upper:]')
if [ -z "$WORKSPACE_NAME" ] || [ -z "$KEY" ]; then
  echo "Usage: $0 <workspace-name> <key>"
  exit 1
fi

python3 - "$WORKSPACE_NAME" "$KEY" << 'EOF'
import sys, re, pathlib

name = sys.argv[1].strip()
key = sys.argv[2].strip()
script_path = str(pathlib.Path.home() / ".config/aerospace/scripts/change-aerospace-workspace.sh")

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
        workspaces = [w.strip() for w in tokens if w.strip()]
        if name not in workspaces:
            workspaces.append(name)
        new_list = ', '.join(f'"{w}"' for w in workspaces)
        raw = raw[:match.start()] + f'{prefix}[{new_list}]' + raw[match.end():]

    # 2. Add bindings if key not already mapped
    workspace_binding = f"    ctrl-{key} = 'exec-and-forget {script_path} {key} \"{name}\"'"
    move_binding = f"    ctrl-shift-{key} = 'move-node-to-workspace {name}'"

    existing_nav = re.search(rf'^\s*ctrl-{re.escape(key)}\s*=', raw, re.MULTILINE)
    if not existing_nav:
        monitor_match = re.search(r'(^\s*#\s*Monitor interaction)', raw, re.MULTILINE)
        if monitor_match:
            raw = raw[:monitor_match.start()] + f"{workspace_binding}\n{move_binding}\n\n" + raw[monitor_match.start():]
        else:
            raw += f"\n{workspace_binding}\n{move_binding}\n"

    path.write_text(raw, encoding='utf-8')
EOF

aerospace reload-config
aerospace workspace "$WORKSPACE_NAME"

if command -v sketchybar >/dev/null 2>&1; then
  sketchybar --trigger aerospace_workspace_list_changed
fi

echo "Workspace '$WORKSPACE_NAME' created with ctrl-$KEY"
