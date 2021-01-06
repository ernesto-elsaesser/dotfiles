source ~/dotfiles/git-env/git-prompt.sh
GIT_PS1_SHOWUPSTREAM='verbose'
PROMPT_COMMAND='__git_ps1 "\w" " > "'

source ~/dotfiles/git-env/aliases.sh

BRANCHES=$(git branch | sed 's/[* ] //')
complete -W "$BRANCHES" co
complete -W "$BRANCHES" bd
