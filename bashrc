# --- shell ---
PS1="${CONDA_PREFIX:+($CONDA_DEFAULT_ENV) }\[\e[01;32m\]\u@\h\[\e[0m\]:\[\e[01;34m\]\w\[\e[0m\]\$ "
alias c='clear'

# --- ls --- (A = almost all, F = classify)
alias ll='ls -lhF --color=auto'
alias la='ls -lhAF --color=auto'
alias sl='sudo ls -lhAF --color=auto'

# --- vim ---
VIMRC=$(readlink -f "${BASH_SOURCE[0]/bashrc/vimrc}")
alias v="vim -u $VIMRC"
alias vv="vim -u $VIMRC ."
alias sv="sudo vim -u $VIMRC"

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
alias gg='git pull --ff-only'
alias gs='git status'
alias ga='git add --all'
alias gx='git commit -a -m'
alias gc='git commit -m'
alias gp='git push'

# --- python ---
alias p='python'
alias h='python -m pydoc'
alias ui='uv init --no-package'
alias ur='uv run'
alias up='uv run python'
alias uh='uv run python -m pydoc'

# --- system ---
alias sc='sudo systemctl'

