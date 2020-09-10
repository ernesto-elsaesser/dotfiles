CONFIG_DIR=`pwd`

echo "so $CONFIG_DIR/vimrc
com! UR ter $CONFIG_DIR/update.sh
" >> ~/.vimrc

