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

set mouse=a
set noswapfile
set splitright

setg shiftwidth=2 softtabstop=-1 expandtab
setg number relativenumber

" --- key mappings ---

" quit
nmap <C-d> :q<CR>

" scroll
noremap <C-j> <C-d>
noremap <C-k> <C-u>

" exit insert/visual mode
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>

" reload config
nmap <C-u> :so $DOTDIR/vimrc<CR>

" alternate file
nmap q <C-^>

" save
nmap <Space> :w<CR>

" open parent directory
nmap - :Ex<CR>

" cycle tabs
nmap <Tab> gt

" exit terminal mode
tnoremap ö <C-\><C-n>

" send to terminal (# = open, ö = line, ä = repeat, ü = yanked)
if has('nvim')
  nmap # :vert split <Bar> terminal<CR>:let g:termchan = b:terminal_job_id<CR>i
  " directly switch windows out of terminal mode
  tnoremap <C-w> <C-\><C-n><C-w>
  function! Send(cmd) abort
    call chansend(g:termchan, a:cmd . "\n")
  endfunction
else
  nmap # :vert terminal<CR><C-w>:let g:termbuf = bufnr('$')<CR>
  function! Send(cmd) abort
    call term_sendkeys(g:termbuf, a:cmd . "\n")
  endfunction
endif
nmap ö :call Send(trim(getline('.')))<CR><CR>
" ctrl + p
nmap ä :call Send("\x10")<CR>
nmap ü :call Send(getreg('"'))<CR>

" jump to keyword under cursor
nmap gk <C-]>

" toggle word wrap
nmap + :setl wrap!<CR>

" format current file
nmap <C-f> :call Format()<CR>

" --- leader mappings ---

let g:mapleader = ","

" naviagte diagnostics
nmap <Leader><Leader> <C-w>d
nmap <Leader>j ]d
nmap <Leader>k [d

" clear search highlight
nmap <Leader>h :nohl<CR>

" search in files
nmap <Leader>b :vim // *<Left><Left><Left>
nmap <Leader>n :cn<CR>
nmap <Leader>m :cp<CR>

" git
nmap <Leader>q :vert ter git show HEAD~:./%<Left><Left><Left><Left>
nmap <Leader>w :!git log -10<CR>
nmap <Leader>e :GitDiag<CR>
nmap <Leader>r :!git reset HEAD<CR>
nmap <Leader>a :!git add --all --verbose<CR>
nmap <Leader>s :!git status<CR>
nmap <Leader>d :vert ter git diff HEAD<CR>i
nmap <Leader>f :!git add %<CR>
nmap <Leader>g :!git pull<CR>
nmap <Leader>y :!git reset --hard
nmap <Leader>x :!git commit -a -m ""<Left>
nmap <Leader>c :!git commit -m ""<Left>
nmap <Leader>v :!git push<CR>

" scratch buffer
nmap <Leader>t :split new<CR>:setl bt=nofile bh=wipe<CR>

" show unsaved changes
nmap <Leader>u :w !diff % -<CR>

" max columns
nmap <Leader>i :call matchadd('Error', '\%80v.', 100)<CR>

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

" --- formatting ---

function! Format() abort
  let l = getpos('.')
  if &filetype ==# 'python'
    %!autopep8 -
  endif
  call setpos('.', l)
endfunction

" --- neovim specific ---

if has('nvim')

  " --- git signs ---
  luafile $DOTDIR/git-diag.lua

  " --- python ---
  lua vim.lsp.config('ty', {cmd = {'ty', 'server'}, filetypes = {'python'}, root_markers = {'pyproject.toml', 'setup.py', '.git'}})
  command Ty lua vim.lsp.enable('ty')

  " --- dart ---
  lua vim.lsp.config('dart', {cmd = {'dart', 'language-server'}, filetypes = {'dart'}, root_markers = {'pubspec.yaml', '.git'}})
  command Dart lua vim.lsp.enable('dart')
  command Rel call Send("r")
  command Res call Send("R")

  " --- copilot ---
  let g:copilot_filetypes = { "markdown": v:false }

endif

