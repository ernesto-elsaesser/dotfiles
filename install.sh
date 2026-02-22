#!/bin/bash

echo "Loading aliases in .bashrc ..."
echo "source $PWD/aliases.sh" >> "$HOME/.bashrc"

echo "Loading prompt in .bashrc ..."
echo "source $PWD/prompt.sh" >> "$HOME/.bashrc"

echo "Generating .gitconfig ..."
cat <<EOF > "$HOME/.gitconfig"
[user]
    email = ernesto.elsaesser@gmail.com
[include]
    path = $PWD/gitconfig
EOF

echo "Linking .vimrc ..."
rm -f "$HOME/.vimrc"
ln -s "$PWD/init.vim" "$HOME/.vimrc"
