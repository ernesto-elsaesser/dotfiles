" --- settings ---

if !has('nvim')
  source $VIMRUNTIME/defaults.vim
  syntax on
  set background=dark
  set ttymouse=sgr
  set viminfo=
  set laststatus=2
  set pastetoggle=<C-t>
  set autoindent
endif

set noswapfile
set mouse=a
set tabstop=2 shiftwidth=0 softtabstop=-1 expandtab
set relativenumber
set scrolloff=3
set completeopt=

" --- key mappings ---

" quit
nnoremap <C-d> :quit<CR>

" scroll
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
vnoremap <C-j> <C-d>
vnoremap <C-k> <C-u>

" reload config
nnoremap <C-u> :source $HOME/.vimrc<CR>

" return to normal mode
inoremap ö <Esc>
vnoremap ö <Esc>
tnoremap ö <C-\><C-n>

" save
nnoremap <Space> :w<CR>

" open parent directory
nnoremap - :Explore<CR>

" terminal interaction
if has('nvim')
  nnoremap q :below split <Bar> terminal<CR>:let g:termchan = b:terminal_job_id<CR>i
  nnoremap ä :call chansend(g:termchan, trim(getline('.')) . "\n")<CR><CR>
  nnoremap ü :call chansend(g:termchan, getreg('"') . "\n")<CR>
  nnoremap # :call chansend(g:termchan, "\x10\n")<CR>
  " directly switch into and out of terminal mode
  tnoremap <C-w> <C-\><C-n><C-w>
  augroup TermAutoInsert
    autocmd!
    autocmd WinEnter term://* startinsert
  augroup END
else
  nnoremap q :below terminal<CR><C-w>:let g:termbuf = bufnr('$')<CR>
  nnoremap ä :call term_sendkeys(g:termbuf, trim(getline('.')) . "\r")<CR><CR>
  nnoremap ü :call term_sendkeys(g:termbuf, getreg('"') . "\r")<CR>
  nnoremap # :call term_sendkeys(g:termbuf, "\x10\n")<CR>
endif

" jump to tag under cursor
nnoremap gt <C-]>

" toggle word wrap
nnoremap + :setl wrap!<CR>

" command mode home key
cnoremap <C-A> <Home>

" --- leader mappings ---

let g:mapleader = ","

" search in files
nmap <Leader>f :vim // *<Left><Left><Left>
nmap <Leader><Leader> :cc<CR>
nmap <Leader>j :cn<CR>
nmap <Leader>k :cp<CR>

" git
nmap <Leader>s :!git status<CR>
nmap <Leader>m :!git status --short<CR>
nmap <Leader>d :vert rightb ter git diff<CR>
nmap <Leader>i :vert rightb ter git diff --staged<CR>
nmap <Leader>a :!git add --all --verbose<CR>
nmap <Leader>r :!git reset HEAD<CR>
nmap <Leader>e :!git reset HEAD^<CR>
nmap <Leader>c :!git commit -m ""<Left>
nmap <Leader>t :!git commit -a -m ""<Left>
nmap <Leader>p :!git push<CR>
nmap <Leader>q :!git fetch --all<CR>
nmap <Leader>g :!git pull<CR>
nmap <Leader>l :!git log -8<CR>
nmap <Leader>h :!git reset --hard HEAD<CR>
nmap <Leader>b :!git reset --hard HEAD^<CR>
nmap <Leader>y :call GitSigns()<CR>
nmap <Leader>x :sign unplace *<CR>

" --- netrw ---

" hide banner (toggle with I)
let g:netrw_banner = 0

" configure sorting
let g:netrw_sort_sequence = '\/$,*'

" configure hiding (a)
let g:netrw_list_hide = '^\.[^.]'

" set current directory to browsing directory
let g:netrw_keepdir = 0

" no ~/.vim/netrwhist file
let g:netrw_dirhistmax = 0

" human-readable file sizes
let g:netrw_sizestyle = 'H'

" --- git signs ---

highlight GitDelete guifg=#990000 ctermfg=1
highlight GitAdd guifg=#009900 ctermfg=2
highlight GitChange guifg=#bbbb00 ctermfg=3

sign define sdel text=_ texthl=GitDelete
sign define sadd text=+ texthl=GitAdd
sign define smod text=~ texthl=GitChange

function! GitSigns() abort

  let l:bufnr = bufnr('%')
  exe 'sign unplace * buffer=' . l:bufnr

  let l:diff = systemlist('git diff --unified=0 -- ' . expand('%'))
  for l:line in l:diff
    " Hunk header: @@ -old_start[,old_count] +new_start[,new_count] @@
    let l:m = matchlist(l:line, '^@@ -\(\d\+\),\?\(\d*\) +\(\d\+\),\?\(\d*\) @@')
    if empty(l:m)
      continue
    endif

    let l:old_count = l:m[2] ==# '' ? 1 : str2nr(l:m[2])
    let l:new_start = str2nr(l:m[3])
    let l:new_count = l:m[4] ==# '' ? 1 : str2nr(l:m[4])

    if l:old_count == 0
      for l:lnum in range(l:new_start, l:new_start + l:new_count - 1)
        exe 'sign place ' . l:lnum . ' name=sadd line=' . l:lnum . ' buffer=' . l:bufnr
      endfor
    elseif l:new_count == 0
      let l:lnum = l:new_start > 0 ? l:new_start : 1
      exe 'sign place ' . l:lnum . ' name=sdel line=' . l:lnum . ' buffer=' . l:bufnr
    else
      for l:lnum in range(l:new_start, l:new_start + l:new_count - 1)
        exe 'sign place ' . l:lnum . ' name=smod line=' . l:lnum . ' buffer=' . l:bufnr
      endfor
    endif
  endfor

endfunction

" --- copilot ---

" disable filetypes
let g:copilot_filetypes = { "markdown": v:false }

