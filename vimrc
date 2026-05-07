" --- settings ---

if has('nvim')
  set scrolloff=5
else
  source $VIMRUNTIME/defaults.vim
  colorscheme pablo
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

" --- neovim lua ---

if has('nvim')
  luafile $DOTDIR/nvim/term.lua
  luafile $DOTDIR/nvim/git.lua
  luafile $DOTDIR/nvim/lsp.lua
  luafile $DOTDIR/nvim/ollama.lua
endif

" --- key mappings ---

" alternate file
nmap q <C-^>

" quick save
nmap <Space> :w<CR>

" quick quit
nmap <C-s> :q<CR>

" quick tab switch
nmap <Tab> gt
nmap <S-Tab> gT

" exit insert/visual mode
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>

" scrolling
nmap <C-j> <C-d>
nmap <C-k> <C-u>

" open parent directory
nmap - :Ex<CR>

" toggle word wrap
nmap + :setl wrap!<CR>

" jump to keyword under cursor
nmap gk <C-]>

" exit terminal mode
tnoremap ö <C-\><C-n>

" switch windows out of neovim terminal mode
tnoremap <C-w> <C-\><C-n><C-w>

" split linked terminal
nmap ü :TermSplit right<CR>
nmap Ü :TermSplit below<CR>

" paste to linked terminal
nmap ö yy:TermPaste<CR><CR>
nmap Ö :TermPaste<CR>

" repeat previous command in linked terminal
nmap ä :call chansend(b:tjid, "\x10\r")<CR>

" flutter hot reload / restart
nmap gr :call chansend(b:tjid, "r")<CR>
nmap gR :call chansend(b:tjid, "R")<CR>

" --- leader mappings ---

let g:mapleader = ","

" scratch buffer
nmap <Leader>t :split new<CR>:setl bt=nofile bh=wipe<CR>

" show unsaved changes
nmap <Leader>z :w !diff % -<CR>

" reload config
nmap <Leader>u :so $DOTDIR/vimrc<CR>

" toggle color column
nmap <Leader>i :let &l:cc=(empty(&l:cc) ? '80' : '')<CR>

" naviagte diagnostics
nmap <Leader><Leader> <C-w>d
nmap <Leader>j ]d
nmap <Leader>k [d

" LLM completion
nmap <Leader>h :Complete<CR>

" search in files
nmap <Leader>b :vim // *<Left><Left><Left>
nmap <Leader>n :cn<CR>
nmap <Leader>m :cp<CR>
nmap <Leader>. :cc<CR>

" git
nmap <Leader>q :vert ter git show HEAD~:./%<Left><Left><Left><Left>
nmap <Leader>w :!git log -10 --format=reference<CR>
nmap <Leader>e :GitDiag<CR>
nmap <Leader>r :!git reset HEAD<CR>
nmap <Leader>a :!git add --all --verbose<CR>
nmap <Leader>s :!git status<CR>
nmap <Leader>d :vert ter git diff HEAD<CR>i
nmap <Leader>f :!git add %<CR>
nmap <Leader>g :!git pull --ff-only<CR>
nmap <Leader>y :!git reset --hard
nmap <Leader>x :!git commit -a -m ""<Left>
nmap <Leader>c :!git commit -m ""<Left>
nmap <Leader>v :!git push<CR>

" --- netrw ---

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

command! AP %!autopep8 -

augroup noro
  autocmd!
  autocmd FileType * setlocal formatoptions-=ro
augroup END

" --- tabline ---

hi TabLineSel ctermfg=yellow

function! Tabline()
  let line = ''
  for i in range(tabpagenr('$'))
    let n = i + 1
    let hl = n == tabpagenr() ? 'TabLineSel' : 'TabLine'
    let cwd = fnamemodify(getcwd(1, n), ':~')
    let line ..= '%#' .. hl .. '#%' .. n .. 'T ' .. n .. ':' .. cwd .. ' '
  endfor
  let line ..= '%#TabLineFill#'
  return line
endfunction

set tabline=%!Tabline()

