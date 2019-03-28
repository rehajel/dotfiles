#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
# polybar bar1 &
# polybar bar2 &
if type "xrandr"; then
	for m in $(xrandr --query | grep "primary" | cut -d" " -f1); do
		MONITOR=$m polybar main -r &
	done
	for m in $(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1); do
		MONITOR=$m polybar sidebar -r &
        done
else
	polybar -r main &
fi
