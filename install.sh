#!/bin/bash

echo "Installing custom bashrc ..."
echo "source $PWD/bashrc" >> "$HOME/.bashrc"

echo "Generating .gitconfig ..."
cat <<EOF > "$HOME/.gitconfig"
[user]
    email = ernesto.elsaesser@gmail.com
[include]
    path = $PWD/gitconfig
EOF

echo "Linking .tmux.conf ..."
rm -f "$HOME/.tmux.conf"
ln -s "$PWD/tmux.conf" "$HOME/.tmux.conf"

echo "Linking .vimrc ..."
rm -f "$HOME/.vimrc"
ln -s "$PWD/vimrc" "$HOME/.vimrc"

