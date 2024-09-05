DOT_DIR="$HOME/dotfiles"

alias v='vim -u "$DOT_DIR/vimrc"'
alias g='git -c "include.path=$DOT_DIR/gitconfig"'
alias l='ls -lhp'
alias la='ls -lhpA'
alias d='deactivate'
alias p='python3'
alias ,='fc -s -1'

function e {
    source "$HOME/.virtualenvs/$1/bin/activate"
}
