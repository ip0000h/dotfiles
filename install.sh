#!/usr/bin/env bash
echo 'Hello! You are running install script for dotfiles(configuration files for urxvt, bash, tmux, vim, etc)'
echo 'Original project page - https://github.com/ip0000h/dotfiles'
echo 'Starting...'
echo 'Copying bash configuration files...'
ln -fs .bashrc ~/.bashrc
ln -fs Documents/Projects/github/dotfiles/bash/.bash_aliases ~/.bash_aliases
echo 'Done!'
echo 'Installing pyenv application(https://github.com/yyuu/pyenv)...'
echo '# PyEnv configuration' >> ~/.bash_custom
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
echo 'export PATH="/home/ip0000h/.pyenv/bin:$PATH"' >> ~/.bash_custom
echo 'eval "$(pyenv init -)"' >> ~/.bash_custom
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bash_custom
bash -c 'pyenv update'
echo 'Done!'
