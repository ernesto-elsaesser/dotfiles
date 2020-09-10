CONFIG_DIR=`pwd`

echo "PATH=$CONFIG_DIR:\$PATH" >> ~/.bashrc
source ~/.bashrc
echo "so $CONFIG_DIR/vimrc" >> ~/.vimrc

