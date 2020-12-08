source /etc/profile

MSG_FILE="$HOME/.commit_msg"

alias l='ls -lah'
alias s='git status'
alias u='git pull'
alias a='git add --all; git status'
alias m='echo > $MSG_FILE'
alias c='git commit -F $MSG_FILE'
alias p='git push; rm $MSF_FILE'

alias pc='c; p'
alias ca='a; c'
alias pa='a; c; p'

alias pu='git push -u origin HEAD'
alias co='git checkout'
alias lo='git log --pretty=oneline'
alias cb='git checkout -b'
alias bd='git branch -d'
alias rb='git rebase'
alias rh='git reset --hard'

