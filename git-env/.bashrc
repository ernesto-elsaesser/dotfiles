source ~/dotfiles/git-env/git-prompt.sh
GIT_PS1_SHOWUPSTREAM='verbose'
PROMPT_COMMAND='__git_ps1 "\w" " > "'

source ~/dotfiles/git-env/aliases.sh

BRANCH_DIR='.git/refs/remotes/origin'
if [ -e "$BRANCH_DIR" ]
then
    complete -W "$(ls $BRANCH_DIR)" co
    complete -W "$(ls $BRANCH_DIR)" bd
fi
