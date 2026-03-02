if !has('nvim')
  source $VIMRUNTIME/defaults.vim
  syntax on
  set ttymouse=sgr
  set viminfo=
  set laststatus=2
  set hidden
endif

set noswapfile
set mouse=a
set expandtab autoindent shiftwidth=4 tabstop=4 softtabstop=4
set nowrap
set splitbelow splitright
set virtualedit=onemore
set complete=. completeopt=

" --- key mapping ---

" quick quit
nnoremap <C-e> :quit<CR>

" quick save
nnoremap <Space> :w<CR>

" open explorer side bar
nnoremap - :15Lexplore<CR>

" quick terminal
if has('nvim')
  nnoremap q :split <Bar> terminal<CR>i
else
  nnoremap q :terminal<CR>
endif

" exit insert/visual/terminal mode with ö
inoremap ö <Esc>
vnoremap ö <Esc>
tnoremap ö <C-\><C-n>

" paste to terminal
tnoremap ä <C-w>""

" unindent in insert mode
inoremap <S-Tab> <C-d>

" --- netrw ---

" open files in previous window
let g:netrw_browse_split = 4

" split window size
let g:netrw_winsize = 85

" hide banner (toggle with I)
let g:netrw_banner = 0

" configure sorting
let g:netrw_sort_sequence = '\/$,*'

" configure hiding (a)
let g:netrw_list_hide = '^\.[^.]'

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
command! RR source $HOME/.vimrc

