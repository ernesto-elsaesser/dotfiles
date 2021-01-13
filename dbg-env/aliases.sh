alias r='perl'
alias rf='perl $F'

function perl_ex {
    perl -e "$*"
}
alias re='perl_ex'

alias p='python3'
alias pf='python3 $F'
alias pi='python3 -i'
alias pm='python3 -m'

function python_cmd {
    python3 -c "print($1)"
}
alias pc='python_cmd'

alias ca='conda activate'
alias cx='conda deactivate'

alias s='ssh -t'
