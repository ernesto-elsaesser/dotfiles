#!/bin/bash

cd "${BASH_SOURCE%/*}"
DOT_DIR=`pwd`
echo "source $DOT_DIR/vimrc" >> "$HOME/.vimrc"
