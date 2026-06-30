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
G="git@github.com:ernesto-elsaesser"
alias gi='git init --inital-branch=main'
alias gk='git clone'
alias gl='git log -10 --format=reference'
alias gf='git fetch'
alias gg='git pull --ff-only'
alias gs='git status'
alias ga='git add --all'
alias gc='git commit -m'
alias gp='git push'

git_user() {
  git config --global user.name "Ernesto Elsäßer"
  git config --global user.email "ernesto.elsaesser@$1"
}

# --- python ---
alias p='python3'
alias h='eval "$($HOME/miniforge3/bin/conda shell.bash hook)"'
alias a='conda activate'
alias d='conda deactivate'
alias cl='conda env list'
alias cc='conda create -n'
alias ce='conda export >'
alias ci='conda install'
alias cr='conda remove --all -n'

# --- system ---
alias sd='sudo dnf'
alias sc='sudo systemctl'
alias sg='sudo grub2-mkconfig -o /boot/grub2/grub.cfg'
