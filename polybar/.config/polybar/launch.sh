#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have all been shut down
while pgrep -u $UID -x /usr/bin/polybar >/dev/null; do sleep 1; done

# Launch the bars
for m in $(/usr/bin/polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m /usr/bin/polybar --reload firsttry &
done

# Report success
echo "Bars launched..."
