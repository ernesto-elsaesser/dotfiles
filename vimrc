" --- options ---

set nocompatible

syntax on
filetype indent on " detect type, load indenting, but no plugins

set noswapfile viminfo= undofile undodir=/tmp/vim-undo
set background=dark
set laststatus=2 " always show status bar
set statusline=%m%F:%l'%c\ (%L\ lines)
set showcmd
set wildmenu " TAB menu in ex commands
set incsearch
set scrolloff=5
set nowrap
set backspace=indent,eol,start
set expandtab autoindent
set tabstop=4 shiftwidth=4 " default indents
set complete=. completeopt= " complete from buffer, no popup menu
set colorcolumn=80
set gdefault " match all occurences of pattern
set errorformat=%A%f:%l:\ %m,%-G%.%# " FILE:LINE: ERR_MSG
set pastetoggle=<C-Y>


" --- colors ---

hi Comment ctermfg=darkgrey
hi Constant ctermfg=darkgreen
hi ColorColumn ctermbg=darkblue
hi MatchParen cterm=underline ctermbg=NONE


" --- variables ---

" do not load $VIMRUNTIME/default.vim
let g:skip_defaults_vim = 1

" use comma as leader
let mapleader = ','

" fine-tune netrw
let g:netrw_banner = 0 " no banner
let g:netrw_keepdir = 0 " moving working dir
let g:netrw_dirhistmax = 0 " no ~/.vim/netrwhist
let g:netrw_maxfilenamelen = 20
let g:netrw_timefmt = "%H:%M:%S %d-%m-%y"
let g:netrw_sizestyle = 'H' " human-readable file sizes
let g:netrw_list_hide = '^\..*'

" make MySQL the default SQL dialect
let g:sql_type_default = 'mysql'


" --- autocmds ---

augroup lastpos
    au!

    " jump to last position
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

augroup END


" --- functions ---

" commit changes
fun! GitCommit(msg, add, push)
    if a:add
        call system('git add -A')
    endif
    echo system('git status -s')
    echo system('git commit -m "' . a:msg . '"')
    if a:push
        echo system('git push')
    endif
endfun

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


" -- commands --

" commit all changes
com! -nargs=1 C call GitCommit(<q-args>, 1, 0)

" commit and push all changes
com! -nargs=1 P call GitCommit(<q-args>, 1, 1)

" show HEAD version of current file
com! H call GitRevision('HEAD')

" search files
com! -nargs=1 F vim <args> *


" --- mappings ---

" exit edit mode
inoremap <C-K> <Esc>
vnoremap <C-K> <Esc>

" quick save
nnoremap <Space> :w<CR>

" tab navigation
nnoremap ö gT
nnoremap ä gt
nmap <Leader><Leader> 1gt
nmap <Leader>1 2gt
nmap <Leader>2 3gt
nmap <Leader>3 4gt
nmap <Leader>4 5gt

" remap C-V to allow pasting
nnoremap ü <C-V>

" open parent directory
nnoremap - :E<CR>

" indenting
nnoremap <Tab> >>
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
vnoremap <Tab> >
vnoremap <S-Tab> <

" error list navigation
nmap <Leader>l :cc<CR>
nmap <Leader>j :cn<CR>
nmap <Leader>k :cp<CR>

" follow links
nmap <Leader>g <C-]>

" terminal
nmap <Leader>t :ter ++close<CR>

" git
nmap <Leader>s :echo system('git status')<CR>
nmap <Leader>d :vert ter git diff<CR>
nmap <Leader>h :ter git log --reverse -10<CR>
nmap <Leader><Up> :ter git push<CR>
nmap <Leader><Down> :ter git pull<CR>

" config
nmap <Leader>. :tabe ~/.vimrc<CR>
nmap <Leader>- :tabe ~/dotfiles/vimrc<CR>
nmap <Leader># :source %<CR>

" toggle word wrap
nmap <Leader>w :setl wrap!<CR>

" command mode home
cnoremap <C-A> <Home>

" move list items
nnoremap <C-F> mxv/.[,)}\]\n]<CR>d
nnoremap <C-T> v/.[,)}\]\n]<CR>p`xhp
" test: (ccc, dddddd, aaaaaaa, bbbb)

