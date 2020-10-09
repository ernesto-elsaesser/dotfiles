unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set background=dark
set mouse=
set hidden
set number
set cursorline
set laststatus=2
set complete=.,t completeopt=
set tabstop=4 shiftwidth=4 expandtab
set noswapfile nowrap
set splitright splitbelow

hi MatchParen ctermfg=Green ctermbg=NONE
hi LineNr ctermfg=DarkGray
hi CursorLineNr cterm=NONE ctermbg=White ctermfg=Black
hi CursorLine cterm=NONE


"----- config -----

let g:sysconf_dir = expand('<sfile>:p:h')

com! U so ~/.vimrc
com! UR exec '!cd '.g:sysconf_dir.' && git pull' | U


"---- terminal -----

fun! TermRun(pre, post)
    let g:run_cmd = a:pre.' '.expand('%:p').' '.a:post
    let g:run_buf_nr = term_start(g:run_cmd)
    let g:run_win_id = win_findbuf(g:run_buf_nr)[0]
endfun

fun! TermRerun()
    call win_gotoid(g:run_win_id)
    term_start(g:run_cmd, {'curwin': 1})
endfun

fun! TermMemory() 
    let l:job = term_getjob(g:exec_file_buf_nr)
    let l:pid = job_info(l:job)['process']
    let l:statm = system('cat /proc/'.l:pid.'/statm')
    let l:arr = split(l:statm, ' ')
    let l:mem = l:arr[0] * 4
    echo "PID ".l:pid.": ".l:mem." KB RAM"
endfun

com! -nargs=? -complete=file R call TermRun('', <q-args>)
com! RR call TermRerun()
com! RM call TermMemory()


"----- git ------

let g:diff_branch='master'

fun! DiffGit()
    cd .
    let @d = system("git show ".g:diff_branch.":./".bufname('%'))
    let l:ft = &ft
    let l:ln = line('.')
    setlocal diff scrollbind
    vert new
    exec "set bt=nofile bh=wipe ft=".l:ft
    autocmd BufWipeout <buffer> diffoff!
    put d
    0delete
    exec l:ln
    setlocal diff scrollbind 
    diffupdate
endfun

com! G exec 'ter ++close '.g:sysconf_dir.'/commit-and-push.sh'
com! GD ter git --no-pager diff
com! GP !git pull
com! D call DiffGit()


"----- mysql -----

fun! MySQL(login, database)
    exec 'ter ++close mysql --login-path="'.a:login.'" '.a:database
endfun

fun! MySQLExec(login, database, ...)
    let l:sql = join(a:000, ' ')
    exec 'ter mysql --login-path="'.a:login.'" '.a:database.' -e "'.l:sql.'"'
endfun

com! -nargs=+ M call MySQL(<f-args>)
com! -nargs=+ ME call MySQLExec(<f-args>)


"----- ptyhon -----

com! P ter ++close python3
com! -nargs=? -complete=file RP call TermRun('python3 -i', <q-args>)
com! PL compiler pylint | make %


"----- misc -----

com! S sub/\%#\([^,]*\), \([^,)\]]*\)/\2, \1/
nmap gl :S<cr><c-o>
com! CX !chmod +x %
