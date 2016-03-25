#!/usr/bin/env bash
###############################################################################
# Start
echo 'Starting...'
git clone git@github.com:ip0000h/dotfiles.git .dotfiles
###############################################################################
# Bash
echo 'Copying bash configuration files...'
ln -fs ".dotfiles/bash/.bashrc" ~/.bashrc
ln -fs ".dotfiles/bash/.bash_aliases" ~/.bash_aliases
echo 'Done! Bash configuration installed.'
###############################################################################
# Zsh
echo 'Installing oh-my-zsh(http://ohmyz.sh/)...'
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo 'Copying zsh configuration files...'
ln -fs ".dotfiles/zsh/.zshrc" ~/.zshrc
echo 'Done! Zsh configuration installed.'
###############################################################################
# PyEnv
echo 'Installing pyenv application(https://github.com/yyuu/pyenv)...'
echo '# PyEnv configuration' >> ~/.bashrc_custom
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc_custom
echo 'eval "$(pyenv init -)"' >> ~/.bashrc_custom
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc_custom
source ~/.bashrc_custom
bash -c 'pyenv update'
echo 'Done! PyEnv configuration installed.'
###############################################################################
# Tmux
echo 'Installing TPM tmux plugin manager(https://github.com/tmux-plugins/tpm)...'
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo 'Copying tmux configuration...'
ln -fs ".dotfiles/tmux/.tmux.conf" ~/.tmux.conf
tmux source ~/.tmux.conf
echo 'Done! Tmux configuration installed. Run it and press `prefix` + I to complete install plugins.'
###############################################################################
# Vim
echo 'Installing Vundle vim plugin manager(https://github.com/VundleVim/Vundle.vim)...'
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo 'Copying vim configuration...'
ln -fs ".dotfiles/vim/.vimrc" ~/.vimrc
echo 'Installing plugins...'
vim +PluginInstall +qall
echo 'Done! Vim configuration installed.'
###############################################################################
# MC
echo 'Copying mc configuration...'
ln -fs ".dotfiles/mc/ini" ~/.config/mc/ini
ln -fs ".dotfiles/mc/panels.ini" ~/.config/mc/panels.ini
echo 'Done! Mc configuration installed.'
###############################################################################
# Htop
echo 'Copying htop configuration...'
ln -fs ".dotfiles/htop/htoprc" ~/.config/htop/htoprc
echo 'Done! Htop configuration installed.'
###############################################################################
echo 'All tasks done!'
