#!/bin/bash

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

exec ck-launch-session dbus-launch --sh-syntax --exit-with-session i3
