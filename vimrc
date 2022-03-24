" --- options ---

syntax on
filetype on

" UI
set wildmenu incsearch nowrap ruler showcmd
set background=dark mouse= display=truncate laststatus=2 scrolloff=5

" sane backspacing
set backspace=indent,eol,start

" spaces over tabs
set tabstop=4 shiftwidth=4 expandtab

" persistence
set noswapfile viminfo= undofile undodir=~/.vim/undo

if !isdirectory(&undodir)
    call mkdir(&undodir)
endif

" complete only from current buffer, no popup menu
set complete=. completeopt=

" universal error format [FILE:LINE: ERR_MSG]
set errorformat=%A%f:%l:\ %m,%-G%.%#

" quickly turn paste on and off in insert mode
set pastetoggle=<C-Y>

" always match all occurences of a pattern
set gdefault


" --- colors ---

hi Comment ctermfg=darkgrey
hi Constant ctermfg=darkgreen
hi MatchParen cterm=underline ctermbg=NONE
hi netrwMarkFile ctermbg=red


" --- variables ---

" use comma as leader
let mapleader = ','

" fine-tune netrw
let g:netrw_banner = 0
let g:netrw_maxfilenamelen = 20
let g:netrw_timefmt = "%H:%M:%S %d-%m-%y"
let g:netrw_sizestyle = 'H'
let g:netrw_list_hide = '^\..*'

" make MySQL the default SQL dialect
let g:sql_type_default = 'mysql'

" disable stupid SQL <C-C> mapping
let g:omni_sql_no_default_maps = 1


" --- autocmds ---

augroup vimrc
    au!

    " jump to last position
    au BufReadPost * exec "normal! g`\""

    " always auto-indent
    au BufEnter * setl autoindent

augroup END


" --- git ---

" open git shell
let git_env_dir = $HOME . '/dotfiles/git-env'
if has('macunix')
    let zsh_env = {'ZDOTDIR': git_env_dir, 'SHELL_SESSIONS_DISABLE': 1}
    com! Git call term_start('zsh', {'env': zsh_env, 'term_finish': 'close'})
else
    let bash_cmd = 'bash --rcfile ' . git_env_dir . '/.bashrc'
    com! Git call term_start(bash_cmd, {'term_finish': 'close'})
endif

" load file revision into scratch buffer
fun! LoadRevision(ref)
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
com! H call LoadRevision('HEAD')


" -- misc --

" open scratch buffer
com! B new | setl bt=nofile

" switch to byte size style (hit CTRL-L to update)
com! BS let g:netrw_sizestyle = 'b'

" reload config
com! U source ~/.vimrc


" --- mappings ---

" quick save
nnoremap <Space> :w<CR>

" quick file switching
nnoremap <Tab> <C-^>

" toggle line wrapping
nnoremap <CR> :setl wrap!<CR>

" open parent directory
nnoremap - :E<CR>

" command mode home
cnoremap <C-A> <Home>

" leader navigation
nmap <Leader><Leader> :Git<CR>
nmap <Leader>. :sp ~/.vimrc<CR>
nmap <Leader>- :sp ~/<CR>
nmap <Leader>+ :sp ~/dotfiles/vimrc<CR>

" DE mappings
inoremap ö <Esc>
vnoremap ö <Esc>
nnoremap ü :cc<CR>
nnoremap ö :cn<CR>
nnoremap ä :cp<CR>
nnoremap Ö <C-]>
nnoremap Ä <C-[>

" move list items
nnoremap <C-F> mxv/.[,)}\]\n]<CR>d
nnoremap <C-T> v/.[,)}\]\n]<CR>p`xhp
" test: (ccc, dddddd, aaaaaaa, bbbb)

