unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" --- options ---

" spaces over tabs
set tabstop=4 shiftwidth=4 expandtab

" disable unwanted features
set mouse= nowrap noswapfile viminfo=

" always show status line
set laststatus=2

" complete only from current buffer
set complete=.

" keep undo history on unload
set hidden

" universal brief error format (FILE:LINE ERR_MSG)
set errorformat=%A%f:%l:\ %m,%-G%.%#


" --- variables ---

" disable parenthese highlighting
let loaded_matchparen = 1

" hide netrw banner
let g:netrw_banner = 0

" make MySQL the default SQL dialect
let g:sql_type_default = 'mysql'


" --- mappings ---

nmap <Space> :w<CR>
imap jj <Esc>
" nmap - :edit %:h/<CR> - USE :E
nmap <Tab> :setl ts=
nmap <CR> :setl wrap!<CR>

set pastetoggle=<C-Y>

nmap <C-J> :lnext<CR>
nmap <C-K> :lprev<CR>


" --- autocmds ---

augroup vimrc
    autocmd!

    " disable comment continuation after ftplugins
    autocmd BufEnter * setlocal formatoptions-=o formatoptions-=r

    " toggle netrw size style
    autocmd FileType netrw nmap <buffer> h :let g:netrw_sizestyle='H'<CR><C-L>
    autocmd FileType netrw nmap <buffer> y :let g:netrw_sizestyle='b'<CR><C-L>

    " fix netrw highlighting (red background)
    autocmd FileType netrw hi netrwMarkFile ctermbg=1
augroup END


" --- list reordering ---

fun! GetItemBounds(line, csel)
    let cmax = len(a:line) - 1

    let cleft = a:csel
    while cleft > 0 && index([',', '(', '[', '{'], a:line[cleft-1]) == -1
        let cleft -= 1
    endwhile
    while a:line[cleft] == ' '
        let cleft += 1
    endwhile

    let cright = a:csel
    while cright < cmax && index([',', ')', ']', '}'], a:line[cright+1]) == -1
        let cright += 1
    endwhile
    while a:line[cright] == ' '
        let cright -= 1
    endwhile

    return [cleft, cright]
endfun

fun! ShiftItem(left)
    let line = getline('.')
    let csrc = col('.')

    if a:left
        let [c3, c4] = GetItemBounds(line, csrc)
        let [c1, c2] = GetItemBounds(line, c3 - 3)
    else
        let [c1, c2] = GetItemBounds(line, csrc)
        let [c3, c4] = GetItemBounds(line, c2 + 3)
    endif

    let pre = line[:c1-1]
    let left = line[c1:c2]
    let sep = ', '
    let right = line[c3:c4]
    let post = line[c4+1:]

    call setline('.', pre . right . sep . left . post)
    if a:left
        let cdst = len(pre) + 1
    else
        let cdst = len(pre) + len(right) + len(sep) + 1
    endif
    call cursor(line('.'), cdst)
endfun

nmap L :call ShiftItem(0)<CR>
nmap H :call ShiftItem(1)<CR>


" --- temporary buffers ---

com! -bar NT new | setl bt=nofile bh=wipe nobl
com! -bar VT vert new | setl bt=nofile bh=wipe nobl


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
com! D let ic = [expand('%:.'), line('.'), &ft] | VT | exec 'silent read !git show "HEAD:./' . ic[0] . '"' | exec ic[1] | let &ft = ic[2]


" --- Python ---

" open Python REPL
com! P call term_start('python', {'term_finish': 'close'})

" lint current file
com! PL lex system('pylint --output-format=parseable -sn ' . expand('%'))


" --- MySQL ---

" set login path and optionally database (e.g. :DB main databaseta)
com! -nargs=1 DB let g:sql_cmd = 'mysql --login-path=<args> -vv -e "$QRY"'

" paste the results of the specified SQL query into the current buffer
com! -nargs=1 Q let $QRY = <q-args> | NT | exec 'silent read !' . g:sql_cmd | 0 | setl ts=20

" execute the last yanked SQL query
com! QQ exec 'Q ' . substitute(@", '"', "'", 'g')

" shortcuts for common SQL queries
com! QD Q 'SHOW DATABASES'
com! QT Q 'SHOW TABLES'
com! QV Q 'SHOW VARIABLES'
com! QS Q 'SHOW GLOBAL STATUS'
com! QP Q 'SHOW FULL PROCESSLIST'
com! -nargs=1 QI Q 'SHOW FULL COLUMNS FROM <args>'
com! -nargs=1 QA Q 'SELECT * FROM <args>'
com! -nargs=1 QC Q 'SELECT COUNT(*) FROM <args>'


" -- misc --

" reload config
com! O so ~/.vimrc

" update config
com! U exec '!cd "$HOME/dotfiles"; git pull --ff-only' | O

" open web page in text-based browser
com! -nargs=1 W ter lynx -accept_all_cookies <q-args>
