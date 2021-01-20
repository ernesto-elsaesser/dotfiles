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

" use autocmd to reset formatoptions after ftplugins
autocmd BufEnter * setlocal formatoptions=

" disable parenthese highlighting
let loaded_matchparen = 1

" configure netrw
let g:netrw_sort_sequence='\/$,*'
hi netrwExe cterm=NONE
hi netrwSymLink cterm=NONE

" configure SQL filetype plugin (MySQL syntax, prevent stupid <C-C> mapping)
let g:sql_type_default='mysql'
let g:omni_sql_no_default_maps=1

" open current file's directory (after making it the alternate file)
nmap - :edit %:h/<CR>

" custom tab line

fun! GetTabLine()
    let tabnrs = range(1, tabpagenr('$'))
    let titles = map(tabnrs, 'v:val . ":" . fnamemodify(bufname(tabpagebuflist(v:val)[-1]),":t")')
    let selnr = tabpagenr() - 1
    let titles[selnr] = titles[selnr] . '*'
    return ' ' . join(titles, ' | ')
endfunction

set tabline=%!GetTabLine()

com! -nargs=1 -complete=file T $tabedit <args>
nmap <Space> :tabp<CR>


" dt bindings

let g:dt = $HOME.'/dotfiles/dt'

com! U so ~/.vimrc
com! UP exec '!' . g:dt . ' upd' | U

com! DtSelect let $DT_FILE = expand('%')

com! -nargs=1 DtRunCmd let $DT_RUN_CMD = <q-args>
com! -nargs=1 DtConda let $DT_CONDA_ENV = <q-args>
com! DtRun exec 'vert ter ' . g:dt . ' run'
com! DtRerun exec 'ter ++curwin ' . g:dt . ' run'

com! Scratch setl bt=nofile bh=wipe

com! DtGit exec 'ter ++close ' . g:dt . ' git'

com! -nargs=1 DtHeadRef let $DT_HEAD_REF = <q-args>
com! CopyState let g:svd_ft = &ft | let g:svd_ln = line('.')
com! PasteState exec 'setl ft='.g:svd_ft | exec g:svd_ln
com! DtRev exec 'read !' . g:dt . ' rev'
com! DtDiff DtSelect | CopyState | vert new | Scratch | DtRev | PasteState

com! -nargs=1 DtDatabasePath let $DT_DB_PATH = <q-args>
com! DtSql exec 'silent read !' . g:dt . ' sql'
com! DtExecQuery new | Scratch | setl ts=20 | DtSql | 0
com! -nargs=1 DtLoad let $DT_SQL_QUERY = <q-args> | DtExecQuery
com! DtLoadYanked let $DT_SQL_QUERY = getreg(0) | DtExecQuery

let &makeprg=g:dt.' pyl'
set errorformat=%A%f:%l:\ %m
" TODO test, needed %A?

" leader mappings
nmap <Leader>[ :tabm -<CR>
nmap <Leader>] :tabm +<CR>

nmap <Leader>x :DtRunCmd '
nmap <Leader>. :DtSelect<CR>
nmap <Leader>e :DtRun<CR>
nmap <Leader>r :DtRerun<CR>

nmap <Leader>m :make %<CR>
nmap <Leader>n :cnext<CR>

nmap <Leader>c :DtGit<CR>
nmap <Leader>d :DtDiff<CR>

nmap <Leader>z :DtDatabasePath 
nmap <Leader>q :DtLoad 
nmap <Leader>a :DtLoadYanked<CR>

nmap <Leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>
nmap <Leader>v :setlocal paste!<CR>:setlocal paste?<CR>
nmap <Leader>t :setlocal tabstop+=4<CR>
nmap <Leader>s :let g:netrw_sizestyle=( g:netrw_sizestyle == 'H' ? 'b' : 'H' )<CR>:let g:netrw_sizestyle<CR>

" swap list items (separated by ', ')
nmap gx `sv`ty`uv`vp`tv`sp
nmap L mst,mtlllmu/\v(,<Bar>\)<Bar>\}<Bar>\])<CR>?\S<CR>mvgxlll
nmap H mvT,lmuhhhmt?\v(,<Bar>\(<Bar>\{<Bar>\[)<CR>/\S<CR>msgx

