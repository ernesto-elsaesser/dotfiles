# --- shell ---
PS1="${CONDA_PREFIX:+($CONDA_DEFAULT_ENV) }\[\e[01;32m\]\u@\h\[\e[0m\]:\[\e[01;34m\]\w\[\e[0m\]\$ "
alias c='clear'
alias ll='ls -lhF --color=auto'
alias la='ls -lhAF --color=auto'
alias sl='sudo ls -lhAF --color=auto'
# A = almost all, F = classify

# --- vim ---
export EDITOR=/usr/bin/vim
alias v='vim'
alias nv='nvim -u $HOME/.vimrc'
alias sv='sudo vim -u $HOME/.vimrc'

# --- git ---
GH="git@github.com:ernesto-elsaesser/"
alias g='git'
# subcommand aliases in gitconfig

# --- python ---
alias p='python3'
alias h='eval "$($HOME/miniforge3/bin/conda shell.bash hook)"'
alias n='conda create -n'
alias a='conda activate'
alias e='conda export > environment.yaml'
alias d='conda deactivate'
alias i='conda install'
alias r='conda remove --all -n'

# --- rhel ---
alias sd='sudo dnf'
