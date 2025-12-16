#!/bin/bash

# source aliases
echo "source $PWD/aliases" >> $HOME/.bashrc

# copy stable-ish config so email can be changed
cp gitconfig "$HOME/.gitconfig"

# link frequently changing aliases and mappings
ln -s init.vim "$HOME/.vimrc"

if [ -x "$(command -v nvim)" ]; do
  mkdir -p $HOME/.config/nvim
  ln -s init.vim "$HOME/.config/nvim/init.vim"
done
