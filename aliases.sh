source /etc/profile

alias l='ls -lah'
alias s='git status'
alias u='git pull'
alias a='git add --all; git status'
alias m='echo > ~/.commit_msg'
alias c='git commit -F ~/.commit_msg'
alias p='git push'

alias ca='git add --all; git commit -F ~/.commit_msg'
alias pa='git add --all; git commit -F ~/.commit_msg; git push'
alias pu='git push -u origin HEAD'
alias co='git checkout'
alias lo='git log --pretty=oneline'
alias cb='git checkout -b'
alias bd='git branch -d'
alias rb='git rebase'
alias rh='git reset --hard'

