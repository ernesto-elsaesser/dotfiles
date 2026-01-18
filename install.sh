#!/bin/bash

rcfile=".bashrc"
[[ "$(uname)" == "Darwin" ]] && rcfile=".zshrc"

echo "Appending aliases to $rcfile ..."
echo "source $PWD/aliases" >> "$HOME/$rcfile"

echo "Generating .gitconfig ..."
cat <<EOF > "$HOME/.gitconfig"
[user]
    name = Ernesto Elsäßer
    email = ernesto.elsaesser@gmail.com
[include]
    path = $PWD/gitconfig
EOF

echo "Linking .vimrc ..."
rm -f "$HOME/.vimrc"
ln -s "$PWD/init.vim" "$HOME/.vimrc"
