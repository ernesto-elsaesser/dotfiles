#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
  echo "Appending aliases to .zshrc ..."
  echo "source $PWD/aliases" >> "$HOME/.zshrc"
else
  echo "Appending aliases to .bashrc ..."
  echo "source $PWD/aliases" >> "$HOME/.bashrc"
fi

echo "Copying .gitconfig ..."
cp gitconfig "$HOME/.gitconfig"

echo "Linking .vimrc ..."
rm -f "$HOME/.vimrc"
ln -s "$PWD/init.vim" "$HOME/.vimrc"

if [[ -x "$(command -v nvim)" ]]; then
  echo "Linking .config/nvim/init.vim ..."
  mkdir -p $HOME/.config/nvim
  rm -f "$HOME/.config/nvim/init.vim"
  ln -s "$PWD/init.vim" "$HOME/.config/nvim/init.vim"
fi
