source ~/dotfiles/git-env/git-prompt.sh
GIT_PS1_SHOWUPSTREAM='verbose'
precmd () { __git_ps1 "%~" " > " }

source ~/dotfiles/git-env/aliases.sh

branches=($(git branch | sed 's/[* ] //'))
compctl -k branches co
compctl -k branches bd
