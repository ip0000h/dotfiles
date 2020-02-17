# Path to your oh-my-zsh installation.
export ZSH=/home/ip0000h/.oh-my-zsh

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
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

# Direnv configuration
eval "$(direnv hook zsh)"
