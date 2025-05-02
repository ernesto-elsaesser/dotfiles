DOT_DIR="$HOME/dotfiles"

alias v='vim -u "$DOT_DIR/vimrc"'
alias g='git -c "include.path=$DOT_DIR/gitconfig"'
alias l='ls -lhp --group-directories-first'
alias la='ls -lhpA --group-directories-first'
alias t='tmux new-session -s'
alias tl='tmux list-sessions'
alias ta='tmux attach-session -t'
alias d='deactivate'
alias p='python3'
alias n='nvtop -p'
alias c='clear'

function e {
    source "$HOME/.virtualenvs/$1/bin/activate"
}

function x {
    eval "$(/home/ee/miniforge3/bin/conda shell.bash hook)"
}
