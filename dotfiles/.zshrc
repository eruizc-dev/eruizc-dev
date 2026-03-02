#!/usr/bin/env zsh

# zmodload zsh/zprof # Profiling

# Oh My ZSH
export ZSH_COMPDUMP="$HOME"/.cache/oh-my-zsh/compdump
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME='refined'
CASE_SENSITIVE=false
COMPLETION_WAITING_DOTS=true
DISABLE_AUTO_UPDATE=true
ENABLE_CORRECTION=false
HYPHEN_INSENSITIVE=true

# $ZSH/plugins and $ZSH_CUSTOM/plugins
plugins=(
    #nix-shell
    direnv
)

[[ -s "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Shell Options
bindkey -e
setopt autocd nomatch notify
unsetopt beep extendedglob

# History
HISTFILE="$HOME/.cache/histfile"
HISTSIZE=1000
SAVEHIST=1000

# Variables
export PATH=$PATH:$XDG_BIN_HOME

export EDITOR='nvim'

if type bat > /dev/null 2>&1; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export BAT_THEME='Dracula'
    export MANROFFOPT='-c'

    compdef log=tail
    function log {
        tail -f "$@" | bat --paging=never --file-name "$@"
    }
fi

if type fzf > /dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
    export FZF_DEFAULT_OPTS="--layout=reverse --info=inline --height=40% --preview='bat --color=always --style=numbers --line-range=:500 {}'"
    export FZF_CTRL_R_OPTS="--preview=''"
    eval "$(fzf --zsh)"
fi

if [[ -s /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh 
fi

if type zoxide > /dev/null 2>&1; then
    alias cd='z'
    eval "$(zoxide init zsh)"
fi

if [[ -s /usr/share/nvm/init-nvm.sh ]] ; then
    source /usr/share/nvm/init-nvm.sh
fi

if [[ -s $HOME/.fury/fury_venv/bin/fury ]] ; then
    export FURY_BIN_LOCATION="/Users/ecarletti/.fury/fury_venv/bin"
    export PATH="$PATH:$FURY_BIN_LOCATION"
fi

if type opencode > /dev/null 2>&1; then
    export OPENCODE_DISABLE_LSP_DOWNLOAD=true
    export OPENCODE_DISABLE_DEFAULT_PLUGINS=true
fi

if [ $(whoami) = 'ecarletti' ]; then
    export JIRA_API_TOKEN=$(security find-generic-password -a ecarletti -s JiraMcpAccessToken -w)
fi

# Aliases
alias cls='clear'
alias la='ls -lhA --color=always'
alias lg='lazygit'
alias ld='lazydocker'
alias so='source'
alias t='tree -a -L 2 -I .git -I node_modules'
alias tt='tree -a -L 3 -I .git -I node_modules'

#zprof # Profiling
