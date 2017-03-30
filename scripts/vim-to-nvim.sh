#!/bin/bash
echo "Setting up zsh..."
echo "alias vim='nvim'" >> .zshrc

echo "Switch from Pathogen to vim-plug..."
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
rm -rf ~/.vim/bundle
curl -fLo ~/.config/nvim/init.vim --create-dirs \
    https://lab.marcel-kapfer.de/config/init.vim

echo "Installing Python 3 neovim plugin..."
sudo apt-get update
sudo apt-get install python3-pip
sudo pip3 install neovim

echo "Remove vim-latexsuite package..."
sudo apt-get remove vim-latexsuite
sudo apt-get autoremove

echo "Start now nvim of vim and execute the following commands:
    :PlugInstall
    :UpdateRemotePlugins
then restart neovim and enjoy your new neovim experience."
