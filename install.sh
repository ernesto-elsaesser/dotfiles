#!/bin/bash

cd "${BASH_SOURCE%/*}"
DOT_DIR=`pwd`
echo -e ". $DOT_DIR/aliases.sh\n" >> ~/.bashrc
echo -e ". $DOT_DIR/aliases.sh\n" >> ~/.profile
echo -e ". $DOT_DIR/vimrc\n" > /etc/vim/vimrc
cp gitconfig ~/.gitconfig
