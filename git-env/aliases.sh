function identify {
  git config --global user.email "ernesto.elsaesser@me.com"
  git config --global user.name "Ernesto Elsaesser"
}
alias id='identify'

alias f='git fetch --all'

alias pl='git pull --ff-only'

alias s='git status -s'

alias a='git add --all; s'
alias af='git add $F'

function commit_as {
    # use function to allow unquoted message
    git commit -m "$*"
}
alias c='commit_as'

alias ca='commit --amend --no-edit'

alias d='git diff'
alias ds='git diff --staged'

alias p='git push'
alias pu='git push -u origin HEAD'
alias pf='git push --force'

function push_all {
    git add --all
    git commit -m "$*"
    git push
}
alias pa='push_all'

alias m='git merge --no-edit'
alias mm='git merge --no-edit origin/master'

alias co='git checkout'
alias cb='git checkout -b'

alias l='git log -10 --pretty=format:"%h %s (%an %ar)"'

alias b='git branch'
alias ba='git branch -a'
alias bv='git branch -vv'
alias bd='git branch -d'

function list_branches {
    # used for auto-completion
    git branch -a | sed 's/[* ] \(remotes\/origin\/\)\?//'
}

alias rb='git rebase'
alias ri='git rebase -i HEAD~'

alias u='git reset HEAD~'
alias rh='git reset --hard'
