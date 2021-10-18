unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" --- options ---

" spaces over tabs
set tabstop=4 shiftwidth=4 expandtab

" disable unwanted features
set mouse= nowrap noswapfile viminfo=

" always show status line
set laststatus=2

" persist undo history
set undofile undodir=~/.vim/undo

" complete only from current buffer, no popup menu
set complete=. completeopt=

" universal error format [FILE:LINE: ERR_MSG]
set errorformat=%A%f:%l:\ %m,%-G%.%#

" quickly turn paste on and off in insert mode
set pastetoggle=<C-Y>

" always match all occurences of a pattern
set gdefault


" --- syntax ---

hi Comment ctermfg=darkgrey
hi Constant ctermfg=darkgreen
hi MatchParen cterm=underline ctermbg=NONE
hi netrwMarkFile ctermbg=red


" --- variables ---

" fine-tune netrw
let g:netrw_banner = 0
let g:netrw_maxfilenamelen = 20
let g:netrw_timefmt = "%H:%M:%S %d-%m-%y"

" make MySQL the default SQL dialect
let g:sql_type_default = 'mysql'

" disable stupid SQL <C-C> mapping
let g:omni_sql_no_default_maps = 1


" --- autocmds ---

augroup vimrc
    au!

    " disable comment continuation after ftplugins
    au BufEnter * setlocal formatoptions-=o formatoptions-=r

    " toggle netrw size style
    au FileType netrw nmap <buffer> H :let g:netrw_sizestyle='H'<CR><C-L>
    au FileType netrw nmap <buffer> B :let g:netrw_sizestyle='b'<CR><C-L>
augroup END


" --- temporary buffers ---

com! -bar B new | setl bt=nofile


" --- script execution ---

fun! Script(name, lines)
    let scrpt = substitute(join(a:lines, '; '), '"', '\"', 'g')
    let cmd = ['bash', '-c', scrpt]

    let bn = bufnr('')
    for info in getwininfo()
        if get(info['variables'], 'script') == bn
            call win_gotoid(info['winid'])
            call term_start(cmd, {'term_name': a:name, 'curwin': 1})
            return
        endif
    endfor

    call term_start(cmd, {'term_name': a:name})
    let w:script = bn
endfun

let s:sl = 'echo "###" `date` `pwd` "###"'

" run a script with info header/footer
com! -nargs=1 -complete=file R let w:sc = [s:sl, <q-args>, s:sl] | call Script(<q-args>, w:sc)

" run Python script
com! P R python %

" run Python script and keep REPL open
com! PI R python -i %

" run yanked Python script and keep REPL open
com! PY exec 'R python -i -c "' . @" . '"'

" rerun last script
com! RR call Script(w:sc[1], w:sc)


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
com! -nargs=1 D let g:sql_login = <q-args>

" MySQL interactive session
com! M exec 'ter mysql --login-path=' . g:sql_login

" print results of an SQL query in a new scratch buffer
fun! Query(query, explicit)
    let $QRY = a:query

    let cmd = 'mysql --login-path=' . g:sql_login . ' -e "$QRY"'
    if a:explicit
        let cmd .= ' -vv'
    else
        let cmd .= ' | column -t -s $''\t'''
    endif

    new
    setlocal buftype=nofile bufhidden=wipe
    let head = a:query[:48]
    let head = substitute(head, '%', '§', 'g')
    let head = substitute(head, '\n', ' ', 'g')
    exec 'file ' . g:sql_login . strftime(' %H:%M:%S ') . head
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

" reload config
com! O source ~/.vimrc

" update config
com! U exec '!cd "$HOME/dotfiles"; git pull --ff-only' | O


" --- mappings ---

" reuse DE umlauts
imap Ö <Esc>

nnoremap ö :Git<CR>
nnoremap ä :sp ~/notes.conf<CR>
nnoremap ü :ter ++close python<CR>
nnoremap ß :sp ~/.vimrc<CR>

nnoremap Ö :cc<CR>
nnoremap Ü :cp<CR>
nnoremap Ä :cn<CR>

" fix jumps for DE layout
nnoremap ] <C-]>
nnoremap [ <C-[>

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
