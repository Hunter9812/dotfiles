#!/bin/sh
# Get the ID of the currently focused workspace
CURRENT_WS=$(hyprctl monitors -j | jq '.[] | select(.focused == true) | .activeWorkspace.id')

# Define your dedicated "desktop" workspace ID (keep it empty for wallpaper)
DESKTOP_WS=10

# Temporary file to store the previous workspace ID
STATE_FILE="/tmp/hypr_last_ws"

if [ "$CURRENT_WS" -ne "$DESKTOP_WS" ]; then
    # If not on the desktop workspace, save the current workspace ID and switch to desktop
    echo "$CURRENT_WS" > "$STATE_FILE"
    hyprctl dispatch "hl.dsp.focus({ workspace = $DESKTOP_WS })"
else
    # If already on the desktop workspace, restore the previous workspace
    if [ -f "$STATE_FILE" ]; then
        LAST_WS=$(cat "$STATE_FILE")
        hyprctl dispatch "hl.dsp.focus({ workspace = $LAST_WS })"
    else
        hyprctl dispatch "hl.dsp.focus({ workspace = 1 })"
    fi
fi
