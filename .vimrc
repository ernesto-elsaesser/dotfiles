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
set laststatus=2 statusline=\ %n:\ %f\ ---\ %l/%L\ %h%r%m

" complete only from current buffer
set complete=.

" keep undo history
set hidden

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

" make MySQL the default SQL dialect
let g:sql_type_default='mysql'

" prevent the SQL plugin from mapping <C-C> (why??)
let g:omni_sql_no_default_maps=1

" config update command

" quick save
nmap <Space> :w<CR>

" open current file's directory (after making it the alternate file)
nmap - :edit %:h/<CR>

" temporary buffers

com! -bar MakeTemp setl bt=nofile bh=wipe nobl
com! -bar Temp new | MakeTemp
com! -bar VertTemp vert new | MakeTemp
com! -bar DiffTemp let ft = &ft | VertTemp | let &ft = ft


" dt bindings

let g:dt = $HOME.'/dotfiles/dt'

com! -bar DtPullUpdates exec '!' . g:dt . ' upd'
com! DtReload so ~/.vimrc
com! DtUpdate DtPullUpdates | DtReload

com! DtGit exec 'ter ++close ' . g:dt . ' git'

com! -bar DtRun exec 'vert ter ' . g:dt . ' run'
com! -nargs=1 -complete=file DtExec let $DT_RUN_CMD = <q-args> | DtRun
com! DtRerun exec 'ter ++curwin ' . g:dt . ' run'

com! -bar DtSelect let $DT_FILE = expand('%')
com! -nargs=1 DtHeadRef let $DT_HEAD_REF = <q-args>
com! -bar DtRev exec 'read !' . g:dt . ' rev'
com! DtDiff DtSelect | let ln = line('.') | DiffTemp | DtRev | exec ln

com! -nargs=1 DtDatabasePath let $DT_DB_PATH = <q-args>
com! -bar DtSQL exec 'silent read !' . g:dt . ' sql'
com! -bar DtExecQuery Temp | setl ts=20 | DtSQL | 0
com! -nargs=1 DtQuery let $DT_SQL_QUERY = <q-args> | DtExecQuery
com! DtRegQuery let $DT_SQL_QUERY = getreg(0) | DtExecQuery

com! DtPython exec 'ter ++close ' . g:dt . ' pyt'
com! -nargs=1 DtConda let $DT_CONDA_ENV = <q-args>
com! DtPylint DtSelect | let &makeprg = g:dt.' pyl' | make %


" leader mappings
nmap <Leader><Leader> :b 

nmap <Leader>i :DtReload<CR>
nmap <Leader>u :DtUpdate<CR>

nmap <Leader>e :DtExec 
nmap <Leader>r :DtRerun<CR>

nmap <Leader>c :DtGit<CR>
nmap <Leader>d :DtDiff<CR>

nmap <Leader>q :DtQuery 
nmap <Leader>a :DtRegQuery<CR>
nmap <Leader>z :DtDatabasePath 

nmap <Leader>p :DtPython<CR>
nmap <Leader>m :DtPylint<CR>
nmap <Leader>] :cnext<CR>
nmap <Leader>[ :cprev<CR>

nmap <Leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>
nmap <Leader>v :setlocal paste!<CR>:setlocal paste?<CR>
nmap <Leader>t :setlocal tabstop+=4<CR>
nmap <Leader>s :let g:netrw_sizestyle=( g:netrw_sizestyle == 'H' ? 'b' : 'H' )<CR><C-L>


" swap list items (separated by ', ')
nmap gx `sv`ty`uv`vp`tv`sp
nmap L mst,mtlllmu/\v(,<Bar>\)<Bar>\}<Bar>\])<CR>?\S<CR>mvgxlll
nmap H mvT,lmuhhhmt?\v(,<Bar>\(<Bar>\{<Bar>\[)<CR>/\S<CR>msgx

