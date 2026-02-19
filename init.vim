source $VIMRUNTIME/defaults.vim

syntax on

set noswapfile viminfo=
set mouse=a
set expandtab autoindent shiftwidth=4
set laststatus=2
set hidden
set nowrap
set splitbelow
set virtualedit=onemore
set ttymouse=sgr

" --- key mapping ---

" quick quit
nnoremap q :quit<CR>

" quick save
nnoremap <Space> :w<CR>

" quick back
nnoremap <Backspace> <C-o>

" open explorer side bar
nnoremap - :15Lexplore<CR>

" exit insert/visual/terminal mode with ö
inoremap ö <Esc>
vnoremap ö <Esc>
tnoremap ö <C-\><C-n>

" unindent in insert mode
inoremap <S-Tab> <C-d>

" --- netrw ---

" open files in previous window or split right
let g:netrw_browse_split = 4
let g:netrw_preview = 1

" tree listing (toggle with i)
let g:netrw_liststyle = 3

" hide banner
let g:netrw_banner = 0

" configure hiding (a)
let g:netrw_list_hide = '^\..*'

" no ~/.vim/netrwhist file
let g:netrw_dirhistmax = 0

" --- misc ---

" yank to X11 clipboard
augroup Clipboard
  autocmd!
  if executable('xclip')
    autocmd TextYankPost * call system('xclip -i -selection clipboard', getreg(v:event.regname))
  endif
augroup END

" reload config
command Reload source $HOME/.vimrc

