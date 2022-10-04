#!/usr/bin/env zsh

# XDG Settings
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config

# Basic Oh My Zsh
export ZSH="$XDG_DATA_HOME/oh-my-zsh"

ZSH_THEME='refined'
HIST_STAMPS='yyyy-mm-dd'
CASE_SENSITIVE=false
DISABLE_AUTO_UPDATE=true
ENABLE_CORRECTION=true
COMPLETION_WAITING_DOTS='%F{white}...%f'

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
  git
  brew
  gradle sdk
)

[[ -s "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# History
HISTFILE="$XDG_CACHE_HOME/histfile"
HISTSIZE=1000
SAVEHIST=1000

# Some options
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e

# Completion
zstyle :compinstall filename "$HOME/.zshrc"
zstyle ':completion:*:*:make:*' tag-order 'targets'
autoload -Uz compinit && compinit

# Aliases
alias cls='clear'
alias la='ls -lha --color=always'
alias lg='lazygit'
alias ld='lazydocker'
alias so='source'
alias t='tree -L 2 -I .git -I node_modules'
alias t3='tree -L 3 -I .git -I node_modules'

# Fancy stuff
export BAT_THEME='OneHalfDark'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--layout=reverse --info=inline --height=40% --preview='bat --color=always --style=numbers --line-range=:500 {}'"

compdef log=tail
function log() {
  tail -f $@ | bat --paging=never --file-name $@
}

# Fix ctrl+arrows
case "${TERM}" in
  cons25*|linux) # plain BSD/Linux console
    bindkey '\e[H'    beginning-of-line   # home
    bindkey '\e[F'    end-of-line         # end
    bindkey '\e[5~'   delete-char         # delete
    bindkey '[D'      emacs-backward-word # esc left
    bindkey '[C'      emacs-forward-word  # esc right
    ;;
  *rxvt*) # rxvt derivatives
    bindkey '\e[3~'   delete-char         # delete
    bindkey '\eOc'    forward-word        # ctrl right
    bindkey '\eOd'    backward-word       # ctrl left
    # workaround for screen + urxvt
    bindkey '\e[7~'   beginning-of-line   # home
    bindkey '\e[8~'   end-of-line         # end
    bindkey '^[[1~'   beginning-of-line   # home
    bindkey '^[[4~'   end-of-line         # end
    ;;
  *xterm*) # xterm derivatives
    bindkey '\e[H'    beginning-of-line   # home
    bindkey '\e[F'    end-of-line         # end
    bindkey '\e[3~'   delete-char         # delete
    bindkey '\e[1;5C' forward-word        # ctrl right
    bindkey '\e[1;5D' backward-word       # ctrl left
    # workaround for screen + xterm
    bindkey '\e[1~'   beginning-of-line   # home
    bindkey '\e[4~'   end-of-line         # end
    ;;
  screen)
    bindkey '^[[1~'   beginning-of-line   # home
    bindkey '^[[4~'   end-of-line         # end
    bindkey '\e[3~'   delete-char         # delete
    bindkey '\eOc'    forward-word        # ctrl right
    bindkey '\eOd'    backward-word       # ctrl left
    bindkey '^[[1;5C' forward-word        # ctrl right
    bindkey '^[[1;5D' backward-word       # ctrl left
    ;;
esac
