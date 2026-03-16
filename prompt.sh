COL='\[\e[32m\]'
END='\[\e[0m\]'
PS1="${CONDA_PREFIX:+($CONDA_DEFAULT_ENV) }${COL}\u@\h${END}:\w $ "
