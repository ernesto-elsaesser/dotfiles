source ~/dotfiles/git-env/git-prompt.sh
GIT_PS1_SHOWUPSTREAM='verbose'
precmd () { __git_ps1 "%~" " > " }

source ~/dotfiles/git-env/aliases.sh

branch_dir='.git/refs/remotes/origin'
if [ -e "$branch_dir" ]
then
    compctl -k $(ls $branch_dir) co
    compctl -k $(ls $branch_dir) bd
fi
