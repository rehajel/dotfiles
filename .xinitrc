#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# twm &
xclock -geometry 50x50-1+1 &
setxkbmap -layout us -variant altgr-intl
udiskie &

if [ $(xrandr --query | grep ' connected' | wc -l) == 2 ]
then
	#xrandr --output eDP1 --off --output DP1 --primary --mode 5120x1440 --rate 60 --dpi 109 --right-of eDP1 --output HDMI2 --off 
	xrandr --output eDP-1 --off --output DP-1 --primary --mode 5120x1440 --rate 60 --dpi 109 --right-of eDP1 --output HDMI-2 --off 
fi

xsetroot -cursor_name left_ptr
exec xmonad
