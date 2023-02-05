#!/bin/bash

cd "${BASH_SOURCE%/*}"
DOT_DIR=`pwd`
echo -e "source $DOT_DIR/vimrc\n" > /etc/vim/vimrc
