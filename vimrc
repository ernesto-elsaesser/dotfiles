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
set shiftwidth=2 softtabstop=-1 expandtab
set splitright
set relativenumber
set completeopt=

" --- key mappings ---

" quit
nmap <C-d> :quit<CR>

" scroll
noremap <C-j> <C-d>
noremap <C-k> <C-u>

" reload config
nmap <C-u> :source $HOME/dotfiles/vimrc<CR>

" exit insert/visual mode
inoremap Ö <Esc>
inoremap <C-ö> <Esc>
inoremap öö <Esc>
vnoremap Ö <Esc>

" alternate file
nmap q <C-^>

" save
nmap <Space> :w<CR>

" open parent directory
nmap - :Explore<CR>

" exit terminal mode
tnoremap ö <C-\><C-n>

" terminal interaction
if has('nvim')
  nmap ö :vert split <Bar> terminal<CR>:let g:termchan = b:terminal_job_id<CR>i
  nmap ä :call chansend(g:termchan, "\x10\n")<CR>
  nmap # :call chansend(g:termchan, trim(getline('.')) . "\n")<CR><CR>
  nmap ü :call chansend(g:termchan, getreg('"') . "\n")<CR>
  " directly switch into and out of terminal mode
  tnoremap <C-w> <C-\><C-n><C-w>
else
  nmap ö :vert terminal<CR><C-w>:let g:termbuf = bufnr('$')<CR>
  nmap ä :call term_sendkeys(g:termbuf, "\x10\n")<CR>
  nmap # :call term_sendkeys(g:termbuf, trim(getline('.')) . "\r")<CR><CR>
  nmap ü :call term_sendkeys(g:termbuf, getreg('"') . "\r")<CR>
endif

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
  luafile $HOME/dotfiles/git-diag.lua

  " --- python ---
  lua vim.lsp.config('ty', {cmd = {'ty', 'server'}, filetypes = {'python'}, root_markers = {'pyproject.toml', 'setup.py', '.git'}})
  command Ty lua vim.lsp.enable('ty')

  " --- dart ---
  lua vim.lsp.config('dart', {cmd = {'dart', 'language-server'}, filetypes = {'dart'}, root_markers = {'pubspec.yaml', '.git'}})
  command Dart lua vim.lsp.enable('dart')

  " --- copilot ---
  let g:copilot_filetypes = { "markdown": v:false }

endif

