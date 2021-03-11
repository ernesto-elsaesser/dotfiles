# set up git prompt showing branch name and upstream status
source ~/dotfiles/git-env/git-prompt.sh
GIT_PS1_SHOWUPSTREAM='verbose'
precmd () { __git_ps1 "%~" " > " }

# set up aliases
source ~/dotfiles/git-env/aliases.sh

# set up auto-completion for aliases
compctl -k ($(list_branches)) co
compctl -k ($(list_branches)) bd

# update auto-completion on fetch
alias fu='f; compctl -k ($(list_branches)) co'
