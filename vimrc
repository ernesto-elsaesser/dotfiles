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


" --- commands ---

" load a revision of the current file into scratch buffer
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


" --- mappings ---

" exit edit mode
inoremap <C-K> <Esc>
vnoremap <C-K> <Esc>

" quick save
nnoremap <Space> :w<CR>

" german umlauts for tab switching
nnoremap ö gT
nnoremap ä gt

" free C-V for pasting
nnoremap ü <C-V>

" open parent directory
nnoremap - :E<CR>

" indenting
nnoremap <Tab> >>
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
vnoremap <Tab> >
vnoremap <S-Tab> <

" command mode home key
cnoremap <C-A> <Home>


" --- leader mappings ---

" error list navigation
nmap <Leader>l :cc<CR>
nmap <Leader>j :cn<CR>
nmap <Leader>k :cp<CR>

" search in files
nmap <Leader>f :vim // *<Left><Left><Left>

" follow links
nmap <Leader>g <C-]>

" terminal
nmap <Leader>t :ter ++close<CR>

" config
nmap <Leader>. :tabe ~/.vimrc<CR>
nmap <Leader>- :tabe ~/dotfiles/vimrc<CR>
nmap <Leader># :source %<CR>

" toggle word wrap
nmap <Leader>w :setl wrap!<CR>

" python
nmap <Leader>a :!autopep8 --in-place %:p<CR>
nmap <Leader>m :cex system('mypy %:p')<CR>
nmap <Leader>p :ter ++rows=5 pylint --output-format=parseable -sn %:p<CR>
nmap <Leader>x :cgetb <bar> :q <bar> :cc<CR>
nmap <Leader>r :s/, /,\r\t\t/ <bar> :s/)/,\r\t\t)/<CR>
