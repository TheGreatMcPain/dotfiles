#!/usr/bin/env sh

pidFile="$HOME/.config/polybar/polybar"

# Check if UID is already set, because
# bash has it set to readonly.
if ! echo $UID | grep $(id -u) >/dev/null; then
    UID=$(id -u)
fi

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Start polybar on primary monitor first.
# This makes sure the systray is on the correct monitor.
PRIMARY=$(polybar --list-monitors | grep primary | cut -d":" -f1)
MONITOR=$PRIMARY TRAYPOS=center HWMONPATH="$1" polybar --reload default-top & echo $! > $pidFile-$PRIMARY.pid
MONITOR=$PRIMARY TRAYPOS=center HWMONPATH="$1" polybar --reload default-bottom & echo $! >> $pidFile-$PRIMARY.pid

for m in $(polybar --list-monitors | cut -d":" -f1); do
    # Don't try to start a new bar on primary monitor.
    if ! [ $m = $PRIMARY ]; then
	MONITOR=$m HWMONPATH="$1" polybar --reload default-top & echo $! > $pidFile-$m.pid
        MONITOR=$m HWMONPATH="$1" polybar --reload default-bottom & echo $! >> $pidFile-$m.pid
    fi
done

echo "Bars launched..."
