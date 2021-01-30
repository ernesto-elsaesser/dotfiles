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

" declutter netrw header
let g:netrw_sort_sequence='\/$,*'

" disable netrw file highlighting
autocmd FileType netrw hi netrwExe cterm=NONE | hi netrwSymLink cterm=NONE

" make MySQL the default SQL dialect
let g:sql_type_default='mysql'

" quick save
nmap <Space> :w<CR>

" open parent directory
nmap - :edit %:h/<CR>

" RETRAIN
imap <C-C> <Esc>:echoe 'Use ALT!'<CR>

" temporary buffers
com! -bar ST new | setl bt=nofile bh=wipe nobl
com! -bar VT vert new | setl bt=nofile bh=wipe nobl


" dt bindings

let g:dt = $HOME.'/dotfiles/dt'

fun! DTTerminal(cmd, ...)
    let argstr = join(a:000)
    exec 'ter ++close ' . g:dt . ' ' . a:cmd . ' "' . argstr . '"'
endfun

com! -nargs=* DT call DTTerminal(<f-args>)

fun! DTUpdate()
    exec '!' . g:dt . ' upd'
    so ~/.vimrc
endfun

com! U call DTUpdate()

fun! DTRun(open)
    if a:open
        let tercom = 'vert ter'
    else
        let tercom = 'ter ++curwin'
    endif
    exec tercom . ' ' . g:dt . ' run'
endfun

com! -nargs=1 -complete=file R let $DTC = <q-args> | call DTRun(1)
com! RR call DTRun(0)

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
    ST
    setl ts=20
    exec 'silent read !' . g:dt . ' sql'
    0
endfun

com! -nargs=1 Q DTExecSQL(<q-args>)
com! QQ call DTExecSQL(getreg(0))

com! -nargs=1 ENV let $DTE = <q-args>

fun! DTPylint()
    set errorformat=%f:%l:\ %m
    let &makeprg = g:dt.' pyl %'
    make %
endfun


" leader mappings
nmap <Leader><Leader> :b 

nmap <Leader>g :DT ggl 
nmap <Leader>p :DT pyt<CR>
nmap <Leader>c :DT git<CR>
nmap <Leader>r :so ~/.vimrc<CR>
nmap <Leader>' :cnext<CR>
nmap <Leader>; :cprev<CR>

nmap <Leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>
nmap <Leader>v :setlocal paste!<CR>:setlocal paste?<CR>
nmap <Leader>t :setlocal tabstop+=4<CR>
nmap <Leader>s :let g:netrw_sizestyle=( g:netrw_sizestyle == 'H' ? 'b' : 'H' )<CR><C-L>


" swap list items (separated by ', ')
nmap gx `sv`ty`uv`vp`tv`sp
nmap L mst,mtlllmu/\v(,<Bar>\)<Bar>\}<Bar>\])<CR>?\S<CR>mvgxlll
nmap H mvT,lmuhhhmt?\v(,<Bar>\(<Bar>\{<Bar>\[)<CR>/\S<CR>msgx

