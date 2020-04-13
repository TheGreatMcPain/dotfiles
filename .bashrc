# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.

set -o vi # Enable vi mode
stty -ixon # Disable ctrl-s and ctrl-q
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.

if ! { [ "$TERM" = "linux" ]; } then
        [ -f ~/.promptline.sh ] && source ~/.promptline.sh
        if ! ( [ "$TERM" = "screen" ] || [ -n "$TMUX" ] || [ -n "$MYVIMRC" ]; ) then
                neofetch --kitty /home/james/Sync/cat_pancakes.jpg --size 30%
        fi
fi
