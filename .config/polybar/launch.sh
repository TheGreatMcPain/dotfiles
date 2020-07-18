#!/usr/bin/env sh

pidFile="$HOME/.config/polybar/polybar"

UID=$(id -u)

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Start polybar on primary monitor first.
# This makes sure the systray is on the correct monitor.
PRIMARY=$(polybar --list-monitors | grep primary | cut -d":" -f1)
MONITOR=$PRIMARY TRAYPOS=center TEMPZONE=$1 polybar --reload default-top & echo $! > $pidFile-$PRIMARY.pid
MONITOR=$PRIMARY TRAYPOS=center TEMPZONE=$1 polybar --reload default-bottom & echo $! >> $pidFile-$PRIMARY.pid

for m in $(polybar --list-monitors | cut -d":" -f1); do
    # Don't try to start a new bar on primary monitor.
    if ! [ $m = $PRIMARY ]; then
	MONITOR=$m polybar --reload default-top & echo $! > $pidFile-$m.pid
        MONITOR=$m polybar --reload default-bottom & echo $! >> $pidFile-$m.pid
    fi
done

echo "Bars launched..."
