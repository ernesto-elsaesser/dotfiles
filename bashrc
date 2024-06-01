DOT_DIR="$HOME/dotfiles"

alias v='vim -u "$DOT_DIR/vimrc"'
alias g='git -c "include.path=$DOT_DIR/gitconfig"'
alias l='ls -lhp'
alias la='ls -lhpA'

function e {
    source "$HOME/.virtualenvs/$1/bin/activate"
}
