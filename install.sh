SHELL_INIT_FILE=~/.bashrc

echo "
alias v='vim +16Lexplore'
" >> $SHELL_INIT_FILE

echo "
so `pwd`/settings.vim
" >> ~/.vimrc

