# set up git prompt showing branch name and upstream status
source ~/dotfiles/git-env/git-prompt.sh
GIT_PS1_SHOWUPSTREAM='verbose'
PROMPT_COMMAND='__git_ps1 "\w" " > "'

# set up aliases
source ~/dotfiles/git-env/aliases.sh

# update auto-completion for aliases
function cm {
    BRANCHES=`git branch -a | sed 's/[* ] \(remotes\/origin\/\)\?//'`
    complete -W "$BRANCHES" co
    complete -W "$BRANCHES" bd
}
