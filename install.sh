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
    sudo apt-get update && sudo apt-get install -y git zsh tmux vim nano

    # pyenv deps
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev

    git clone git@github.com:ip0000h/dotfiles.git $dotfiles_dir

    ###############################################################################
    # Zsh
    echo 'Installing oh-my-zsh(http://ohmyz.sh/)...'
    if [ -d "~/.oh-my-zsh" ]; then
        echo 'oh-my-zsh is already installed!'
    else
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi
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
    # Nano
    echo 'Installing nano configs(https://github.com/scopatz/nanorc)...'
    curl -L https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

    ###############################################################################
    # PyEnv
    if [[ ! `which pyenv` ]]; then
        echo 'Installing pyenv application(https://github.com/yyuu/pyenv)...'
        curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
        echo '# PyEnv configuration' >> ~/.profile >> ~/.zprofile
        echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.profile >> ~/.zprofile
        echo 'eval "$(pyenv init -)"' >> ~/.profile >> ~/.zprofile
        echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.profile >> ~/.zprofile
        source ~/.zprofile
        pyenv update
        echo 'Done! PyEnv configuration installed.'
    else
        pyenv update
    fi

    ###############################################################################
    # Python
    pyenv install 3.12
    pyenv global 3.12
    pip install pip-tools
    pip-compile "$dotfiles_dir/python/requirements.in" > "$dotfiles_dir/python/requirements.txt"
    pip install --upgrade pip
    pip install -r "$dotfiles_dir/python/requirements.txt"

fi

###############################################################################
# End
echo 'All tasks done!'
