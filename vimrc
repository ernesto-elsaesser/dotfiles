" --- options ---

" language-aware syntax highlighting
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
set wildmenu showcmd incsearch laststatus=2
set statusline=%m%F:%l.%c\ (%L\ lines)

" change working dir to current file
set autochdir

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
hi ColorColumn ctermbg=darkblue
hi MatchParen cterm=underline ctermbg=NONE


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
nmap <Leader>- :source ~/.vimrc<CR>
nmap <Leader># :tabe ~/dotfiles/vimrc<CR>

" toggle word wrap
nmap <Leader>w :setl wrap!<CR>

" command mode home
cnoremap <C-A> <Home>

" move list items
nnoremap <C-F> mxv/.[,)}\]\n]<CR>d
nnoremap <C-T> v/.[,)}\]\n]<CR>p`xhp
" test: (ccc, dddddd, aaaaaaa, bbbb)

