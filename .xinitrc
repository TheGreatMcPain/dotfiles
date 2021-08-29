#!/bin/bash
[ -f ~/.xprofile ] && . ~/.xprofile
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

exec dbus-run-session bspwm
