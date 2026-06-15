" --- settings ---

set nocompatible

syntax on
filetype plugin on

set background=dark
set noswapfile
set backspace=indent,eol,start
set laststatus=2
set wildmenu
set scrolloff=5
set shiftwidth=2 softtabstop=-1 expandtab
set autoindent
set pastetoggle=<C-y>
set path=,,

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
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>

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
nmap ö yy:call TermSend(getreg('"'))<CR>
nmap Ö yy:call TermSend(trim(getreg('"'), ' '))<CR>

" --- leader mappings ---

let g:mapleader = ","

" open HOME in new tab
nmap <Leader>t :tabe ~/<CR>

" show unsaved changes
nmap <Leader>z :w !diff % -<CR>

" reload config
nmap <Leader>u :so $DOTDIR/vimrc<CR>

" toggle color column
nmap <Leader>i :let &l:cc=(empty(&l:cc) ? '80' : '')<CR>

" scratch buffer
nmap <Leader>o :split new<CR>:setl bt=nofile bh=wipe<CR>

" quickfix list
nmap <Leader><Leader> :cc<CR>
nmap <Leader>j :cn<CR>
nmap <Leader>k :cp<CR>

" show line numbers
nmap <Leader>n :setl number! relativenumber!<CR>

" git
nnoremap <Leader>w :silent !tig<CR><C-l>
nmap <Leader>e :call GitSigns()<CR>
nmap <Leader>r :echo b:diff[line('.')]<CR>
nmap <Leader>a :echo system("git add --all --verbose")<CR>
nmap <Leader>s :echo system("git status")<CR>
nmap <Leader>d :rightb vert ter git diff HEAD<CR>
nmap <Leader>g :!git pull --ff-only<CR>
nnoremap <Leader>y :silent !tig status<CR><C-l>
nmap <Leader>x :echo system("git commit -a -m ''")<Left><Left><Left>
nmap <Leader>c :echo system("git commit -m ''")<Left><Left><Left>
nmap <Leader>v :!git push<CR>

" --- colors ---

highlight Comment ctermfg=darkgray
highlight LineNr ctermfg=darkgray
highlight TabLineSel ctermfg=cyan
highlight MatchParen cterm=underline ctermbg=NONE

" --- send to term ---

function! TermSend(msg) abort
  let l:bufnums = tabpagebuflist()
  let l:termnums = filter(l:bufnums, 'bufname(v:val)[0] == "!"')
  call term_sendkeys(l:termnums[0], a:msg)
endfunction

" --- dir listing ---

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

function! ListDir(path) abort

  if !isdirectory(a:path)
    call clearmatches()
    return
  endif

  exec 'lcd ' . fnameescape(a:path)
  setl bt=nofile bh=wipe nomod rnu

  let l:parts = [[], [], [], []]

  for l:item in glob('*', 1, 1)
    if isdirectory(l:item)
      call add(l:parts[0], l:item . '/')
    else
      call add(l:parts[1], l:item)
    endif
  endfor

  for l:item in glob('.*', 1, 1)[2:]
    if isdirectory(l:item)
      call add(l:parts[2], l:item . '/')
    else
      call add(l:parts[3], l:item)
    endif
  endfor

  let l:lines = [getcwd(), ""]
  for l:part in l:parts
    call extend(l:lines, l:part)
  endfor
  call setline(1, l:lines)

  call matchaddpos('CursorLineNr', [1])
  match Comment /^\..\+/
  call setpos('.', [0, 3, 1, 0])

  nmap <buffer> <Space> gf
  nmap <buffer> <CR> <Space>
  nmap <buffer> - :e ..<CR>
  nmap <buffer> c :let @p = fnameescape(trim(getline('.'), '/'))<CR>:echo @p<CR>
  nmap <buffer> s c:echo system("stat -c '%A %h %U %G %s %.19y %n' -- " . @p)<CR>
  nmap <buffer> r c:!mv <C-r>p 
  nmap <buffer> d :!mkdir 
  nmap <buffer> D c:!rm -rf <C-r>p
  au ShellCmdPost <buffer> Refresh

endfunction

command! Refresh call ListDir(getcwd())

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

command! -nargs=1 RuffEnv let $RUFF = $HOME . "/miniforge3/envs/<args>/bin/ruff"
command! Format !$RUFF format %

augroup py
  autocmd!
  autocmd FileType python setl makeprg=$RUFF\ check\ --output-format\ concise\ % errorformat=%f:%l:%c:\ %m
augroup END

tmap Ö import pandas as pd<CR>

" --- imports ---

source $DOTDIR/gitsigns.vim

