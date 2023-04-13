#!/bin/sh
# Waybar startup script that sets which
# hwmon device to read tempurature from before running.

# Read hwmon name from argument
HWMON_NAME="$1"

# Target location for hwmon temp1_input link
HWMON_LINK="/tmp/waybar-temperature"

# if no hwmon name is provided print usage
if [ -z "$HWMON_NAME" ]; then
  echo "Usage: $0 <hwmon name (ex: coretemp)>"
  exit 1
fi

HWMON_DIR=$(dirname $(grep -l $HWMON_NAME /sys/class/hwmon/hwmon*/name))

ln -sf $HWMON_DIR $HWMON_LINK

waybar &
