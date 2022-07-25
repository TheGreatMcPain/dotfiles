#!/bin/sh

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WLR_NO_HARDWARE_CURSORS=1
export XDG_CURRENT_DESKTOP="Unity"
exec dbus-run-session Hyprland
