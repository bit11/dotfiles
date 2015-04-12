#!/bin/sh

#-----------------------------------------
# xinitrc config file
# $HOME/.xinitrc
# Last updated 26 Dec 14
#----------------------------------------

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

## Merge Xresources on boot
[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

## Lock screen after 15 mins
xautolock -time 15 -locker "systemctl suspend" -detectsleep -notify 30 -notifier "notify-send 'Locking Screen in 30 Seconds'"  &

## Load fonts
xset +fp $HOME/.local/share/fonts 
xset fp rehash 

## Execute battery status
$HOME/bin/batt_stat 

## Execute dwm status bar
$HOME/bin/dwm-statusbar &

# Change cursor for bspwm
#xsetroot -cursor_name left_ptr

## Execute urxvt daemon to allow urxvtc use
urxvtd -q -o -f &

## Autostart programs
nm-applet &
#feh --bg-scale --randomize $HOME/.wallpapers/* &
dropbox &
redshift-gtk &
chromium &
thunderbird &
udiskie --smart-tray &
#mpd &

## Execute DE/WM
exec $HOME/bin/startdwm
#exec i3
