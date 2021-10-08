#!/bin/zsh

# Pulled from .profile
pupdate() { case ":${PATH:=$1}:" in *:"$1":*) ;; *) PATH="$1:$PATH" ;; esac; }
for dir in $(du "$HOME/.local/bin/" | cut -f2); do
    pupdate $dir
done
export PATH

# Completion
autoload -Uz compinit
compinit
# Prettify Completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' menu select
zmodload zsh/complist
# Enable sudo Completion
zstyle ':completion::complete:*' gain-privileges 1

# Better ssh completion reads .ssh/{config,known_hosts}
h=()
if [[ -r ~/.ssh/config ]]; then
    h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi

if [[ $#h -gt 0 ]]; then
    zstyle ':completion:*:ssh:*' hosts $h
    zstyle ':completion:*:slogin:*' hosts $h
    zstyle ':completion:*:scp:*' hosts $h
fi

# Correction
setopt correct
# Disable correction for sudo
alias sudo='nocorrect sudo'

# Prompt
autoload -U promptinit
promptinit
# prompt gentoo

# Make ls colorful
alias ls="ls --color"
alias grep="grep --color"

# Calculator
autoload -U zcalc
function __calc_plugin {
    zcalc -e "$*"
}
aliases[=]='noglob __calc_plugin'

# History
export HISTSIZE=2000
export HISTFILE="$XDG_CONFIG_HOME/zsh/.zhistory"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Misc
setopt autocd
setopt extendedglob
setopt COMPLETE_ALIASES

# Enable vi mode
bindkey -v
export KEYTIMEOUT=1

### Make ArrowKeys, PageUp/Down, Home/End, etc. work. ###

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[ShiftTab]}"  ]] && bindkey -- "${key[ShiftTab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start {
        echoti smkx
    }
    function zle_application_mode_stop {
        echoti rmkx
    }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

### END Make ArrowKeys, PageUp/Down, Home/End, etc. work. ###

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

if [[ "$TERM" == "dumb" ]]; then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    # unfunction precmd
    # unfunction preexec
    PS1="$ "
    return
fi

# Download powerlevel10k if folder doesn't exist.
if ! [ -d "${ZDOTDIR}/powerlevel10k" ]; then
    echo "PowerLevel10k not in ZDOTDIR! Installing from github."

    # Clone repo
    git clone https://github.com/romkatv/powerlevel10k "${ZDOTDIR}/powerlevel10k"
fi

# Enable powerlevel10k on non-tty terminals
if ! ( [ "$TERM" = "linux" ]; ) then
    # Enable powerlevel10k
    source "${ZDOTDIR}/powerlevel10k/powerlevel10k.zsh-theme"
    
    # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
    [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
else
    prompt gentoo
fi

### START emacs-libvterm config ###

# Some of the most useful features in emacs-libvterm require shell-side
# configurations. The main goal of these additional functions is to enable the
# shell to send information to `vterm` via properly escaped sequences. A
# function that helps in this task, `vterm_printf`, is defined below.

function vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

# Completely clear the buffer. With this, everything that is not on screen
# is erased.
if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
fi

# With vterm_cmd you can execute Emacs commands directly from the shell.
# For example, vterm_cmd message "HI" will print "HI".
# To enable new commands, you have to customize Emacs's variable
# vterm-eval-cmds.
vterm_cmd() {
    local vterm_elisp
    vterm_elisp=""
    while [ $# -gt 0 ]; do
        vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
        shift
    done
    vterm_printf "51;E$vterm_elisp"
}

# This is to change the title of the buffer based on information provided by the
# shell. See, http://tldp.org/HOWTO/Xterm-Title-4.html, for the meaning of the
# various symbols.
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ print -Pn "\e]2;%m:%2~\a" }

# Sync directory and host in the shell with Emacs's current directory.
# You may need to manually specify the hostname instead of $(hostname) in case
# $(hostname) does not return the correct string to connect to the server.
#
# The escape sequence "51;A" has also the role of identifying the end of the
# prompt
vterm_set_directory() {
    if [ -n "$SSH_CONNECTION" ]; then
        vterm_cmd update-pwd "/-:""$(whoami)""@""$(hostname)"":""$(pwd)/"
    else
        vterm_cmd update-pwd "$(pwd)/"
    fi
}

# Run vterm_set_directory after every directory change.
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ vterm_set_directory }

### END emacs-libvterm config ###

# Run neofetch if running in 'kitty'
# If not in kitty just run neofetch without the image.
if which neofetch >/dev/null; then
    # Don't run neofetch if in tmux, using neovim's terminal emulator, or using root.
    if ! ( [ "$TERM" = "screen" ] || [ -n "$TMUX" ] || \
        [ -n "$MYVIMRC" ] || [ "$USER" = root ]; ) then
        neofetch --ascii "$(fortune -s | cowsay -f stegosaurus)"
    fi
fi
