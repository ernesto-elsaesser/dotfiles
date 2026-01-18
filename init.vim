" indent with spaces
set expandtab autoindent

" yank to * register aka. primary clipboard
set clipboard=unnamed

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
