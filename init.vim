source $VIMRUNTIME/defaults.vim

" indent with spaces
set expandtab autoindent

" yank to * register aka. primary clipboard
set clipboard=unnamed

" always show status bar
set laststatus=2

" exit with double escape
nnoremap <Esc><Esc> :q<CR>

" save with space
nnoremap <Space> :w<CR>

" show parent folder with minus
nnoremap - :Explore<CR>

" exit insert/visual/terminal mode with ö
inoremap ö <Esc>
vnoremap ö <Esc>
tnoremap ö <C-\><C-n>

" unindent in insert mode
inoremap <S-Tab> <C-d>

" no ~/.vim/netrwhist file
let g:netrw_dirhistmax = 0

" configure netrw hiding (a)
let g:netrw_list_hide = '^\..*'
