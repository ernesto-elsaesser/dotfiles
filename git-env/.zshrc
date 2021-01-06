source ~/dotfiles/git-env/git-prompt.sh
GIT_PS1_SHOWUPSTREAM='verbose'
precmd () { __git_ps1 "%~" " > " }

fpath=(~/dotfiles/git-env $fpath)
zstyle ':completion:*:*:git:*' script ~/dotfiles/git-env/git-completion.bash
autoload -Uz compinit && compinit

source ~/dotfiles/git-env/aliases.sh
