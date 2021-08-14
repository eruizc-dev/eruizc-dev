# ZSH https://github.com/ohmyzsh/ohmyzsh/wiki
export ZSH="$HOME/.oh-my-zsh"

HISTFILE="$HOME/.local/historyfile"
HISTSIZE=1000
SAVEHIST=1000

ZSH_THEME="refined"
HIST_STAMPS="yyyy-mm-dd"
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    git
    node npm nvm yarn
    gradle mvn sdk
    docker docker-compose
)
[[ -s "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Aliases
alias flex='neofetch'
alias btw='neofetch'
alias cls='clear'
alias py='python'
alias ni='touch'
alias la='ls -lha --color=always'
alias lg='lazygit'
alias ld='lazydocker'
alias log='tail -f `fzf`'
alias nvim='nvim'
alias vim='nvim'
alias vi='nvim'
alias open='xdg-open'

alias install='sudo pacman -S'
alias update='sudo pacman -Syu'
alias uninstall='sudo pacman -Rcns'

# System
export LANG="en_US.UTF-8"
export EDITOR='nvim'
export BROWSER='brave'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Golang
export GOPATH="$HOME/.local/go"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$GOPATH/bin"

# Dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=true
export PATH=$PATH:"$HOME/.dotnet/tools/"

# Node
[[ -s "/usr/share/nvm/init-nvm.sh" ]] && source "/usr/share/nvm/init-nvm.sh"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 

# Rust
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
export PATH=$PATH:"$HOME/.cargo/bin"

# Python
export PATH=$PATH:"$HOME/.local/bin"

# Ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH="$PATH:$HOME/.rvm/bin"

# Lua
alias luamake="$HOME/scripts/lua-language-server/3rd/luamake/luamake"
export PATH=$PATH:"$HOME/.luarocks/bin"

# Java
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Zoxide
eval "$(zoxide init zsh)"

# Make
zstyle ':completion:*:*:make:*' tag-order 'targets'
autoload -U compinit && compinit
