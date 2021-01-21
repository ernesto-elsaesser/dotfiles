unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" ----- options -----

" hacker mode
set background=dark

" spaces > tabs
set tabstop=4 shiftwidth=4 expandtab

" disable unwanted features
set mouse= nowrap noswapfile viminfo=

" complete only from current buffer
set complete=.

" use short universal error format
set errorformat=%f:%l:\ %m

" use autocmd to reset formatoptions after ftplugins
autocmd BufEnter * setlocal formatoptions=

" disable parenthese highlighting
let loaded_matchparen = 1

" declutter netrw header
let g:netrw_sort_sequence='\/$,*'

" disable netrw file highlighting
autocmd FileType netrw hi netrwExe cterm=NONE | hi netrwSymLink cterm=NONE

" configure SQL filetype plugin (MySQL syntax, prevent stupid <C-C> mapping)
let g:sql_type_default='mysql'
let g:omni_sql_no_default_maps=1

" config update
com! U so ~/.vimrc

" quick save
nmap <Space> :w<CR>

" open current file's directory (after making it the alternate file)
nmap - :edit %:h/<CR>

" quick buffer navigation

fun! ListBuffers()
    let line = ' '
    let pos = 1
    for buf in getbufinfo({'buflisted':1})
        if buf['name'] =~ '^!'
            continue
        endif
        let line .= pos . ':'
        let line .= fnamemodify(buf['name'], ':t')
        if buf['loaded']
            let line .= '*'
        endif
        let line .= ' | '
        if pos < 10
            exec 'nmap <C-K>' . pos . ' :b' . buf['bufnr'] .'<CR>'
        endif
        let pos += 1
    endfor
    return line
endfun

set tabline=%!ListBuffers() showtabline=2

nmap <C-K>l :bn<CR>
nmap <C-K>h :bp<CR>
nmap <C-K>k :b#<CR>
nmap <C-K>q :bd<CR>


" temporary buffers

com! -bar Temp setl bt=nofile bh=wipe nobl
com! -bar SplitTemp new | Temp
com! -bar VertTemp vert new | Temp
com! -bar Clone let ft = &ft | VertTemp | let &ft = ft


" dt bindings

let g:dt = $HOME.'/dotfiles/dt'

com! -bar DtUpdate exec '!' . g:dt . ' upd' | U
com! DtUpdateRC DtUpdate | U

com! -bar DtSelect let $DT_FILE = expand('%')

com! -nargs=1 DtConda let $DT_CONDA_ENV = <q-args>
com! -bar DtRun exec 'vert ter ' . g:dt . ' run'
com! -nargs=? DtExec DtSelect | let $DT_RUN_CMD = <q-args> | DtRun
com! DtRerun exec 'ter ++curwin ' . g:dt . ' run'

com! DtGit exec 'ter ++close ' . g:dt . ' git'

com! -nargs=1 DtHeadRef let $DT_HEAD_REF = <q-args>
com! -bar DtRev exec 'read !' . g:dt . ' rev'
com! DtDiff DtSelect | let ln = line('.') | Clone | DtRev | exec ln

com! -nargs=1 DtDatabasePath let $DT_DB_PATH = <q-args>
com! -bar DtSql exec 'silent read !' . g:dt . ' sql'
com! -bar DtExecQuery SplitTemp | setl ts=20 | DtSql | 0
com! -nargs=1 DtLoad let $DT_SQL_QUERY = <q-args> | DtExecQuery
com! DtLoadYanked let $DT_SQL_QUERY = getreg(0) | DtExecQuery

com! DtPylint DtSelect | let &makeprg = g:dt.' pyl' | make %


" leader mappings
nmap <Leader>u :DtUpdateRC<CR>

nmap <Leader>e :DtExec 
nmap <Leader>r :DtRerun<CR>

nmap <Leader>c :DtGit<CR>
nmap <Leader>d :DtDiff<CR>

nmap <Leader>q :DtLoad 
nmap <Leader>a :DtLoadYanked<CR>
nmap <Leader>z :DtDatabasePath 

nmap <Leader>m :DtPylint<CR>
nmap <Leader>n :cnext<CR>
nmap <Leader>b :cprev<CR>

nmap <Leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>
nmap <Leader>v :setlocal paste!<CR>:setlocal paste?<CR>
nmap <Leader>t :setlocal tabstop+=4<CR>
nmap <Leader>s :let g:netrw_sizestyle=( g:netrw_sizestyle == 'H' ? 'b' : 'H' )<CR><C-L>


" swap list items (separated by ', ')
nmap gx `sv`ty`uv`vp`tv`sp
nmap L mst,mtlllmu/\v(,<Bar>\)<Bar>\}<Bar>\])<CR>?\S<CR>mvgxlll
nmap H mvT,lmuhhhmt?\v(,<Bar>\(<Bar>\{<Bar>\[)<CR>/\S<CR>msgx

