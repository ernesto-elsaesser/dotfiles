" --- settings ---

set nocompatible

syntax on
filetype plugin on

set background=dark
set noswapfile
set laststatus=2
set scrolloff=5
set shiftwidth=2 softtabstop=-1 expandtab
set autoindent
set complete=.
set pastetoggle=<C-y>
set statusline=%f%(\ %m%r%)\ -\ line\ %l\ of\ %L%=%c%V
set listchars=space:·

" --- colors ---

highlight Comment ctermfg=darkgray
highlight MatchParen cterm=underline ctermbg=NONE

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

" browse split
nmap gk :sp .<CR>
nmap gj :bel sp .<CR>
nmap gl :vs .<CR>
nmap gh :bel vs .<CR>

" toggle word wrap
nmap + :setl wrap!<CR>

" jump to keyword under cursor
nmap gk <C-]>

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

" --- extensions ---

let s:script_dir = expand('<sfile>:p:h') . '/vim'
for s:script_file in glob(s:script_dir . '/*.vim', 1, 1)
  execute 'source' s:script_file
endfor
