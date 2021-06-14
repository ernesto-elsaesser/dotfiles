unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" --- options ---

" spaces over tabs
set tabstop=4 shiftwidth=4 expandtab

" disable unwanted features
set mouse= nowrap noswapfile viminfo=

" always show status line
set laststatus=2

" complete only from current buffer, no popup menu
set complete=. completeopt=

" keep undo history on unload
set hidden

" universal error format [FILE:LINE: ERR_MSG]
set errorformat=%A%f:%l:\ %m,%-G%.%#

" Quickly turn paste on and off in insert mode
set pastetoggle=<C-Y>


" --- variables ---

" disable parenthese highlighting
let loaded_matchparen = 1

" hide netrw banner
let g:netrw_banner = 0

" make MySQL the default SQL dialect
let g:sql_type_default = 'mysql'

" disable stupid SQL <C-C> mapping
let g:omni_sql_no_default_maps = 1


" --- mappings ---

" quick save
nmap <Space> :w<CR>

" toggle line wrapping
nmap <CR> :setl wrap!<CR>

" write as root
cmap w!! w !sudo tee > /dev/null %

" iterate quickfix list
nmap <C-E> :cc<CR>
nmap <Left> :cp<CR>
nmap <Right> :cn<CR>


" --- autocmds ---

augroup vimrc
    autocmd!

    " disable comment continuation after ftplugins
    autocmd BufEnter * setlocal formatoptions-=o formatoptions-=r

    " toggle netrw size style
    autocmd FileType netrw nmap <buffer> s :let g:netrw_sizestyle='H'<CR><C-L>
    autocmd FileType netrw nmap <buffer> x :let g:netrw_sizestyle='b'<CR><C-L>

    " fix netrw highlighting (red background)
    autocmd FileType netrw hi netrwMarkFile ctermbg=1
augroup END


" --- temporary buffers ---

com! -bar B new | setl bt=nofile bh=wipe
com! -bar BB vert new | setl bt=nofile bh=wipe


" --- script execution ---

fun! Script(name, lines)
    let scrpt = substitute(join(a:lines, '; '), '"', '\"', 'g')
    let cmd = ['bash', '-c', scrpt]

    for info in getwininfo()
        if get(info['variables'], 'script')
            call win_gotoid(info['winid'])
            call term_start(cmd, {'term_name': a:name, 'curwin': 1})
            return
        endif
    endfor

    call term_start(cmd, {'term_name': a:name, 'vertical': 1})
    let w:script = 1
endfun

let s:sl = 'echo "###" `date` `pwd` "###"'

" run a script with info header/footer
com! -nargs=1 -complete=file R let w:sc = [s:sl, <q-args>, s:sl] | call Script(<q-args>, w:sc)

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
com! L call term_start(g:git_cmd, {'env': g:git_env, 'term_finish': 'close'})

" show HEAD version of current file (diff)
com! H let t = [expand('%:.'), line('.'), &ft] | BB | exec 'silent read !git show "HEAD:./' . t[0] . '"' | exec t[1] | let &ft = t[2]


" --- MySQL ---

" set login path and optionally database (e.g. :D main databaseta)
com! -nargs=1 D let g:sql_login = <q-args>

fun! Query(query, verbose, format)
    let query = substitute(a:query, '\n', " ", 'g')
    let query = substitute(query, '"', "'", 'g')

    let cmd = 'mysql --login-path=' . g:sql_login
    if a:verbose
        let cmd .= ' -vv'
    endif
    let cmd .= ' -e "' . query . '"'
    if a:format
        let cmd .= ' | column -t -s $''\t'''
    endif

    new
    setlocal buftype=nofile bufhidden=wipe
    let bufname = query[:64] . ' [' . strftime('%T') . ']'
    exec 'file ' . bufname
    exec 'silent 0read !' . cmd
    0
endfun

" print results of an SQL query in a new scratch buffer
com! -nargs=1 Q call Query(<q-args>, 0, 1)

com! QD Q SHOW DATABASES
com! QT Q SHOW TABLES
com! QV Q SHOW VARIABLES
com! QG Q SHOW GLOBAL STATUS
com! QP Q SHOW FULL PROCESSLIST

cnoremap QI Q SHOW FULL COLUMNS FROM
cnoremap QS Q SELECT
cnoremap QA Q SELECT * FROM
cnoremap QC Q SELECT COUNT(*) FROM

" execute the last yanked SQL query
com! QQ call Query(@", 0, 1)


" -- misc --

" reload config
com! O source ~/.vimrc

" update config
com! U exec '!cd "$HOME/dotfiles"; git pull --ff-only' | O

" set tab width
com! -nargs=1 T set tabstop=<args>

" open notes
com! K edit ~/notes.md

" Python REPL
com! P ter ++close python

" swap list items
vmap z :s/\%V\([^,]\+\)\(.*\), \([^,]\+\%V.\)/\3\2, \1/<CR>
" test: (aaaaa, bbbb, ccc, ddddddd)

" open web page in text-based browser
com! -nargs=1 W ter ++close lynx -accept_all_cookies <args>
