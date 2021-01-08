alias f='git fetch --all'

alias pl='git pull --ff-only'

alias s='git status -s'

alias a='git add --all; s'
alias af='git add $F'

function commit {
    # use function to allow unquoted message
    git commit -m "$*"
}
alias c='commit'

alias d='git diff'

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

alias co='git checkout'

alias l='git log -10 --pretty=format:"%h %s (%an %ar)"'

alias b='git branch'
alias bv='git branch -vv'
alias cb='git checkout -b'
alias bd='git branch -d'

alias rb='git rebase'

alias rh='git reset --hard'
