" do not load $VIMRUNTIME/default.vim
let g:skip_defaults_vim = 1

set nocompatible

syntax on
colorscheme desert
filetype indent on " detect type, load indenting, but no plugins

set laststatus=2 " always show status bar
set statusline=%m%f\ %LL\ <%l:%c>%=%{getcwd()}
set showcmd
set wildmenu " TAB menu in ex commands
set incsearch
set scrolloff=3
set nowrap
set backspace=indent,eol,start
set expandtab autoindent
set tabstop=4 shiftwidth=4 " default indents
set gdefault " match all occurences of pattern

inoremap ö <Esc>
vnoremap ö <Esc>
nnoremap <Space> :w<Enter>
nnoremap - :E<CR>

" unindent in insert mode
inoremap <S-Tab> <C-d>

hi MatchParen cterm=underline ctermbg=NONE

let g:netrw_dirhistmax = 0 " no ~/.vim/netrwhist
let g:netrw_maxfilenamelen = 20
let g:netrw_timefmt = "%H:%M:%S %d-%m-%y"
let g:netrw_sizestyle = 'H' " human-readable file sizes
let g:netrw_list_hide = '^\..*'

