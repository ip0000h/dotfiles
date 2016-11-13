# Path to your oh-my-zsh installation.
export ZSH=/home/ip0000h/.oh-my-zsh

# For tmuxp
export DISABLE_AUTO_TITLE='true'

# Theme
ZSH_THEME="gnzh"

# Plugins
plugins=(colored-man colorize common-aliases command-not-found docker git git-extras github pip pyenv python tmux virtualenv web-search zsh-completions zsh-syntax-highlighting)

# Init oh-my-zsh
source $ZSH/oh-my-zsh.sh

# PyEnv configuration
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# RbEnv configuration
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"
