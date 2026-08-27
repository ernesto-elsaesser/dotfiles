export DOTDIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

# --- shell ---
PS1="${CONDA_PREFIX:+($CONDA_DEFAULT_ENV) }\[\e[01;32m\]\u@\h\[\e[0m\]:\[\e[01;34m\]\w\[\e[0m\]\$ "
alias c='clear'
alias ft='column -t'
alias fc='column -t -s,'

# --- ls --- (A = almost all, F = classify)
alias ll='ls -lhF --color=auto'
alias la='ls -lhAF --color=auto'
alias sl='sudo ls -lhAF --color=auto'

# --- tmux ---
alias tu='systemd-run --user --service-type=forking --unit=tmux tmux new -d -s main'
alias ts='systemctl --user status tmux'
alias ta='tmux attach'

# --- vim ---
alias v='vim -u $DOTDIR/vimrc'
alias sv='sudo DOTDIR=$DOTDIR vim -u $DOTDIR/vimrc'

# --- git ---

gu() {
  git config --global user.name "Ernesto Elsäßer"
  git config --global user.email "ernesto.elsaesser@$1"
}

go() {
  git clone git@github.com:ernesto-elsaesser/$1
}

alias gi='git init --initial-branch=main'
alias gk='git clone'
alias gl='git log -10 --format=reference'
alias gf='git fetch'
alias gp='git pull --ff-only'
alias gs='git status'
alias ga='git add --all'
alias gx='git commit -a -m'
alias gc='git commit -m'
alias gv='git push'
alias gr='git reset --hard'

# --- python ---
alias p='python'
alias h='python -m pydoc'
alias up='uv run python'
alias uh='uv run python -m pydoc'
alias a='conda activate'
alias d='conda deactivate'
alias cl='conda env list'
alias cc='conda create -n'
alias ce='conda export >'
alias ci='conda install'
alias cr='conda remove --all -n'
alias vd='deactivate'

# --- system ---
alias sc='sudo systemctl'

