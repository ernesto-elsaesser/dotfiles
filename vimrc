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
    call term_start(g:run_cmd, {'curwin': 1})
endfun

fun! TermStatus() 
    let l:job = term_getjob(g:run_buf_nr)
    let l:pid = job_info(l:job)['process']
    exec '!cat /proc/'.l:pid.'/status'
endfun

com! -nargs=? -complete=file R call TermRun('', <q-args>)
com! RR call TermRerun()
com! RS call TermStatus()


"----- git ------

let g:diff_branch='master'

fun! DiffGit()
    cd .
    let @d = system("git show ".g:diff_branch.":./".bufname('%'))
    let l:ft = &ft
    let l:ln = line('.')
    vert new
    exec "set bt=nofile bh=wipe ft=".l:ft
    put d
    0delete
    exec l:ln
endfun

com! G exec 'ter ++close '.g:sysconf_dir.'/commit-and-push.sh'
com! GD ter git --no-pager diff
com! GP !git pull
com! D call DiffGit()


"----- mysql -----

fun! MySQL(login, database)
    exec 'ter ++close mysql --login-path="'.a:login.'" -A '.a:database
endfun

fun! MySQLExec(login, database, ...)
    let l:sql = join(a:000, ' ')
    exec 'ter mysql --login-path="'.a:login.'" -A '.a:database.' -e "'.l:sql.'"'
endfun

com! -nargs=+ M call MySQL(<f-args>)
com! -nargs=+ ME call MySQLExec(<f-args>)


"----- ptyhon -----

com! P ter ++close python3
com! -nargs=? -complete=file RP call TermRun('python3 -i', <q-args>)
com! PL compiler pylint | make %


"----- misc -----

com! S sub/\%#\([^,]*\), \([^,)}\]]*\)/\2, \1/
nmap gl :S<cr><c-o>
com! CX !chmod +x %
com! W setlocal wrap! | setlocal wrap?
com! P setlocal paste! | setlocal paste?
