#!/usr/bin/env bash
################################
# Start
echo 'Starting...'
################################
# Bash
echo 'Copying bash configuration files...'
ln -fs "$(pwd)/bash/.bashrc" ~/.bashrc
ln -fs "$(pwd)/bash/.bash_aliases" ~/.bash_aliases
echo 'Done! Bash configuration installed.'
################################
# Zsh
echo 'Copying zsh configuration files...'
ln -fs "$(pwd)/bash/.bashrc" ~/.bashrc
ln -fs "$(pwd)/bash/.bash_aliases" ~/.bash_aliases
echo 'Done! Bash configuration installed.'
################################
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
################################
# Tmux
echo 'Copying tmux configuration...'
echo 'Installing TPM tmux plugin manager(https://github.com/tmux-plugins/tpm)...'
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -fs "$(pwd)/tmux/.tmux.conf" ~/.tmux.conf
tmux source ~/.tmux.conf
echo 'Done! Tmux configuration installed. Run it and press `prefix` + I to complete install plugins.'
################################
# Vim
echo 'Copying vim configuration...'
################################
# MC
echo 'Copying mc configuration...'
################################
# Htop
echo 'Copying htop configuration...'
################################
echo 'All tasks done!'
