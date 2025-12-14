source $VIMRUNTIME/defaults.vim

set expandtab autoindent
set tabstop=4 shiftwidth=4

set laststatus=2 " always show status bar
set statusline=%m%f\ %l:%c%=%L\ lines

nnoremap <Space> :w<Enter> " save with space

" exit insert/visual mode with ö
inoremap ö <Esc>
vnoremap ö <Esc>

inoremap <S-Tab> <C-d> " unindent in insert mode

set gdefault " match all occurences of pattern
