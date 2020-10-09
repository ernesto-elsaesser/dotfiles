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

let g:netrw_banner=0
let g:netrw_liststyle=1
let g:netrw_list_hide='^\.[^.]'
let g:netrw_sort_sequence='\/,*'
let g:netrw_sizestyle='H'

hi MatchParen ctermfg=Green ctermbg=NONE
hi LineNr ctermfg=DarkGray
hi CursorLineNr cterm=NONE ctermbg=White ctermfg=Black
hi CursorLine cterm=NONE
hi link netrwMarkFile Title

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

fun! ExecFile(pre, post)
    let g:exec_file_cmd = a:pre.' '.expand('%:p').' '.a:post
    let g:exec_file_buf_nr = term_start(g:exec_file_cmd)
    let g:exec_file_win_id = win_findbuf(g:exec_file_buf_nr)[0]
endfun

fun! ReExecFile()
    call win_gotoid(g:exec_file_win_id)
    term_start(g:exec_file_cmd, {'curwin': 1})
endfun

fun! ExecMem() 
    let l:job = term_getjob(g:exec_file_buf_nr)
    let l:pid = job_info(l:job)['process']
    let l:statm = system('cat /proc/'.l:pid.'/statm')
    let l:arr = split(l:statm, ' ')
    let l:mem = l:arr[0] * 4
    echo "PID ".l:pid.": ".l:mem." KB RAM"
endfun

fun! MySQL(login, database)
    exec 'ter ++close mysql --login-path="'.a:login.'" '.a:database
endfun

fun! MySQLExec(login, database, ...)
    let l:sql = join(a:000, ' ')
    exec 'ter mysql --login-path="'.a:login.'" '.a:database.' -e "'.l:sql.'"'
endfun

let g:sysconf_dir = expand('<sfile>:p:h')
let g:sysconf_pull = '!cd '.g:sysconf_dir.' && git pull'
let g:sysconf_cnp = g:sysconf_dir.'/commit-and-push.sh'

com! H exec "Explore ".getcwd()
com! U so ~/.vimrc
com! UR exec g:sysconf_pull | so ~/.vimrc
com! S sub/\%#\([^,]*\), \([^,)\]]*\)/\2, \1/
nmap gl :S<cr><c-o>
com! CX !chmod +x %

com! G exec 'ter ++close '.g:sysconf_cnp
com! GD ter git --no-pager diff
com! GP !git pull
com! D call DiffGit()

com! -nargs=? -complete=file R call ExecFile('', <q-args>)
com! -nargs=? -complete=file RP call ExecFile('python3 -i', <q-args>)
com! RR call ReExecFile()
com! RM call ExecMem()

com! P ter ++close python3
com! PL compiler pylint | make %

com! -nargs=+ M call MySQL(<f-args>)
com! -nargs=+ ME call MySQLExec(<f-args>)
