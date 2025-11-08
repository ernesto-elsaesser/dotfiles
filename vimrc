" do not load $VIMRUNTIME/default.vim
let g:skip_defaults_vim = 1

set nocompatible

syntax on
filetype indent on " detect type, load indenting, but no plugins

set laststatus=2 " always show status bar
set statusline=%m%f\ %LL\ <%l:%c>%=%{getcwd()}
set showcmd
set scrolloff=3
set nowrap
set backspace=indent,eol,start
set expandtab autoindent
set tabstop=4 shiftwidth=4 " default indents
set gdefault " match all occurences of pattern

inoremap ö <Esc>
vnoremap ö <Esc>
nnoremap <Space> :w<Enter>

" unindent in insert mode
inoremap <S-Tab> <C-d>

hi MatchParen cterm=underline ctermbg=NONE

