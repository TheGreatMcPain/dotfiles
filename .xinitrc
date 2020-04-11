#!/bin/bash
[ -f ~/.xprofile ] && . ~/.xprofile
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# make sure DISPLAY is set for systemctl
systemctl --user set-environment DISPLAY=:0
exec bspwm
