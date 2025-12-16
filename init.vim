set expandtab
set clipboard=unnamed

nnoremap <Space> :w<CR>
nnoremap - :Explore<CR>

" exit insert/visual mode with ö
inoremap ö <Esc>
vnoremap ö <Esc>

inoremap <S-Tab> <C-d> " unindent in insert mode

let g:netrw_dirhistmax = 0 " no ~/.vim/netrwhist
