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
    kubectl
    minikube
    npm
    pip
    python
    tmux
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
alias piptop='pipdeptree --freeze | grep --only-matching --perl-regexp "^[\w\-]+" | grep --invert-match "\-e\|pkg"'

# Local binaries and scripts
export PATH="$HOME/.local/bin:$PATH"

# Nvm lazy-loading
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}
node() { nvm use default >/dev/null 2>&1; unset -f node; node "$@"; }
npm() { nvm use default >/dev/null 2>&1; unset -f npm; npm "$@"; }
npx() { nvm use default >/dev/null 2>&1; unset -f npx; npx "$@"; }

# Source all files from a specific folder
if [ -d "$HOME/.local/etc" ]; then
  for file in "$HOME/.local/etc"/*.sh; do
    if [ -f "$file" ]; then
      source "$file"
    fi
  done
fi
