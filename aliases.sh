export EDITOR=/usr/bin/vim

# ls (A = almost all, F = classify)
alias l='ls -F --color=auto'
alias la='ls -AF --color=auto'
alias ll='ls -lhAF --color=auto'
alias sl='sudo ls -lhAF --color=auto'

# vim
alias v='vim -c 15Lexplore'
alias sv='sudo vim -u $HOME/.vimrc'

# git (subcommand aliases in gitconfig)
alias g='git'

# tmux
alias t='tmux new-session -s'
alias tl='tmux list-sessions'
alias ta='tmux attach-session -t'

# python
alias p='python3'
alias h='eval "$($HOME/miniforge3/bin/conda shell.bash hook)"'
alias n='conda create -n'
alias a='conda activate'
alias d='conda deactivate'
alias i='conda install'
alias r='conda remove --all -n'

# misc
alias c='clear'
alias gr='grep --color=auto'
alias sd='sudo dnf'
