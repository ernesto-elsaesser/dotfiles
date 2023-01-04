" --- options ---

" language-dependent syntax highlighting
syntax on
filetype on
set background=dark

" scrolling
set nowrap scrolloff=5

" sane backspacing
set backspace=indent,eol,start

" spaces over tabs
set tabstop=4 shiftwidth=4 expandtab

" footer
set wildmenu ruler showcmd incsearch laststatus=2

" persistence
set noswapfile viminfo= undofile undodir=~/.vim/undo

if !isdirectory(&undodir)
    call mkdir(&undodir)
endif

" width hint
set colorcolumn=80

" complete only from current buffer, no popup menu
set complete=. completeopt=

" universal error format [FILE:LINE: ERR_MSG]
set errorformat=%A%f:%l:\ %m,%-G%.%#

" quickly turn paste on and off in insert mode
set pastetoggle=<C-Y>

" always match all occurences of a pattern
set gdefault


" --- colors ---

hi Comment ctermfg=darkgrey
hi Constant ctermfg=darkgreen
hi ColorColumn ctermbg=darkgrey
hi MatchParen cterm=underline ctermbg=NONE
hi netrwMarkFile ctermbg=red


" --- variables ---

" use comma as leader
let mapleader = ','

" fine-tune netrw
let g:netrw_banner = 0
let g:netrw_maxfilenamelen = 20
let g:netrw_timefmt = "%H:%M:%S %d-%m-%y"
let g:netrw_sizestyle = 'H'
let g:netrw_list_hide = '^\..*'

" make MySQL the default SQL dialect
let g:sql_type_default = 'mysql'


" --- autocmds ---

augroup vimrc
    au!

    " jump to last position
    au BufReadPost * exec "normal! g`\""

    " always auto-indent
    au BufEnter * setl autoindent

augroup END


" -- commands --

" commit
com! -nargs=1 C echo system('git commit -m "<args>"')

" load file revision into scratch buffer
fun! GitRevision(ref)
    let relpath = expand('%:.')
    let linenum = line('.')
    let filetype = &ft
    vnew
    exec 'silent read !git show "' . a:ref . ':./' . relpath . '"'
    exec linenum
    let &ft = filetype
    setl bt=nofile
endfun

" show HEAD version of current file
com! H call GitRevision('HEAD')

fun! GitLog(cnt)
    new
    exec 'silent read !git log --reverse -' . a:cnt
    setl bt=nofile
endfun

" show last 25 commits
com! L call GitLog(25)

" search files
com! -nargs=1 F vim <args> *

" open scratch buffer
com! B new | setl bt=nofile

" --- mappings ---

" exit edit mode
inoremap <C-K> <Esc>
vnoremap <C-K> <Esc>

" quick save
nnoremap <Space> :w<CR>

" quick alt file
nnoremap ö <C-^>

" remap C-V to allow pasting
nnoremap ü <C-V>

" alternative window key
nnoremap ä <C-W>
if v:version < 900
    set termkey=ä
else
    set termwinkey=ä
endif

" open parent directory
nnoremap - :E<CR>

" indenting
nnoremap <Tab> >>
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
vnoremap <Tab> >
vnoremap <S-Tab> <

" quick navigation
nmap <Leader><Leader> :cc<CR>
nmap <Leader>j :cn<CR>
nmap <Leader>k :cp<CR>
nmap <Leader>l <C-]>
nmap <Leader>h <C-[>

" git
nmap <Leader>s :echo system('git status -s')<CR>
nmap <Leader>a :echo system('git add -vA')<CR>
nmap <Leader>x :ter git push<CR>
nmap <Leader>d :ter git pull --ff-only<CR>

" config
nmap <Leader>. :sp ~/.vimrc<CR>
nmap <Leader>- :source ~/.vimrc<CR>
nmap <Leader># :sp ~/dotfiles/vimrc<CR>
nmap <Leader>w :setl wrap!<CR>

" terminal
nmap <Leader>t :ter ++close<CR>

" command mode home
cnoremap <C-A> <Home>

" move list items
nnoremap <C-F> mxv/.[,)}\]\n]<CR>d
nnoremap <C-T> v/.[,)}\]\n]<CR>p`xhp
" test: (ccc, dddddd, aaaaaaa, bbbb)

