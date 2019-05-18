#!/bin/sh
compton -bc --config ~/.config/compton.conf &
unclutter &
/home/rehajel/.scripts/battery_notify &
