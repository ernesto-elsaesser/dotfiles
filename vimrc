" --- settings ---

set nocompatible

syntax on
filetype plugin on

set background=dark
set noswapfile
set backspace=indent,eol,start
set laststatus=2
set scrolloff=5
set shiftwidth=2 softtabstop=-1 expandtab
set autoindent
set complete=.,w
set pastetoggle=<C-y>

set statusline=%f%(\ %m%r%)\ \ %l:%c\ \ %LL%=%{getcwd()}\ 

" --- key mappings ---

" quick save
nmap <Space> :w<CR>

" quick quit
nmap qq :q<CR>

" quick tab switch
nmap <Tab> gt
nmap <S-Tab> gT

" exit insert/visual mode
inoremap ö <Esc>
inoremap § ö
vnoremap ö <Esc>

" alternate file
nmap # <C-^>

" open parent directory
nmap - :e .<CR>

" toggle word wrap
nmap + :setl wrap!<CR>

" jump to keyword under cursor
nmap gk <C-]>

" open terminal
nmap ü :rightb vert ter<CR>
nmap Ü :bel ter<CR>

" send to terminal
nmap ä :call TermSend("\x10\r")<CR>
nmap Ä :call TermSend(getreg('"'))<CR>
nmap ö yy:call TermSend(getreg('"'))<CR><CR>
nmap Ö yy:call TermSend(trim(getreg('"'), ' '))<CR><CR>

" --- leader mappings ---

let g:mapleader = ","

" open HOME in new tab
nmap <Leader>t :tabe ~/<CR>

" reload config
nmap <Leader>u :so $DOTDIR/vimrc<CR>

" toggle color column
nmap <Leader>i :let &l:cc=(empty(&l:cc) ? '80' : '')<CR>

" scratch buffer
nmap <Leader>z :split new<CR>:setl bt=nofile bh=wipe<CR>

" search in files
nmap <Leader>f :vim // *<Left><Left><Left>

" quickfix list
nmap <Leader><Leader> :cc<CR>
nmap <Leader>j :cn<CR>
nmap <Leader>k :cp<CR>

" git
nnoremap <Leader>w :silent !tig<CR><C-l>
nmap <Leader>a :!git add --all --verbose<CR>
nmap <Leader>s :!git add %<CR>
nmap <Leader>d :!git rm --cached %<CR>
nmap <Leader>p :!git pull --ff-only<CR>
nnoremap <Leader>y :silent !tig status<CR><C-l>
nmap <Leader>x :echo system("git commit -a -m ''")<Left><Left><Left>
nmap <Leader>c :echo system("git commit -m ''")<Left><Left><Left>
nmap <Leader>v :echo system("git push")<CR>

" --- colors ---

highlight Comment ctermfg=darkgray
highlight LineNr ctermfg=darkgray
highlight TabLineSel ctermfg=cyan
highlight MatchParen cterm=underline ctermbg=NONE

" --- send to term ---

function! TermSend(msg) abort
  let l:bufnums = tabpagebuflist()
  let l:termnums = filter(l:bufnums, 'bufname(v:val)[0] == "!"')
  if len(l:termnums) > 0
    call term_sendkeys(l:termnums[0], a:msg)
  else
    echo 'no terminal'
  endif
endfunction

" --- dir listing ---

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

function! ListDir(path) abort

  call clearmatches()

  if !isdirectory(a:path)
    return
  endif

  exec 'lcd ' . fnameescape(a:path)
  setl bt=nofile nomod

  let l:ls = systemlist('ls -AF --group-directories-first')
  let l:lines = [getcwd(), ""] + l:ls

  let l:lnum = max([line("'\""), 3])
  1,$delete _
  call setline(1, l:lines)
  call setpos('.', [0, l:lnum, 1, 0])

  call matchaddpos('Underlined', [1])
  call matchadd('Comment', '^\..\+')  " hidden
  call matchadd('Identifier', '.\+@$')  " symlinks
  call matchadd('Statement', '.\+\.\(sh\|py\)\*\=$', 9)  " scripts

  nmap <buffer> - :e ..<CR>
  nmap <buffer> i :let @p = fnameescape(trim(getline('.'), '/*@'))<CR>
  nmap <buffer> <Space> i:dr <C-r>p<CR>
  nmap <buffer> s i:echo trim(system('ls -lh ' . @p))<CR>
  nmap <buffer> r i:!mv <C-r>p <C-r>p
  nmap <buffer> m i:!mv <C-r>p 
  nmap <buffer> c i:!cp <C-r>p 
  nmap <buffer> d :!mkdir 
  nmap <buffer> D i:!rm -rf <C-r>p
  au! ShellCmdPost <buffer> call ListDir(getcwd())

endfunction

augroup mynetrw
    autocmd!
    autocmd BufEnter * call ListDir(expand('%'))
augroup END

" --- formatting ---

augroup noro
  autocmd!
  autocmd FileType * setlocal formatoptions-=ro
augroup END

" --- tabline ---

function! Tabline()
  let line = ''
  for i in range(tabpagenr('$'))
    let n = i + 1
    let hl = n == tabpagenr() ? 'TabLineSel' : 'TabLine'
    let cwd = fnamemodify(getcwd(1, n), ':~')
    let line .= '%#' . hl . '#%' . n . 'T ' . n . ':' . cwd . ' |'
  endfor
  let line .= '%#TabLineFill#'
  return line
endfunction

set tabline=%!Tabline()

" --- python ---

command! Format !uv run ruff format %

augroup py
  autocmd!
  autocmd FileType python setl makeprg=uv\ run\ ruff\ check\ --output-format\ concise\ % errorformat=%f:%l:%c:\ %m
augroup END

tmap Ö import pandas as pd<CR>

" --- dart ---

augroup dart
  autocmd!
  autocmd FileType dart setl makeprg=flutter\ build\ bundle
  autocmd FileType dart setl errorformat=lib/%f:%l:%c:\ Error:\ %m,%f:%l:%c:\ Warning:\ %m,%f:%l:%c:\ %m,%-G%.%#
augroup END

