#!/usr/bin/env bash
set -o nounset
set -o errexit

###############################################################################
# Start
echo 'Starting...'

dotfiles_dir=~/.dotfiles

if [ -d "$dotfiles_dir" ]; then
    echo 'Dotfiles directory already exist! Updating...'
    cd "$dotfiles_dir"
    git pull
else
    # needed apps
    sudo apt-get update && sudo apt-get install -y git zsh tmux vim nano fzf direnv

    git clone git@github.com:ip0000h/dotfiles.git $dotfiles_dir

    ###############################################################################
    # Zsh
    echo 'Installing oh-my-zsh(http://ohmyz.sh/)...'
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo 'oh-my-zsh is already installed!'
    else
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
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
    # CLI tools
    echo 'Installing zoxide...'
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    echo 'Installing kubectx/kubens...'
    sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
    sudo ln -fs /opt/kubectx/kubectx /usr/local/bin/kubectx
    sudo ln -fs /opt/kubectx/kubens /usr/local/bin/kubens
    echo 'Done! CLI tools installed.'

    ###############################################################################
    # Nano
    echo 'Installing nano configs(https://github.com/scopatz/nanorc)...'
    curl -L https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

    ###############################################################################
    # UV + Python
    echo 'Installing uv(https://github.com/astral-sh/uv)...'
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
    uv python install 3.14
    cd "$dotfiles_dir/python" && uv sync
    echo 'Done! UV and Python configuration installed.'

fi

###############################################################################
# End
echo 'All tasks done!'
