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

" temporary buffers
com! -bar ST new | setl bt=nofile bh=wipe nobl
com! -bar VT vert new | setl bt=nofile bh=wipe nobl


" netrw

let g:netrw_banner=0
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'

" fix marked file highlighting
autocmd FileType netrw hi netrwMarkFile ctermbg=1

" remove non-empty directories
autocmd FileType netrw nmap <buffer> A yE:!rm -r <C-R>=b:netrw_curdir<CR>/<C-R>"

nmap - :edit %:h/<CR>


" list reordering

fun! ParseList()
    let line = getline('.')
    let sel_col = col('.')

    let sections = matchlist(line, '\v^(.*[({] ?)(.*\S)( ?[)}].*)$')
    if len(sections) == 0
        return []
    endif

    let prefix = sections[1]
    let items = split(sections[2], ', ')
    let suffix = sections[3]

    let end_col = len(prefix)
    let sel_idx = 0
    while sel_idx < len(items) - 1
        let end_col += len(items[sel_idx]) + 2
        if end_col > sel_col
            break
        endif
        let sel_idx += 1
    endwhile

    return [prefix, items, suffix, sel_idx]
endfun

fun! UpdateList(list_info)
    let [prefix, items, suffix, sel_idx] = a:list_info

    let line = prefix . join(items, ', ') . suffix
    let sel_col = len(prefix) + 1
    for i in range(sel_idx)
        let sel_col += len(items[i]) + 2
    endfor

    call setline('.', line)
    call cursor(line('.'), sel_col)
endfun

fun! MoveListItem(offset)
    let list_info = ParseList()
    if len(list_info) == 0
        echo 'failed to move by ' . a:offset
        return
    endif

    let sel_idx = list_info[3]
    echo 'moving ' sel_idx . ' by ' . a:offset
    let sel_item = remove(list_info[1], sel_idx)
    let sel_idx += a:offset
    if sel_idx < 0
        let sel_idx = 0
    endif
    let max_idx = len(list_info[1])
    if sel_idx > max_idx
        let sel_idx = max_idx
    endif
    call insert(list_info[1], sel_item, sel_idx)
    let list_info[3] = sel_idx
    call UpdateList(list_info)
endfun

com! -count=1 MR call MoveListItem(<count>)
com! -count=1 ML call MoveListItem(-<count>)

nmap L :MR<CR>
nmap H :ML<CR>


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
