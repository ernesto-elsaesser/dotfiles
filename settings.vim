set background=dark
set number
set textwidth=100
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set complete=.,t
set completeopt=
set noswapfile
set nowrap
set splitright
set splitbelow

let g:netrw_banner=0
let g:netrw_list_hide='^\.[^.].*'
let g:netrw_sizestyle='H'
highlight link netrwMarkFile Title
nmap <space> <cr>

fun! CommitAndPush(message, newbranch)
    !git add -v --all
    exec '!git commit -m "'.a:message.'"'
    if a:newbranch
        !git push -u origin HEAD
    else
        !git push
    endif
endfun

fun! DiffMaster()
    set diff
    set scrollbind
    vert ter git show master:%
    set diff
    set scrollbind
    sleep
    wincmd h
    diffupdate
endfun

fun! QuitDiff()
    set nodiff
    set noscrollbind
    wincmd l
    quit
endfun

fun! MySQL(login, db, sql)
    let c = 'ter ++close mysql --login-path="'.a:login.'"'
    if a:db != ''
	let c .= ' '.a:db
    endif
    if a:sql != ''
	let c .= ' -e "'.a:sql.'"'
    endif
    exec c
endfun

if !exists("*UpdateConfig")
    fun UpdateConfig()
	cd ~/system-config
	!git pull
	cd -
	so ~/.vimrc
    endfun
endif

com! -nargs=1 G call CommitAndPush(<args>, 0)
com! Gs !git diff --name-status
com! Gd call DiffMaster()
com! Gx call QuitDiff()
com! Gp !git pull
com! Gr !git reset --hard
com! Gl !git log --oneline

com! P ter python3 %
com! -nargs=+ Px ter python3 <args>
com! Pt ter ++close python3
com! Pl ter pylint %
