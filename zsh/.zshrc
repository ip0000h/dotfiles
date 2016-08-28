# Path to your oh-my-zsh installation.
export ZSH=/home/ip0000h/.oh-my-zsh

# For tmuxp
export DISABLE_AUTO_TITLE='true'

# Theme
ZSH_THEME="gnzh"

# Plugins
plugins=(common-aliases command-not-found docker git git-extras github pyenv tmux virtualenv web-search zsh-completions zsh-syntax-highlighting)

# Init oh-my-zsh
source $ZSH/oh-my-zsh.sh
