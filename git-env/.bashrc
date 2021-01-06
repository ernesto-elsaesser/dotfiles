source ~/dotfiles/git-env/git-prompt.sh
GIT_PS1_SHOWUPSTREAM='verbose'
PROMPT_COMMAND='__git_ps1 "\w" " > "'

source ~/dotfiles/git-env/git-completion.bash
__git_complete co _git_checkout
__git_complete bd _git_checkout

source ~/dotfiles/git-env/aliases.sh
