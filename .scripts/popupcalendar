#!/bin/sh

WIDTH=270
HEIGHT=274
BOTTOM=false
DATE="$(date +"  %a, %d %b  %H:%M ")"

case "$1" in
    --popup)
        eval "$(xdotool getmouselocation --shell)"

        if [ $BOTTOM = true ]; then
            : $(( pos_y = Y - HEIGHT - 20 ))
            : $(( pos_x = X - (WIDTH / 2) ))
        else
            : $(( pos_y = Y + 50 ))
            : $(( pos_x = X + (WIDTH / 2) ))
        fi

	yad --calendar --width=300 --no-buttons --border=0 --posy=5 --posx=1610 --undecorated --skip-taskbar 
        ;;
    *)
        echo "$DATE"
        ;;
esac
