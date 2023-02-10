alias v='vi .'
alias g='git'

if [ -d "$HOME/anaconda3" ]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
    alias e='conda activate'
    alias b='e base'
fi
