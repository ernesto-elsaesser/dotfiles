set background=dark
set number
set textwidth=80
set shiftwidth=4
set autoindent
set complete=.,t
set completeopt=
set noswapfile
set nowrap

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
    bel vert ter git show master:%
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
    let c = 'bel ter ++close mysql --login-path="'.a:login.'"'
    if a:db != ''
	let c .= ' '.a:db
    endif
    if a:sql != ''
	let c .= ' -e "'.a:sql.'"'
    endif
    exec c
endfun

com! -nargs=1 G call CommitAndPush(<args>, 0)
com! Gs !git diff --name-status
com! Gd call DiffMaster()
com! Gx call QuitDiff()
com! Gp !git pull
com! Gr !git reset --hard
com! Gl !git log --oneline

com! P bel ter python3 %
com! -nargs=+ Px bel ter python3 <args>
com! Pt bel ter ++close python3
