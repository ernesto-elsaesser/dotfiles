# set up git prompt showing branch name and upstream status
source ~/dotfiles/git-env/git-prompt.sh
GIT_PS1_SHOWUPSTREAM='verbose'
precmd () { __git_ps1 "%~" " > " }

# set up aliases
source ~/dotfiles/git-env/aliases.sh

# set up auto-completion for aliases
branches=($(list_branches))
compctl -k branches co
compctl -k branches bd
