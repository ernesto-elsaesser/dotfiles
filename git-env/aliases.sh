alias f='git fetch --all'

alias pl='git pull --ff-only'

alias s='git status -s'

alias co='git checkout'

# create new branch
alias cb='git checkout -b'

alias a='git add --all; s'

function commit_as {
    # use function to allow unquoted message
    git commit -m "$*"
}
alias c='commit_as'

alias p='git push'
alias pf='git push --force'

# push new branch to upstream repo
alias pu='git push -u origin HEAD'

# push all changes (!)
function push_all {
    git add --all
    git commit -m "$*"
    git push
}
alias P='push_all'

# delete branch
alias bd='git branch -d'

alias d='git diff'
alias ds='git diff --staged'

# show hash/message/author/time of last 10 commits 
alias l='git log -10 --pretty=format:"%h %s (%an %ar)"'

# add changes to last commit
alias ca='git commit --amend --no-edit'

# merge upsteam branch into current
alias m='git fetch; git merge --no-edit'

# merge master branch into current
alias mm='git fetch; git merge --no-edit origin/master'

# show branches - a = remote ones, v = incl. last  commit
alias b='git branch'
alias ba='git branch -a'
alias bv='git branch -vv'

alias rb='git rebase'

# rebase the last n commits interactively ('ri2')
alias ri='git rebase -i HEAD~'

# undo the last n commits ('u3')
alias u='git reset HEAD~'

# discard all uncommit changes
alias rh='git reset --hard'

# print commit hash of the current commit
alias h='git rev-parse HEAD'

# configure git user
function cnf {
  git config --global user.email "ernesto.elsaesser@me.com"
  git config --global user.name "Ernesto Elsaesser"
  git config --global pull.ff only
}
