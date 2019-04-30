#!/usr/bin/env bash
set -o nounset
set -o errexit

###############################################################################
# Start
echo 'Starting...'
if [[ ! `which git` ]]; then
    echo 'Git is not installed! Exiting...'
    exit
fi
dotfiles_dir=~/.dotfiles
if [ -d $dotfiles_dir ]; then
    echo 'Dotfiles directory already exist! Updating...'
    cd $dotfiles_dir
    git pull
    exit
else
    git clone git@github.com:ip0000h/dotfiles.git $dotfiles_dir
fi

###############################################################################
# Bash
echo 'Copying bash configuration files...'
ln -fs "$dotfiles_dir/bash/.bashrc" ~/.bashrc
ln -fs "$dotfiles_dir/bash/.bash_aliases" ~/.bash_aliases
echo 'Done! Bash configuration installed.'

###############################################################################
# Zsh
if [[ `which zsh` ]]; then
    echo 'Installing oh-my-zsh(http://ohmyz.sh/)...'
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo 'Copying zsh configuration files...'
    ln -fs "$dotfiles_dir/zsh/.zshrc" ~/.zshrc
    echo 'Done! Zsh configuration installed.'
else
    echo 'Zsh is not installed. Skipping...'
fi

###############################################################################
# PyEnv
echo 'Installing pyenv application(https://github.com/yyuu/pyenv)...'
echo '# PyEnv configuration' >> ~/.bashrc_custom
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc_custom
echo 'eval "$(pyenv init -)"' >> ~/.bashrc_custom
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc_custom
source ~/.bashrc_custom
pyenv update
echo 'Done! PyEnv configuration installed.'

###############################################################################
# Tmux
if [[ `which tmux` ]]; then
    echo 'Installing TPM tmux plugin manager(https://github.com/tmux-plugins/tpm)...'
    mkdir -p ~/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo 'Copying tmux configuration...'
    ln -fs "$dotfiles_dir/tmux/.tmux.conf" ~/.tmux.conf
    tmux source ~/.tmux.conf
    echo 'Done! Tmux configuration installed. Run it and press `prefix` + I to complete install plugins.'
else
    echo 'Tmux is not installed. Skipping...'
fi

###############################################################################
# Vim
if [[ `which vim` ]]; then
    echo 'Installing Vundle vim plugin manager(https://github.com/VundleVim/Vundle.vim)...'
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo 'Copying vim configuration...'
    ln -fs "$dotfiles_dir/vim/.vimrc" ~/.vimrc
    echo 'Installing plugins...'
    vim +PluginInstall +qall > /dev/null
    echo 'Done! Vim configuration installed.'
else
    echo 'Vim is not installed. Skipping...'
fi

###############################################################################
# Htop
if [[ `which htop` ]]; then
    echo 'Copying htop configuration...'
    ln -fs "$dotfiles_dir/htop/htoprc" ~/.config/htop/htoprc
    echo 'Done! Htop configuration installed.'
else
    echo 'Htop is not installed. Skipping...'
fi

###############################################################################
# End
echo 'All tasks done!'
