set background=dark
set number
set shiftwidth=4
set expandtab
set autoindent
set complete=.,t
set completeopt=
set noswapfile
set nowrap

let g:netrw_banner=0
let g:netrw_list_hide='^\.[^.].*'
highlight link netrwMarkFile Title
nmap <space> <cr>

fun! DiffMaster()
    set diff
    set scrollbind
    bo vert terminal git show master:%
    set diff
    set scrollbind
    sleep
    wincmd h
    diffupdate
endfun

fun! CommitAndPush(message, newbranch)
    !git add -v --all
    exec '!git commit -m "' . a:message . '"'
    if a:newbranch
        !git push -u origin HEAD
    else
        !git push
    endif
endfun

com! -nargs=1 G call CommitAndPush(<args>, 0)
com! Gs !git diff --name-status
com! Gd call DiffMaster()
com! Gx set nodiff | set noscrollbind
com! Gp !git pull
com! Gr !git reset --hard
com! Gl !git log --oneline

com! P bel terminal python3 %
com! Pt bel terminal python3
