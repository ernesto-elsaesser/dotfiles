alias v='vim .'

if [ -d "$HOME/anaconda3" ]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
    alias c='conda'
    alias e='c activate'
    alias d='c deactivate'
    alias b='e base'
    alias x='c remove --all -n '
fi
