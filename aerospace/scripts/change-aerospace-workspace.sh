#!/bin/bash
# Script to change aerospace workspace and trigger Hammerspoon canvas

WORKSPACE_ID=$1
WORKSPACE_NAME=$2

# Paths to Homebrew binaries. Update these with the output of 'which hs' and 'which aerospace'
HS_PATH="/opt/homebrew/bin/hs"
AEROSPACE_PATH="/opt/homebrew/bin/aerospace"

if [ -z "$WORKSPACE_ID" ] || [ -z "$WORKSPACE_NAME" ]; then
  exit 1
fi

# Change the workspace using aerospace CLI
$AEROSPACE_PATH workspace "$WORKSPACE_NAME"

# Show the custom popup via Hammerspoon IPC
$HS_PATH -c "showWorkspaceAlert('$WORKSPACE_NAME')"
