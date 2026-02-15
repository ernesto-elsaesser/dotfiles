source $VIMRUNTIME/defaults.vim

" enable mouse
set mouse=a

" indent with spaces
set expandtab autoindent

" yank to * register aka. primary clipboard
set clipboard=unnamed

" always show status bar
set laststatus=2

" quick quit
nnoremap q :quit<CR>

" quick save
nnoremap <Space> :w<CR>

" open explorer side bar
nnoremap - :Lexplore<CR>

" open terminal
nnoremap ö :below terminal ++rows=10<CR>

" exit insert/visual/terminal mode with ö
inoremap ö <Esc>
vnoremap ö <Esc>
tnoremap ö <C-\><C-n>

" unindent in insert mode
inoremap <S-Tab> <C-d>

" reload config
command Reload source $HOME/.vimrc

" --- netrw ---

" open files to the right
let g:netrw_browse_split = 4
let g:netrw_preview = 1
let g:netrw_winsize = 80

" tree listing (toggle with i, lines below stabilize root)
let g:netrw_liststyle = 3
let g:netrw_fastbrowse = 0

" hide banner
let g:netrw_banner = 0

" configure hiding (a)
let g:netrw_list_hide = '^\..*'

" no ~/.vim/netrwhist file
let g:netrw_dirhistmax = 0
