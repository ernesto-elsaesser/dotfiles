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
  nnoremap q :vert split <Bar> terminal<CR>:let g:termchan = b:terminal_job_id<CR>i
  nnoremap ä :call chansend(g:termchan, trim(getline('.')) . "\n")<CR><CR>
  nnoremap ü :call chansend(g:termchan, getreg('"') . "\n")<CR>
  nnoremap # :call chansend(g:termchan, "\x10\n")<CR>
  " directly switch into and out of terminal mode
  tnoremap <C-w> <C-\><C-n><C-w>
else
  nnoremap q :vert terminal<CR><C-w>:let g:termbuf = bufnr('$')<CR>
  nnoremap ä :call term_sendkeys(g:termbuf, trim(getline('.')) . "\r")<CR><CR>
  nnoremap ü :call term_sendkeys(g:termbuf, getreg('"') . "\r")<CR>
  nnoremap # :call term_sendkeys(g:termbuf, "\x10\n")<CR>
endif

" jump to keyword under cursor
nnoremap gk <C-]>

" alternate file
nnoremap # <C-^>

" toggle word wrap
nnoremap + :setl wrap!<CR>

" format current file
nnoremap <C-f> :call Format()<CR>

" command mode home jump
cnoremap <C-a> <Home>

" --- leader mappings ---

let g:mapleader = ","

" naviagte diagnostics
nmap <Leader><Leader> [D
nmap <Leader>u [D
nmap <Leader>j ]d
nmap <Leader>k [d

" search in files
nmap <Leader>m :vim // *<Left><Left><Left>
nmap <Leader>n :cn<CR>
nmap <Leader>b :cp<CR>


" git
nmap <Leader>w :!git add %<CR>
nmap <Leader>e :GitSigns<CR>
nmap <Leader>r :!git reset HEAD<CR>
nmap <Leader>a :!git add --all --verbose<CR>
nmap <Leader>s :!git status<CR>
nmap <Leader>d :sil !git diff -R HEAD -- % > /tmp/diff<CR>:sil vert diffp /tmp/diff<CR>:setl noma bh=wipe<CR>
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

if has('nvim')
  luafile $HOME/dotfiles/git-diag.lua
endif

" --- formatting ---

function! Format() abort
  let l = getpos('.')
  if &filetype ==# 'python'
    %!autopep8 -
  endif
  call setpos('.', l)
endfunction

" --- python ---

if has('nvim')
  lua vim.lsp.config('ty', {cmd = {'ty', 'server'}, filetypes = {'python'}, root_markers = {'pyproject.toml', 'setup.py', '.git'}})
  lua vim.lsp.enable('ty')
endif

" --- dart ---

augroup dart
  autocmd!
  autocmd FileType dart setlocal makeprg=flutter\ build\ bundle
  autocmd FileType dart setlocal errorformat=%f:%l:%c:\ %m,%+C\ %#%m,%-G%.%#
augroup END

" --- copilot ---

" disable filetypes
let g:copilot_filetypes = { "markdown": v:false }

