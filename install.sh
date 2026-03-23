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

echo "Linking .tmux.conf ..."
rm -f "$HOME/.tmux.conf"
ln -s "$PWD/tmux.conf" "$HOME/.tmux.conf"

echo "Linking .vimrc ..."
rm -f "$HOME/.vimrc"
ln -s "$PWD/init.vim" "$HOME/.vimrc"

read -p "neovim? "
if [[ $REPLY = "y" ]]; then
    echo "Linking init.vim ..."
    mkdir -p "$HOME/.config/nvim"
    ln -s "$PWD/init.vim" "$HOME/.config/nvim/init.vim"
fi

