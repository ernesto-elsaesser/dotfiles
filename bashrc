# --- shell ---
PS1="${CONDA_PREFIX:+($CONDA_DEFAULT_ENV) }\[\e[01;32m\]\u@\h\[\e[0m\]:\[\e[01;34m\]\w\[\e[0m\]\$ "
alias c='clear'
alias ll='ls -lhF --color=auto'
alias la='ls -lhAF --color=auto'
alias sl='sudo ls -lhAF --color=auto'
# A = almost all, F = classify

# --- vim ---
export EDITOR=$(command -v nvim || command -v vim)
alias v='$EDITOR -u $HOME/dotfiles/vimrc'
alias sv='sudo $EDITOR -u $HOME/dotfiles/vimrc'

# --- git ---
G="git@github.com:ernesto-elsaesser"
alias gc='git clone'
alias gf='git fetch --all'
alias gb='git checkout'
alias gg='git pull'
alias gs='git status'
alias gl='git log -10'
alias gr='git reset'
# HEAD = unstage; --hard HEAD = discard all changes;
# HEAD^ = edit last commit; --hard HEAD^ = revert to previous commit;
alias ga='git commit --amend'
# -m = edit message; --no-edit = add staged changes;

# --- python ---
alias p='python3'
alias h='eval "$($HOME/miniforge3/bin/conda shell.bash hook)"'
alias n='conda create -n'
alias a='conda activate'
alias e='conda export > environment.yaml'
alias d='conda deactivate'
alias i='conda install'
alias x='conda remove --all -n'

# --- rhel ---
alias sd='sudo dnf'
