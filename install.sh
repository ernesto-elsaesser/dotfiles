#!/bin/bash

DOT_DIR="$HOME/dotfiles"

echo "Installing custom bashrc ..."
echo "source $DOT_DIR/bashrc" >> "$HOME/.bashrc"

echo "Generating .gitconfig ..."
cat <<EOF > "$HOME/.gitconfig"
[user]
    email = ernesto.elsaesser@gmail.com
[include]
    path = $DOT_DIR/gitconfig
EOF

echo "Linking .tmux.conf ..."
rm -f "$HOME/.tmux.conf"
ln -s "$DOT_DIR/tmux.conf" "$HOME/.tmux.conf"

echo "Linking .vimrc ..."
rm -f "$HOME/.vimrc"
ln -s "$DOT_DIR/vimrc" "$HOME/.vimrc"

