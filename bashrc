DOT_DIR="$HOME/dotfiles"
PYDIST_DIR="$HOME/miniforge3"

alias v='vi -u "$DOT_DIR/vimrc"'
alias g='git -c "include.path=$DOT_DIR/gitconfig"'
alias l='ls -lhp --group-directories-first'
alias la='ls -lhpA --group-directories-first'
alias t='tmux new-session -s'
alias tl='tmux list-sessions'
alias ta='tmux attach-session -t'
alias p='python3'
alias d='conda deactivate'
alias i='conda install'
alias n='nvtop -p'
alias c='clear'

function a {
    source "$PYDIST_DIR/bin/activate" "$PYDIST_DIR/envs/$1"
}
