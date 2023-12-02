#!/usr/bin/env bash
set -o nounset
set -o errexit

###############################################################################
# Start
echo 'Starting...'

dotfiles_dir=~/.dotfiles

if [ -d $dotfiles_dir ]; then
    echo 'Dotfiles directory already exist! Updating...'
    cd $dotfiles_dir
    git pull
else
    # needed apps
    sudo apt-get update && sudo apt-get install -y git zsh tmux vim

    # pyenv deps
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev

    git clone git@github.com:ip0000h/dotfiles.git $dotfiles_dir

    ###############################################################################
    # Zsh
    echo 'Installing oh-my-zsh(http://ohmyz.sh/)...'
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo 'Copying zsh configuration files...'
    ln -fs "$dotfiles_dir/zsh/.zshrc" ~/.zshrc
    echo 'Done! Zsh configuration installed.'

    ###############################################################################
    # Tmux
    echo 'Installing TPM tmux plugin manager(https://github.com/tmux-plugins/tpm)...'
    mkdir -p ~/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo 'Copying tmux configuration...'
    ln -fs "$dotfiles_dir/tmux/.tmux.conf" ~/.tmux.conf
    echo 'Done! Tmux configuration installed. Run it and press `prefix` + I to complete install plugins.'

    ###############################################################################
    # Vim
    echo 'Installing Vundle vim plugin manager(https://github.com/VundleVim/Vundle.vim)...'
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo 'Copying vim configuration...'
    ln -fs "$dotfiles_dir/vim/.vimrc" ~/.vimrc
    echo 'Installing plugins...'
    vim +PluginInstall +qall > /dev/null
    echo 'Done! Vim configuration installed.'

    ###############################################################################
    # PyEnv
    if [[ ! `which pyenv` ]]; then
        echo 'Installing pyenv application(https://github.com/yyuu/pyenv)...'
        echo '# PyEnv configuration' >> ~/.bashrc_custom
        curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
        echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc_custom
        echo 'eval "$(pyenv init -)"' >> ~/.bashrc_custom
        echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc_custom
        source ~/.bashrc_custom
        pyenv update
        echo 'Done! PyEnv configuration installed.'
    else
        pyenv update
    fi

    ###############################################################################
    # Python
    pyenv install 3.11
    pyenv global 3.11
    pip install pip-tools
    pip-compile "$dotfiles_dir/python/requirements.in" > "$dotfiles_dir/python/requirements.txt"
    pip install --upgrade pip
    pip install -r "$dotfiles_dir/python/requirements.txt"

    ###############################################################################
    # NVM


fi

###############################################################################
# End
echo 'All tasks done!'
