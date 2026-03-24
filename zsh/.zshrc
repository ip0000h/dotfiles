# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# For tmuxp
export DISABLE_AUTO_TITLE='true'

# Theme
ZSH_THEME="gnzh"

# Plugins
plugins=(
    common-aliases
    command-not-found
    direnv
    docker
    docker-compose
    fzf
    git
    git-extras
    kubectl
    minikube
    npm
    python
    tmux
    you-should-use
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

# Init oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Local binaries and scripts
export PATH="$HOME/.local/bin:$PATH"

# Source dotfiles aliases
if [ -d "$HOME/.dotfiles/aliases" ]; then
  for file in "$HOME/.dotfiles/aliases"/*.sh; do
    [ -f "$file" ] && source "$file"
  done
fi

# Zoxide (smart cd)
eval "$(zoxide init zsh)"

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
