#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have all been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bars
polybar example &

# Report success
echo "Bars launched..."
