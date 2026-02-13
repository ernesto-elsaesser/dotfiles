source $VIMRUNTIME/defaults.vim

" indent with spaces
set expandtab autoindent

" yank to * register aka. primary clipboard
set clipboard=unnamed

" always show status bar
set laststatus=2

" exit with Ctrl+Q
nnoremap <C-q> :q<CR>

" save with space
nnoremap <Space> :w<CR>

" show parent folder with minus
nnoremap - :Explore<CR>

" show explorer side bar with minus
nnoremap _ :Lexplore<CR>

" exit insert/visual/terminal mode with ö
inoremap ö <Esc>
vnoremap ö <Esc>
tnoremap ö <C-\><C-n>

" unindent in insert mode
inoremap <S-Tab> <C-d>

" open files to the right
let g:netrw_browse_split = 4
let g:netrw_preview = 1
let g:netrw_winsize = 80

" no ~/.vim/netrwhist file
let g:netrw_dirhistmax = 0

" configure netrw hiding (a)
let g:netrw_list_hide = '^\..*'

" hide netrw banner
let g:netrw_banner = 0
