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
alias sudo='nocorrect block_sudo_vi'

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

# Run neofetch if running in 'kitty'
# If not in kitty just run neofetch without the image.
if which neofetch >/dev/null; then
    # Don't run neofetch if in tmux, using neovim's terminal emulator, or using root.
    if ! ( [ "$TERM" = "screen" ] || [ -n "$TMUX" ] || \
        [ -n "$MYVIMRC" ] || [ "$USER" = root ]; ) then
        neofetch --ascii "$(fortune -o -s | cowsay -f stegosaurus)"
    fi
fi
