#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Aerospace: Add Workspace
# @raycast.mode compact
# @raycast.argument1 {"type": "text", "placeholder": "Workspace name"}
# @raycast.argument2 {"type": "text", "placeholder": "Key (e.g. 4, m)"}

# Optional parameters:
# @raycast.icon ➕
# @raycast.packageName Aerospace

WORKSPACE_NAME=$(echo "$1" | tr '[:lower:]' '[:upper:]')
KEY=$(echo "$2" | tr '[:lower:]' '[:upper:]')
if [ -z "$WORKSPACE_NAME" ] || [ -z "$KEY" ]; then
  echo "Usage: $0 <workspace-name> <key>"
  exit 1
fi

python3 << EOF
import tomllib, re, pathlib

path = pathlib.Path.home() / '.aerospace.toml'
raw = path.read_text()
config = tomllib.loads(raw)
workspaces = config.get('persistent-workspaces', [])

name = "$WORKSPACE_NAME"
key = "$KEY"

if name not in workspaces:
    workspaces.append(name)

new_list = ', '.join(f'"{w}"' for w in workspaces)
raw = re.sub(
    r'(^\s*persistent-workspaces\s*=\s*)\[.*?\](\s*)$',
    rf'\1[{new_list}]\2',
    raw,
    count=1,
    flags=re.MULTILINE
)

workspace_binding = f"    alt-ctrl-{key} = 'workspace {name}'"
move_binding = f"    alt-ctrl-shift-{key} = 'move-node-to-workspace {name}'"

existing_workspace = re.search(rf"alt-ctrl-{re.escape(key)}\s*=\s*'workspace \w+'", raw)
existing_move = re.search(rf"alt-ctrl-shift-{re.escape(key)}\s*=\s*'move-node-to-workspace \w+'", raw)

if not existing_workspace:
    raw = raw.replace(
        "    # Monitor interaction",
        f"{workspace_binding}\n{move_binding}\n    # Monitor interaction"
    )

path.write_text(raw)
EOF

aerospace reload-config
aerospace workspace "$WORKSPACE_NAME"
sketchybar --trigger aerospace_workspace_list_changed

echo "Workspace '$WORKSPACE_NAME' created with alt-ctrl-$KEY"
