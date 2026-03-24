#!/usr/bin/env bash
set -o nounset
set -o errexit

dotfiles_dir="$HOME/.dotfiles"
zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

###############################################################################
# Helpers

clone_or_pull() {
    local repo="$1"
    local dest="$2"
    if [ -d "$dest/.git" ]; then
        echo "  Updating $dest..."
        git -C "$dest" pull --quiet || echo "  Warning: pull failed for $dest, skipping"
    else
        echo "  Cloning $repo..."
        rm -rf "$dest"
        git clone --quiet "$repo" "$dest"
    fi
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

###############################################################################
echo 'Starting...'

# System packages
echo '==> System packages'
sudo apt-get update -qq && sudo apt-get install -y -qq git zsh tmux vim nano curl wget unzip fzf direnv

# Dotfiles repo
echo '==> Dotfiles'
clone_or_pull git@github.com:ip0000h/dotfiles.git "$dotfiles_dir"

###############################################################################
echo '==> Oh My Zsh'
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo '  Updating oh-my-zsh...'
    git -C "$HOME/.oh-my-zsh" pull --quiet
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo '==> Zsh plugins'
clone_or_pull https://github.com/zsh-users/zsh-autosuggestions "$zsh_custom/plugins/zsh-autosuggestions"
clone_or_pull https://github.com/zsh-users/zsh-syntax-highlighting.git "$zsh_custom/plugins/zsh-syntax-highlighting"
clone_or_pull https://github.com/zsh-users/zsh-completions "$zsh_custom/plugins/zsh-completions"
clone_or_pull https://github.com/MichaelAquilina/zsh-you-should-use.git "$zsh_custom/plugins/you-should-use"

echo '==> Symlinks'
ln -fs "$dotfiles_dir/zsh/.zshrc" ~/.zshrc
ln -fs "$dotfiles_dir/tmux/.tmux.conf" ~/.tmux.conf

###############################################################################
echo '==> Tmux plugins'
mkdir -p ~/.tmux/plugins
clone_or_pull https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

###############################################################################
echo '==> CLI tools'

# Zoxide
echo '  zoxide...'
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Kubectx/Kubens
echo '  kubectx/kubens...'
if [ -d /opt/kubectx/.git ]; then
    sudo git -C /opt/kubectx pull --quiet
else
    sudo rm -rf /opt/kubectx
    sudo git clone --quiet https://github.com/ahmetb/kubectx /opt/kubectx
fi
sudo ln -fs /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -fs /opt/kubectx/kubens /usr/local/bin/kubens

###############################################################################
echo '==> Nano'
if [ ! -d "$HOME/.nano" ]; then
    curl -L https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh
else
    echo '  nano configs already installed'
fi

###############################################################################
echo '==> UV + Python'
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"
uv python install 3.14
cd "$dotfiles_dir/python" && uv sync

###############################################################################
echo '==> All done!'
