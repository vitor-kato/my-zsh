#!/bin/sh
SUDO=''
if [ $(id -u) -ne 0 ]; then
    SUDO='sudo'
fi

$SUDO apt update
$SUDO apt install -y zsh git

git clone https://github.com/vitor-kato/my-zsh
cd my-zsh/
git submodule update --init

ln -sf $(pwd)/zshrc ~/.zshrc
ln -sf $(pwd)/oh-my-zsh ~/.oh-my-zsh
ln -sf $(pwd)/custom/* ~/.oh-my-zsh/custom/plugins
#change default shell to zsh
chsh -s $(which zsh)
zsh
