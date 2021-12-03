" --- options ---

syntax on
filetype on

" UI
set wildmenu nowrap ruler showcmd display=truncate laststatus=2 scrolloff=5

" dark theme
set background=dark

" sane backspacing
set backspace=indent,eol,start

" disable mouse input
set mouse=

" spaces over tabs
set tabstop=4 shiftwidth=4 expandtab

" persistence
set noswapfile viminfo= undofile undodir=~/.vim/undo

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

    " notes syntax
    au BufEnter notes syn match	Label "^#.*"

    " Python autopep8 formatting
    au FileType python setl formatprg=autopep8\ -

augroup END


" --- script execution ---

" run command repeatably
com! -nargs=1 -complete=file R let g:last_cmd = <q-args> | ter <args>

" repeat last command
com! RR call term_start(g:last_cmd, {'curwin': 1})

" run Python script
com! RP R python %

" run Python script and keep REPL open
com! RI R python -i %

" open Python REPL
com! P ter ++close python


" --- git ---

if has('macunix')
    let g:git_env = {'ZDOTDIR': $HOME . '/dotfiles/git-env', 'SHELL_SESSIONS_DISABLE': 1}
    let g:git_cmd = 'zsh'
else
    let g:git_env = {}
    let g:git_cmd = 'bash --rcfile ~/dotfiles/git-env/.bashrc'
endif

" open git shell
com! Git call term_start(g:git_cmd, {'env': g:git_env, 'term_finish': 'close'})

fun! LoadRevision(ref)
    let relpath = expand('%:.')
    let linenum = line('.')
    let filetype = &ft
    vne
    exec 'silent read !git show "' . a:ref . ':./' . relpath . '"'
    exec linenum
    let &ft = filetype
    setl bt=nofile
endfun

" show HEAD version of current file
com! H call LoadRevision('HEAD')


" --- MySQL ---

" set login path and optionally database
com! -nargs=1 D let g:mysql_login = <q-args>

" MySQL interactive session
com! M exec 'ter mysql --login-path=' . g:mysql_login

" print results of an SQL query in a new scratch buffer
fun! Query(query, explicit)
    if !exists('g:mysql_login')
        echo 'no database specified'
        return
    endif

    let $QRY = a:query

    let cmd = 'mysql --login-path=' . g:mysql_login . ' -e "$QRY"'
    if a:explicit
        let cmd .= ' -vv'
    else
        let cmd .= ' | column -t -s $''\t'''
    endif

    new
    setlocal buftype=nofile bufhidden=wipe
    let head = a:query[:60]
    let head = substitute(head, '%', '§', 'g')
    let head = substitute(head, '\n', ' ', 'g')
    let path = split(g:mysql_login, ' ')[0]
    exec 'file ' . path . strftime(' %H:%M:%S ') . head
    exec 'silent 0read !' . cmd
    0
endfun

com! -nargs=1 Q call Query(<q-args>, 0)
com! -nargs=1 QX call Query(<q-args>, 1)

" query shortcuts
com! QD Q SHOW DATABASES
com! QV Q SHOW VARIABLES
com! QG Q SHOW GLOBAL STATUS
com! QP Q SHOW FULL PROCESSLIST

cnoremap QT Q SHOW TABLES
cnoremap QI Q SHOW FULL COLUMNS FROM
cnoremap QA Q SELECT * FROM
cnoremap QC Q SELECT COUNT(*) FROM

" execute the last yanked SQL query
com! QQ call Query(@", 0)
com! QQX call Query(@", 1)


" -- misc --

" open scratch buffer
com! B new | setl bt=nofile

" switch to byte size style (hit CTRL-L to update)
com! BS let g:netrw_sizestyle = 'b'

" reload config
com! O source ~/.vimrc

" update config
com! U exec '!cd "$HOME/dotfiles"; git pull --ff-only' | O


" --- mappings ---

" remap special characters for DE layout
inoremap " '
inoremap ' "
inoremap § |
inoremap `` <
inoremap ´´ >

" map DE umlauts in normal mode
nnoremap ö J
nnoremap ä :Git<CR>
nnoremap ü :sp ~/notes<CR>
nnoremap ß :sp ~/.vimrc<CR>
nnoremap Ö :cc<CR>
nnoremap Ü :cp<CR>
nnoremap Ä :cn<CR>

" fix jumping for DE layout
nnoremap ] <C-]>
nnoremap [ <C-[>

" quick file switching
nnoremap <Tab> <C-^>

" quick shifting
nnoremap H <<
nnoremap L >>
vnoremap H <
vnoremap L >

" quick scrolling
nnoremap K H
vnoremap K H
nnoremap J L
vnoremap J L

" quick save
nnoremap <Space> :w<CR>

" open parent directory
nnoremap _ :E<CR>

" toggle line wrapping
nnoremap <CR> :setl wrap!<CR>

" command mode home
cnoremap <C-A> <Home>

" write as root
cnoremap w!! w !sudo tee > /dev/null %

" move list items
nnoremap <C-F> mxv/.[,)}\]]<CR>d
nnoremap <C-T> v/.[,)}\]]<CR>p`xhp
" test: (ccc, dddddd, aaaaaaa, bbbb)
