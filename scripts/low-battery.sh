#!/bin/bash

# File to store the last known battery state
STATE_FILE="/tmp/battery_state"

# Set the low battery threshold
LOW_BATTERY_THRESHOLD=15

# Get the battery percentage and state
BATTERY_INFO=$(upower -i $(upower -e | grep BAT))
BATTERY_PERCENT=$(echo "$BATTERY_INFO" | grep percentage | awk '{print $2}' | tr -d '%')
BATTERY_STATE=$(echo "$BATTERY_INFO" | grep state | awk '{print $2}')

# Get the previous battery state (if available)
PREVIOUS_STATE=$(cat $STATE_FILE 2>/dev/null || echo "unknown")

# Low battery notification
if [[ "$BATTERY_STATE" == "discharging" && "$BATTERY_PERCENT" -le "$LOW_BATTERY_THRESHOLD" ]]; then
    notify-send "Battery Low" "Battery is at ${BATTERY_PERCENT}%!" --urgency=critical
fi

# Plugged-in notification
if [[ "$BATTERY_STATE" == "charging" && "$PREVIOUS_STATE" != "charging" ]]; then
    notify-send "Charging" "Battery is now plugged in." --urgency=normal
fi

# Save the current state only if it has changed
if [[ "$BATTERY_STATE" != "$PREVIOUS_STATE" ]]; then
    echo "$BATTERY_STATE" > "$STATE_FILE"
fi
