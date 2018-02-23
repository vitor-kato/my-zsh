#!/bin/bash

read -r -p "Did you WGET this file? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
  sudo apt-get update
  sudo apt-get install -y zsh git
  git clone https://github.com/vitor-kato/my-zsh
  cd my-zsh/
else
  sudo apt-get update
  sudo apt-get install -y zsh
fi
git submodule update --init
ln -sf $(pwd)/zshrc ~/.zshrc ;
ln -sf $(pwd)/oh-my-zsh ~/.oh-my-zsh ;
ln -sf $(pwd)/custom/* ~/.oh-my-zsh/custom/plugins ;
#change default shell to zsh
chsh -s $(which zsh) ;
