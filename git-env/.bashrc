# set up git prompt showing branch name and upstream status
source ~/dotfiles/git-env/git-prompt.sh
GIT_PS1_SHOWUPSTREAM='verbose'
PROMPT_COMMAND='__git_ps1 "\w" " > "'

# set up aliases
source ~/dotfiles/git-env/aliases.sh

# set up auto-completion for aliases
complete -W "$(list_branches)" co
complete -W "$(list_branches)" bd
