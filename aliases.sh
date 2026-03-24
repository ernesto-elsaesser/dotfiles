export EDITOR=/usr/bin/vim

# ls (A = almost all, F = classify)
alias ll='ls -lhF --color=auto'
alias la='ls -lhAF --color=auto'
alias sl='sudo ls -lhAF --color=auto'

# vim
alias v='vim'
alias nv='nvim'
alias sv='sudo vim -u $HOME/.vimrc'

# git (subcommand aliases in gitconfig)
alias g='git'

# python
alias p='python3'
alias h='eval "$($HOME/miniforge3/bin/conda shell.bash hook)"'
alias n='conda create -n'
alias a='conda activate'
alias e='conda export > environment.yaml'
alias d='conda deactivate'
alias i='conda install'
alias r='conda remove --all -n'

# misc
alias c='clear'
alias gr='grep --color=auto'
alias sd='sudo dnf'
