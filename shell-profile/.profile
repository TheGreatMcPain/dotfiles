#!/usr/bin/env sh

# Adds directories to PATH without creating duplicates
pupdate() { case ":${PATH:=$1}:" in *:"$1":*) ;; *) PATH="$1:$PATH" ;; esac; }

# Add all subdirectories in '.local/bin/' to PATH
for dir in $(du "$HOME/.local/bin/" | cut -f2); do
    pupdate $dir
done
export PATH

## Workaround fuse issue with appimages.
export APPIMAGE_EXTRACT_AND_RUN=1

## Cleanup ##
# XDG Base Dirs
export XDG_RUNTIME_DIR=/run/user/$(id -u)
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
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# Since emerge likes to take exported vars first
# before reading /etc/make.conf we need to disable these
# when running emerge, or ebuild.
if [ "$USER" = "root" ]; then
    alias fix-emerge-env='unset XDG_CACHE_HOME DISTCC_DIR CCACHE_DIR CCACHE_CONFIGPATH WGETRC'
    alias emerge='fix-emerge-env ; emerge'
    alias ebuild='fix-emerge-env ; ebuild'
    alias genup='fix-emerge-env ; genup'
    alias buildkernel='fix-emerge-env ; buildkernel'
    alias crossdev='fix-emerge-env ; crossdev'
    alias emtee='fix-emerge-env ; emtee'
    alias haskell-updater='fix-emerge-env ; haskell-updater'
    alias lto-rebuild='fix-emerge-env ; lto-rebuild'
fi

# Aliases
if [ "$USER" = "root" ]; then
    alias root="echo You\'re already root\!"
else
    alias root="sudo -i"
fi

# Emacs
alias emacs-client="emacsclient -a 'emacs' -c"
alias emacs-client-nw="emacsclient -a 'emacs -nw' -c -nw"
alias emacs-kill-daemon="emacsclient -e '(save-buffers-kill-emacs)'"
alias emacs-start-daemon='/usr/bin/emacs --daemon & disown'

alias music='tmux new-session "tmux source-file ~/.config/ncmpcpp/tmux_session"'
alias virtualbox='QT_QPA_PLATFORMTHEME=none virtualbox'
alias VirtualBox='QT_QPA_PLATFORMTHEME=none VirtualBox'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME/.dotfiles'
alias dino-fortune='clear && fortune -o -s | cowsay -f stegosaurus'

# Use nvimpager as PAGER
# if which nvimpager &>/dev/null; then
#   export MANPAGER="nvimpager"
#   export PAGER="nvimpager"
# fi

# Fix Java applications on bspwm
export _JAVA_AWT_WM_NONREPARENTING=1

# Set mpd programs to use 'socket'
export MPD_HOST=$XDG_CONFIG_HOME/mpd/socket

# Have sxhkd use /bin/sh,
# because zsh takes a bit to open since I use powerlevel10k now.
export SXHKD_SHELL=/bin/sh

# EDITOR settings
export EDITOR=nvim
export VISUAL=nvim

# Emacs lsp-mode enable plists for better performance
export LSP_USE_PLISTS=true

# slrn (Usenet)
export NNTPSERVER="news.newsgroup.ninja"

# Set LS_COLORS
eval "$(dircolors /etc/DIR_COLORS)"

# Fix gpg-agent pinentry issues. (For some reason it doesn't find the X display)
echo "UPDATESTARTUPTTY" | gpg-connect-agent &>/dev/null

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
