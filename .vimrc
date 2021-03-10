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
autocmd FileType netrw hi netrwMarkFile ctermbg=3

nmap - :edit %:h/<CR>

com! DEL call system('rm -rf ' . b:netrw_curdir . '/' . getline('.')) | normal <C-L>


" list reordering

fun! ParseList(str)
    let parts = matchlist(a:str, '\v^(.*[({] ?)(.*\S)( ?[)}].*)$')
    let items = split(parts[2], ', ')
    return [parts[1]] + items + [parts[3]]
endfun


fun! ShiftListItem(dir, times)
    let line = getline('.')
    let parts = ParseList(line)

    let max_idx = len(parts) - 2
    let sel_col = col('.')
    let end_col = len(parts[0]) + len(parts[1])
    let src_idx = 1
    while end_col < src_idx && src_idx < max_idx
        let src_idx += 1
        let end_col += 2 + len(parts[src_idx])
    endwhile

    let dst_idx = src_idx
    let shifts = 0
    while shifts < a:times && dst_idx + a:dir >= 1 && dst_idx + a:dir <= max_idx
        let dst_idx += a:dir
        let shifts += 1
    endwhile

    let tmp = parts[src_idx]
    let parts[src_idx] = parts[dst_idx]
    let parts[dst_idx] = tmp

    let modline = parts[0] . join(parts[1:-2], ', ') . parts[-1]
    call setline('.', modline)
endfun

com! -count=1 SR call ShiftListItem(1, <count>)
com! -count=1 SL call ShiftListItem(-1, <count>)


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

com! -nargs=1 Q call DTExecSQL(<q-args>)
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
