alias d='rm -rf'
alias l='ls -la'
alias v='vim .'
alias g='git'

if [ -d "$HOME/anaconda3" ]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
    alias c='conda'
    alias e='c activate'
    alias b='e base'
fi
