# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# For tmuxp
export DISABLE_AUTO_TITLE='true'

# Theme
ZSH_THEME="gnzh"

# Plugins
plugins=(
    colorize
    common-aliases
    command-not-found
    docker
    docker-compose
    git
    git-extras
    github
    kubectl
    minikube
    node
    npm
    nvm
    pip
    poetry
    pyenv
    python
    tmux
    virtualenv
    web-search
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Init oh-my-zsh
source $ZSH/oh-my-zsh.sh

# aliases
alias ll="ls -alrtF"
alias la="ls -A"
alias l="ls -CF"
alias m='less'
alias ..='cd ..'
alias ...='cd ..;cd ..'
alias md='mkdir'
alias cl='clear'
alias du='du -ch --max-depth=1'
alias treeacl='tree -A -C -L 2'
alias piptop='~/.dotfiles/utils/piptop.sh'

# PyEnv configuration
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Local binaries and scripts
export PATH="$HOME/.local/bin:$PATH"

# Nvm configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
