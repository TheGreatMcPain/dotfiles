#!/usr/bin/env sh

# Adds directories to PATH without creating duplicates
pupdate() { case ":${PATH:=$1}:" in *:"$1":*) ;; *) PATH="$1:$PATH" ;; esac; }

# Add all subdirectories in '.local/bin/' to PATH
for dir in $(du "$HOME/.local/bin/" | cut -f2); do
    pupdate $dir
done
export PATH

## portage/compiler settings ##
export NPROC=$(nproc)
export NPROC_PLUS_ONE=$((NPROC+1))
export MAKEOPTS="-j$NPROC_PLUS_ONE -l$NPROC"
export EMERGE_DEFAULT_OPTS="--jobs=$NPROC_PLUS_ONE --load-average=$NPROC"

## Cleanup ##
# XDG Base Dirs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export DISTCC_DIR=$XDG_CACHE_HOME/distcc
export CCACHE_DIR=$XDG_CACHE_HOME/ccache
export CCACHE_CONFIGPATH=$XDG_CONFIG_HOME/ccache.conf
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export LESSHISTFILE="-"
export INPUTRC=$XDG_CONFIG_HOME/inputrc
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export VIMINIT=":source $XDG_CONFIG_HOME"/vim/init.vim
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# Since emerge likes to take exported vars first
# before reading /etc/make.conf we need to disable these
# when running emerge, or ebuild.
if [ "$USER" = "root" ]; then
    alias emerge='unset XDG_CACHE_HOME DISTCC_DIR CCACHE_DIR CCACHE_CONFIGPATH WGETRC ; emerge'
    alias ebuild='unset XDG_CACHE_HOME DISTCC_DIR CCACHE_DIR CCACHE_CONFIGPATH WGETRC ; ebuild'
    alias genup='unset XDG_CACHE_HOME DISTCC_DIR CCACHE_DIR CCACHE_CONFIGPATH WGETRC ; genup'
    alias buildkernel='unset XDG_CACHE_HOME DISTCC_DIR CCACHE_DIR CCACHE_CONFIGPATH WGETRC ; buildkernel'
    alias crossdev='unset XDG_CACHE_HOME DISTCC_DIR CCACHE_DIR CCACHE_CONFIGPATH WGETRC ; crossdev'
fi

# Prevent vi from running with sudo unless alias is used.
# (Prevents Stray $XDG_CONFIG_HOME from appearing due to vimrc settings)
alias sudo="block_sudo_vi"
alias sudovi="sudo -i $EDITOR"

# Aliases
if [ "$USER" = "root" ]; then
    alias root="echo You\'re already root\!"
else
    alias root="sudo su -l -"
fi

alias music='tmux new-session "tmux source-file ~/.config/ncmpcpp/tmux_session"'
alias virtualbox='QT_QPA_PLATFORMTHEME=none virtualbox'
alias VirtualBox='QT_QPA_PLATFORMTHEME=none VirtualBox'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Make QT use Gtk themes.
# Requires qtstyleplugin
export QT_QPA_PLATFORMTHEME=gtk2

# Fix Java applications on bspwm
export _JAVA_AWT_WM_NONREPARENTING=1

# Set mpd programs to use 'socket'
export MPD_HOST=$XDG_CONFIG_HOME/mpd/socket


# Use NeoVim
export EDITOR=nvim
export VISUAL=nvim

# Set LS_COLORS
eval "$(dircolors /etc/DIR_COLORS)"

# Use GnuPG as ssh-agent
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
# If we are connected to this machine using SSH use ncurses
# for gpg pinentry
if [ -n "$SSH_CONNECTION" ] ;then
    export PINENTRY_USER_DATA="USE_CURSES=1"
fi

# In order to behave like a normal .bash_profile we should start
# .bashrc if the running shell is bash. Other wise don't bother since shells
# like zsh don't require this.
echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && . "$HOME/.bashrc"
