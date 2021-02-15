# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# For tmuxp
export DISABLE_AUTO_TITLE='true'

# Theme
ZSH_THEME="gnzh"

# Plugins
plugins=(colorize common-aliases command-not-found docker git git-extras github pip pyenv python tmux virtualenv web-search)

# Init oh-my-zsh
source $ZSH/oh-my-zsh.sh

# PyEnv configuration
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

source $HOME/.bash_aliases

# Direnv configuration
eval "$(direnv hook zsh)"

# Nvm configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

