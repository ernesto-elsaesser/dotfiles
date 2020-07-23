echo "domain for git e-mail: "
read DOMAIN

CONFIG_DIR=`pwd`

BASH_CONF="source $CONFIG_DIR/aliases\n"
echo -e $BASH_CONF > ~/.bashrc

ln -s "$CONFIG_DIR/settings.vim" ~/.vimrc

GIT_CONF="[include]\n\tpath=$CONFIG_DIR/gitconfig\n\n[user]\n\temail=ernesto.elsaesser@$DOMAIN\n"
echo -e $GIT_CONF > ~/.gitconfig

