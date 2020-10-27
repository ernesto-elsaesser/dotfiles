DOTFILES_DIR=`dirname "$(realpath $0)"`
ln -s "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
