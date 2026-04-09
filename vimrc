" --- settings ---

if has('nvim')
  set scrolloff=5
else
  source $VIMRUNTIME/defaults.vim
  set background=dark
  set ttymouse=sgr
  set viminfo=
  set laststatus=2
  set pastetoggle=<C-y>
  set autoindent
endif

set noswapfile
set mouse=a
set tabstop=2 shiftwidth=0 softtabstop=-1 expandtab
set splitbelow splitright
set relativenumber
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
nnoremap <C-u> :source $HOME/dotfiles/vimrc<CR>

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
  nnoremap q :split <Bar> terminal<CR>:let g:termchan = b:terminal_job_id<CR>i
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
  nnoremap q :terminal<CR><C-w>:let g:termbuf = bufnr('$')<CR>
  nnoremap ä :call term_sendkeys(g:termbuf, trim(getline('.')) . "\r")<CR><CR>
  nnoremap ü :call term_sendkeys(g:termbuf, getreg('"') . "\r")<CR>
  nnoremap # :call term_sendkeys(g:termbuf, "\x10\n")<CR>
endif

" jump to tag under cursor
nnoremap gt <C-]>

" toggle word wrap
nnoremap + :setl wrap!<CR>

" format current file
nnoremap <C-f> :call Format()<CR>

" command mode home jump
cnoremap <C-a> <Home>

" --- leader mappings ---

let g:mapleader = ","

" search in files
nmap <Leader>l :vim // *<Left><Left><Left>
nmap <Leader><Leader> :cc<CR>
nmap <Leader>j :cn<CR>
nmap <Leader>k :cp<CR>

" git
nmap <Leader>e :call GitSigns()<CR>
nmap <Leader>r :!git reset HEAD<CR>
nmap <Leader>a :!git add --all --verbose<CR>
nmap <Leader>s :!git status<CR>
nmap <Leader>d :sil !git diff -R HEAD -- % > /tmp/diff<CR>:sil vert diffp /tmp/diff<CR>:setl bh=wipe<CR>
nmap <Leader>f :vert ter git diff HEAD<CR>i
nmap <Leader>g :!git pull<CR>
nmap <Leader>h :!git log -8<CR>
nmap <Leader>y :!git reset --hard
nmap <Leader>x :!git commit -a -m ""<Left>
nmap <Leader>c :!git commit -m ""<Left>
nmap <Leader>v :!git push<CR>

" max columns
nmap <Leader>i :call matchadd('Error', '\%80v.', 100)<CR>
nmap <Leader>o :call clearmatches()<CR>

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
sign define sadd text=| texthl=GitAdd
sign define smod text=| texthl=GitChange

function! GitSigns() abort

  let l:bufnr = bufnr('%')
  exe 'sign unplace * buffer=' . l:bufnr

  let l:diff = systemlist('git diff --unified=0 -- ' . expand('%'))
  if v:shell_error
    echo 'Not a git file.'
    return
  endif

  let l:quick = []

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
      let l:msg = 'added L' . l:new_start . '(+' . l:new_count . ')'
      for l:lnum in range(l:new_start, l:new_start + l:new_count - 1)
        exe 'sign place ' . l:lnum . ' name=sadd line=' . l:lnum . ' buffer=' . l:bufnr
      endfor
    elseif l:new_count == 0
      let l:msg = 'removed L' . l:new_start . '(-' . l:old_count . ')'
      let l:lnum = l:new_start > 0 ? l:new_start : 1
      exe 'sign place ' . l:lnum . ' name=sdel line=' . l:lnum . ' buffer=' . l:bufnr
    else
      let l:msg = 'changed L' . l:new_start
      for l:lnum in range(l:new_start, l:new_start + l:new_count - 1)
        exe 'sign place ' . l:lnum . ' name=smod line=' . l:lnum . ' buffer=' . l:bufnr
      endfor
    endif

    let l:quick += [{'bufnr': l:bufnr, 'lnum': l:new_start, 'text': l:msg}]

  endfor

  call setqflist(l:quick, 'r')

endfunction

" --- formatting ---

function! Format() abort
  let l = getpos('.')
  if &filetype ==# 'python'
    %!autopep8 -
  endif
  call setpos('.', l)
endfunction

" --- file types ---

augroup extft
  autocmd!
  autocmd FileType python compiler pylint
  autocmd FileType dart setlocal makeprg=flutter\ build\ bundle
  autocmd FileType dart setlocal errorformat=%f:%l:%c:\ %m,%+C\ %#%m,%-G%.%#
augroup END

" --- copilot ---

" disable filetypes
let g:copilot_filetypes = { "markdown": v:false }

