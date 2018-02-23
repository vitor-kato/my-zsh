#!/bin/bash
ln -sf $(pwd)/zshrc ~/.zshrc ;
ln -sf $(pwd)/oh-my-zsh ~/.oh-my-zsh ;
ln -sf $(pwd)/custom/* ~/.oh-my-zsh/custom/plugins ;
#change default shell to zsh
chsh -s $(which zsh) ;
zsh
