" --- options ---

set nocompatible

syntax on
filetype indent on " detect type, load indenting, but no plugins

set noswapfile viminfo= undofile undodir=/tmp/vim-undo
set laststatus=2 " always show status bar
set statusline=%m%F\ %LL
set showcmd
set wildmenu " TAB menu in ex commands
set incsearch
set scrolloff=3
set nowrap
set backspace=indent,eol,start
set expandtab autoindent
set tabstop=4 shiftwidth=4 " default indents
set complete=. completeopt= " complete from buffer, no popup menu
set colorcolumn=80
set gdefault " match all occurences of pattern
set pastetoggle=<C-Y>

" vim won't create this directory itself, and thus not save undo files
" if the tmp subfolder was deleted (e.g. on restart), we have to re-create it
if !isdirectory(&undodir)
    call mkdir(&undodir)
endif


" --- colors ---

hi Comment ctermfg=darkgrey
hi Constant ctermfg=darkgreen
hi LineNr ctermfg=darkblue
hi ColorColumn ctermbg=darkblue
hi MatchParen cterm=underline ctermbg=NONE


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


" --- commands ---

" load a revision of the current file into scratch buffer
fun! GitRevision(ref)
    let relpath = expand('%:.')
    let linenum = line('.')
    let filetype = &ft
    vnew
    exec 'silent read !git show "' . a:ref . ':./' . relpath . '"'
    exec linenum
    let &ft = filetype
    setl bt=nofile
endfun

" show HEAD version of current file
com! H call GitRevision('HEAD')

" JSON
com! J %!python -m json.tool


" --- mappings ---

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

" quick tab
nmap <Leader>e :tabe 

" set current directory to current file
nmap <Leader>c :lcd %:h<CR>

" error list navigation
nmap <Leader><Leader> :cc<CR>
nmap <Leader>j :cn<CR>
nmap <Leader>k :cp<CR>

" delete folders
nmap <Leader>x :!rm -rf 

" search in files
nmap <Leader>f :vim // *<Left><Left><Left>

" git
nmap <Leader>s :echo system('git status --branch --short')<CR>
nmap <Leader>h :echo system('git rev-parse --short=8 HEAD')<CR>
nmap <Leader>l :echo system('git log -10')<CR>
nmap <Leader>a :echo system('git add --all --verbose')<CR>
nmap <Leader>v :echo system('git pull')<CR>
nmap <Leader>p :echo system('git push')<CR>

" follow links
nmap <Leader>g <C-]>

" config
nmap <Leader>. :tabe ~/.vimrc<CR>
nmap <Leader>- :tabe ~/dotfiles/vimrc<CR>
nmap <Leader># :source %<CR>

" toggle word wrap
nmap <Leader>w :setl wrap!<CR>

