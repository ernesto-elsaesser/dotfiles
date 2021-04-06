unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" ----- options -----

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

" use autocmd to reset formatoptions after ftplugins
autocmd BufEnter * setlocal formatoptions=

" disable parenthese highlighting
let loaded_matchparen = 1

" make MySQL the default SQL dialect
let g:sql_type_default='mysql'

" quick save
nmap <Space> :w<CR>

" avoid escape key
imap jj <Esc>

" open parent directory
nmap - :edit %:h/<CR>

" temporary buffers
com! -bar ST new | setl bt=nofile bh=wipe nobl
com! -bar VT vert new | setl bt=nofile bh=wipe nobl


" netrw

let g:netrw_banner=0
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'

" fix marked file highlighting
autocmd FileType netrw hi netrwMarkFile ctermbg=1


" list reordering

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


" dt bindings

let g:dt = $HOME.'/dotfiles/dt'
com! U exec '!' . g:dt . ' upd' | so ~/.vimrc

fun! DTTerminal(cmd, ...)
    let argstr = join(a:000)
    exec 'ter ++close ' . g:dt . ' ' . a:cmd . ' "' . argstr . '"'
endfun

com! -nargs=* DT call DTTerminal(<f-args>)

fun! DTRun()
    if &tags == 'run'
        let tercom = 'ter ++curwin '
    else
        let tercom = 'vert ter '
    endif
    exec tercom . g:dt . ' run'
    setl tags=run
endfun

com! -nargs=1 -complete=file R let $DTC = <q-args> | call DTRun()
com! RR call DTRun()

fun! LoadRevision(mod)
    cd .
    let $DTM = a:mod
    let $DTF = expand('%')
    let ln = line('.')
    let ft = &ft
    VT
    let &ft = ft
    exec 'read !' . g:dt . ' rev'
    exec ln
endfun

com! D call LoadRevision('')

com! -nargs=1 DB let $DTL = <q-args>

fun! DTExecSQL(query)
    let $DTQ = a:query
    ST
    setl ts=20
    exec 'silent read !' . g:dt . ' sql'
    0
endfun

com! -nargs=1 -complete=file Q call DTExecSQL(<q-args>)
com! QQ call DTExecSQL(getreg(0))

fun! DTPylint()
    set errorformat=%f:%l:\ %m
    let &makeprg = g:dt.' pyl %'
    make %
endfun

com! PL call DTPylint()


" leader mappings

nmap <Leader>' :cnext<CR>
nmap <Leader>; :cprev<CR>
nmap <Leader>[ :DT git<CR>
nmap <Leader>] :DT pyt<CR>
nmap <Leader>o :so ~/.vimrc<CR>
nmap <Leader>l :setlocal wrap!<CR>:setlocal wrap?<CR>
nmap <Leader>p :setlocal paste!<CR>:setlocal paste?<CR>
nmap <Leader>i :setlocal tabstop+=4<CR>
nmap <Leader>k :let g:netrw_sizestyle=( g:netrw_sizestyle == 'H' ? 'b' : 'H' )<CR><C-L>
