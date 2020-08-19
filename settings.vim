set background=dark
syntax on
set number
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set complete=.,t
set completeopt=
set noswapfile
set nowrap

let g:netrw_banner = 0
let g:netrw_keepdir = 0
let g:netrw_list_hide = '^\.[^.].*'
highlight link netrwMarkFile Title
nmap <space> <cr>

fun! Diff()
  set diff
  set scrollbind
  bo vert terminal git show master:%
  set diff
  set scrollbind
  sleep
  wincmd h
  diffupdate
endfun

fun! Test(message)
  let cmd="terminal echo " . a:message
  exec cmd
endfun

fun! Commit(message)
  !git add --all
  let commit_cmd='!git commit -m "' . a:message . '"'
  exec commit_cmd
endfun
