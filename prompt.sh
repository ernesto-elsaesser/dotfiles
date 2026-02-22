C1='\[\e[32m\]'
C2='\[\e[96m\]'
CX='\[\e[0m\]'
[[ "$(type -t __git_ps1)" = 'function' ]] && PROMPT_COMMAND='__git_ps1 "${C1}\u@\h${CX}:${C2}\w${CX}" "\\\$ "'
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
