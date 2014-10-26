#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Use this instead to log output from i3
# exec i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
exec i3

# Suspend on inactivity
xautolock -time 1 -locker "systemctl suspend; i3lock -c 2a2a2a" -detectsleep &

