unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" --- options ---

" hacker mode
set background=dark

" spaces > tabs
set tabstop=4 shiftwidth=4 expandtab

" disable unwanted features
set mouse= nowrap noswapfile viminfo=

" always show file name
set laststatus=2 statusline=\ %f\ ---\ %l/%L\ %h%r%m%=%c\  

" complete only from current buffer
set complete=.

" keep undo history on unload
set hidden

" universal brief error format
set errorformat=%A%f:%l:\ %m,%-G%.%#


" --- variables ---

" disable parenthese highlighting
let loaded_matchparen = 1

" netrw
let g:netrw_banner=0
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_sizestyle='H'

" make MySQL the default SQL dialect
let g:sql_type_default='mysql'


" --- mappings ---

nmap <Space> :w<CR>
imap jj <Esc>
nmap - :edit %:h/<CR>
nmap <Tab> :setl ts=
nmap <CR> :setl wrap!<CR>

set pastetoggle=<C-I>

nmap <C-J> :lnext<CR>
nmap <C-K> :lprev<CR>


" --- autocmds ---

augroup vimrc
    autocmd!

    " discard formatoptions set by ftplugins
    autocmd BufEnter * setlocal formatoptions=

    " toggle netrw size style
    autocmd FileType netrw nmap <buffer> y :let g:netrw_sizestyle='b'<CR><C-L>
    autocmd FileType netrw nmap <buffer> h :let g:netrw_sizestyle='H'<CR><C-L>

    " fix netrw highlighting
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


" --- shell integrations ---

com! -bar NT new | setl bt=nofile bh=wipe nobl
com! -bar VT vert new | setl bt=nofile bh=wipe nobl

let g:dt_dir = $HOME.'/dotfiles'
let g:dt_gitrc = g:dt_dir.'/git-env/.bashrc'

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

com! O so ~/.vimrc
com! U exec '!cd ' . g:dt_dir . '; git pull --ff-only' | so ~/.vimrc
com! L call term_start('bash --rcfile '. g:dt_gitrc, {'term_finish': 'close'})
com! P call term_start('python', {'term_finish': 'close'})

let s:sl = 'echo "###" `date` `pwd` "###"'
com! -nargs=1 -complete=file R let b:sc = [s:sl, <q-args>, s:sl] | call Script(<q-args>, b:sc)
com! RR call Script(b:sc[1], b:sc)

com! D let ic = [expand('%:.'), line('.'), &ft] | VT | exec 'silent read !git show "HEAD:./' . ic[0] . '"' | exec ic[1] | let &ft = ic[2]

com! -nargs=1 DB let g:dt_db = '--login-path=<args>'

fun! SQLQuery(query)
    let $QUERY = substitute(a:query, '"', '\"', 'g')
    NT
    exec 'silent read !mysql ' . g:dt_db . ' -vv -e "$QUERY"'
    setl ts=20
    0
endfun

com! -nargs=1 -complete=file Q call SQLQuery(<q-args>)
com! -range=% QQ call SQLQuery(join(getline(<line1>,<line2>), ' '))
com! QB call SQLQuery('SHOW DATABASES')
com! QT call SQLQuery('SHOW TABLES')
com! -nargs=1 QS call SQLQuery('DESCRIBE <args>')
com! -nargs=1 QA call SQLQuery('SELECT * FROM <args>')
com! -nargs=1 QC call SQLQuery('SELECT COUNT(*) FROM <args>')

com! PL lex system('pylint --output-format=parseable -sn ' . expand('%'))
