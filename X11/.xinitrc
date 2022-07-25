#!/bin/bash
[ -f ~/.xprofile ] && . ~/.xprofile
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr

exec dbus-run-session bspwm
