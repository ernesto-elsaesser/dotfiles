" --- options ---

set nocompatible

syntax on
filetype indent on " detect type, load indenting, but no plugins

set showcmd
set wildmenu " TAB menu in ex commands
set incsearch
set scrolloff=3
set nowrap
set backspace=indent,eol,start
set expandtab autoindent
set tabstop=4 shiftwidth=4 " default indents
set gdefault " match all occurences of pattern

" --- colors ---

hi MatchParen cterm=underline ctermbg=NONE
hi Comment ctermfg=darkgrey
hi Constant ctermfg=darkgreen

" for set number
hi LineNr ctermfg=darkgrey


" --- variables ---

" do not load $VIMRUNTIME/default.vim
let g:skip_defaults_vim = 1

" fine-tune netrw
let g:netrw_banner = 0 " no banner
let g:netrw_dirhistmax = 0 " no ~/.vim/netrwhist
let g:netrw_maxfilenamelen = 20
let g:netrw_timefmt = "%H:%M:%S %d-%m-%y"
let g:netrw_sizestyle = 'H' " human-readable file sizes
let g:netrw_list_hide = '^\..*'

" --- mappings ---

" quick escape
inoremap jj <Esc>

" backwards tab in insert mode
inoremap <S-Tab> <C-d>

" quick save
nnoremap <Space> :w<Enter>

" open parent folder
nnoremap - :E<CR>

" toggle line numbers
nnoremap ö :set number!<CR>

" toggle word wrap
nnoremap ä :setl wrap!<CR>

