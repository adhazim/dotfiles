
#!/bin/bash

# Notifications flags
low_notified=false
charged_notified=false
full_notified=false

# Track the last battery status
last_status=""

while true; do
    # Get the battery information
    battery_info=$(acpi -b)
    battery_percentage=$(echo "$battery_info" | awk -F'[,:%]' '{gsub(/ /, "", $2); print $3}')
    battery_status=$(echo "$battery_info" | awk '{print $3}' | sed 's/,//')

    # Print current status and percentage for debugging
    echo "Status: $battery_status, Percent: $battery_percentage"

    # Reset notifications if status changes
    if [[ "$battery_status" != "$last_status" ]]; then
        echo "Power status changed from $last_status to $battery_status"
        low_notified=false
        charged_notified=false
        full_notified=false
        last_status="$battery_status"
    fi

    # Handle Discharging status
    if [[ "$battery_status" == "Discharging" ]]; then
        if [[ "$battery_percentage" -le 20 && "$low_notified" = false ]]; then
            # Notify for low battery
            notify-send -u critical "🔋 Battery Low" "Battery at ${battery_percentage}%"
            paplay /usr/share/sounds/freedesktop/stereo/power-unplug.oga &
            low_notified=true
        elif [[ "$battery_percentage" -gt 20 ]]; then
            low_notified=false
        fi
    fi

    # Handle Charging status
    if [[ "$battery_status" == "Charging" ]]; then
        if [[ "$battery_percentage" -ge 80 && "$battery_percentage" -lt 100 && "$charged_notified" = false ]]; then
            # Notify for charging reaching 80%
            notify-send -u normal "⚡ Battery Charged" "Battery has reached ${battery_percentage}%"
            paplay /usr/share/sounds/freedesktop/stereo/power-plug.oga &
            charged_notified=true
        elif [[ "$battery_percentage" -lt 80 ]]; then
            charged_notified=false
        fi

        if [[ "$battery_percentage" -ge 100 && "$full_notified" = false ]]; then
            # Notify when battery is fully charged
            notify-send -u low "🔌 Battery Full" "Battery is fully charged"
            paplay /usr/share/sounds/freedesktop/stereo/complete.oga &
            full_notified=true
        elif [[ "$battery_percentage" -lt 100 ]]; then
            full_notified=false
        fi
    fi

    # Wait for 60 seconds before checking again
    sleep 60
done

