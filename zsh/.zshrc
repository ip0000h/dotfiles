# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# For tmuxp
export DISABLE_AUTO_TITLE='true'

# Theme
ZSH_THEME="gnzh"

# Plugins
plugins=(colorize common-aliases command-not-found docker docker-compose git git-extras github kubectl minikube node npm nvm pip pyenv pylint python tmux virtualenv web-search)

# Init oh-my-zsh
source $ZSH/oh-my-zsh.sh

# bash aliases
source $HOME/.bash_aliases

# PyEnv configuration
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Direnv configuration
eval "$(direnv hook zsh)"

# GoEnv configuration
export PATH="$HOME/.goenv/bin:$PATH"
eval "$(goenv init -)"

# Nvm configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# GoLang binaries
export PATH=$PATH:$(go env GOPATH)/bin

# nsc tool
export PATH="$PATH:$HOME/.nsccli/bin"
