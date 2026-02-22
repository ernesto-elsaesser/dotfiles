GIT_PROMPT='/usr/share/git-core/contrib/completion/git-prompt.sh'
C1='\[\e[32m\]'
C2='\[\e[96m\]'
CX='\[\e[0m\]'
if [[ -f $GIT_PROMPT ]]; then
    source $GIT_PROMPT
    PROMPT_COMMAND='__git_ps1 "${C1}\u@\h${CX}:${C2}\w${CX}" "\\\$ "'
fi
