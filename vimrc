" --- options ---

set nocompatible

syntax on
filetype indent on " detect type, load indenting, but no plugins

set laststatus=2 " always show status bar
set statusline=%m%f\ %LL\ <%l:%c>%=%{getcwd()}\ 
set showcmd
set wildmenu " TAB menu in ex commands
set incsearch
set scrolloff=3
set nowrap
set backspace=indent,eol,start
set expandtab autoindent
set tabstop=4 shiftwidth=4 " default indents
set complete=. completeopt= " complete from buffer, no popup menu
set gdefault " match all occurences of pattern
set pastetoggle=<C-Y>
set noswapfile viminfo= undofile undodir=/tmp/vim-undo

" vim won't create this directory itself, and thus not save undo files
" if the tmp subfolder was deleted (e.g. on restart), we have to re-create it
if !isdirectory(&undodir)
    call mkdir(&undodir)
endif


" --- colors ---

hi MatchParen cterm=underline ctermbg=NONE
hi Comment ctermfg=darkgrey
hi Constant ctermfg=darkgreen

"for set number
hi LineNr ctermfg=darkgrey

"for set colorcolumn=80
hi ColorColumn ctermbg=darkgrey


" --- variables ---

" do not load $VIMRUNTIME/default.vim
let g:skip_defaults_vim = 1

" use comma as leader
let mapleader = ','

" fine-tune netrw
let g:netrw_banner = 0 " no banner
let g:netrw_dirhistmax = 0 " no ~/.vim/netrwhist
let g:netrw_maxfilenamelen = 20
let g:netrw_timefmt = "%H:%M:%S %d-%m-%y"
let g:netrw_sizestyle = 'H' " human-readable file sizes
let g:netrw_list_hide = '^\..*'

" make MySQL the default SQL dialect
let g:sql_type_default = 'mysql'


" --- mappings ---

nnoremap <Space> :w<Enter>

" german umlauts to switch tabs
nnoremap ö gT
nnoremap ä gt

" open parent folder
nnoremap - :E<CR>

" backwards tab in insert mode
inoremap <S-Tab> <C-d>

" command mode home key
cnoremap <C-A> <Home>


" --- leader mappings ---

" quick tab open
nmap <Leader>e :tabe 

" set current directory to current file
nmap <Leader>c :lcd %:h<CR>

" delete folder
nmap <Leader>x :!rm -rf 

" search in files
nmap <Leader>f :vim // *<Left><Left><Left>

" follow links
nmap <Leader>g <C-]>

" toggle line numbers
nmap <Leader>n :set number!<CR>

" toggle column
nmap <Leader>l :setl colorcolumn=80<CR>

" toggle word wrap
nmap <Leader>w :setl wrap!<CR>

" open terminal
nmap <Leader>t :bel term<CR>

