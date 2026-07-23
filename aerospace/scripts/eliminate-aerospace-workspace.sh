#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Aerospace: Remove Workspace
# @raycast.mode compact
# @raycast.argument1 {"type": "text", "placeholder": "Workspace name"}

# Optional parameters:
# @raycast.icon ➖
# @raycast.packageName Aerospace

WORKSPACE_NAME=$(echo "$1" | tr '[:lower:]' '[:upper:]')
if [ -z "$WORKSPACE_NAME" ]; then
  echo "Usage: $0 <workspace-name>"
  exit 1
fi

WINDOWS=$(aerospace list-windows --workspace "$WORKSPACE_NAME" 2>/dev/null)
if [ -n "$WINDOWS" ]; then
  echo "Error: workspace '$WORKSPACE_NAME' has windows open. Move them out first."
  exit 1
fi

python3 << EOF
import tomllib, re, pathlib

path = pathlib.Path.home() / '.aerospace.toml'
raw = path.read_text()
config = tomllib.loads(raw)
workspaces = config.get('persistent-workspaces', [])

name = "$WORKSPACE_NAME"
if name in workspaces:
    workspaces.remove(name)

new_list = ', '.join(f'"{w}"' for w in workspaces)
raw = re.sub(
    r'(^\s*persistent-workspaces\s*=\s*)\[.*?\](\s*)$',
    rf'\1[{new_list}]\2',
    raw,
    count=1,
    flags=re.MULTILINE
)

raw = re.sub(
    rf'    alt-ctrl-\w+ = \'workspace {re.escape(name)}\'\n',
    '',
    raw
)
raw = re.sub(
    rf'    alt-ctrl-shift-\w+ = \'move-node-to-workspace {re.escape(name)}\'\n',
    '',
    raw
)

path.write_text(raw)
EOF

aerospace reload-config
sketchybar --trigger aerospace_workspace_list_changed

echo "Workspace '$WORKSPACE_NAME' removed"
