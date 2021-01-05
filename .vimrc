unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" ----- options -----

" no mouse
set mouse=

" no swap files
set noswapfile

" always show status line
set laststatus=2

" do not abandon unloaded buffers
set hidden

" complete only from current buffer
set complete=.

" spaces > tabs
set tabstop=4 shiftwidth=4 expandtab

" no wrapping
set nowrap

" use autocmd to reset formatoptions after ftplugins
autocmd BufEnter * setlocal formatoptions=

" disable parenthese highlighting
let loaded_matchparen = 1

" configure netrw (preserve alternate file, declutter banner, size style toggle)
let g:netrw_altfile=1
let g:netrw_sort_sequence='\/$,\*$,*'

" configure SQL filetype plugin (MySQL syntax, prevent stupid <C-C> mapping)
let g:sql_type_default='mysql'
let g:omni_sql_no_default_maps=1


"----- config -----

let g:dotfile_dir = '~/dotfiles'

com! U so ~/.vimrc
com! UP exec '!cd ' . g:dotfile_dir . ' && git pull --ff-only' | U

fun! TermEnv(name)
    exec 'ter ++close bash --rcfile ' . g:dotfile_dir . '/env_'.a:name
endfun


"---- marks -----

fun! Target(mrk)
    let info = getpos("'".a:mrk)
    if info[1] == 0
        return '-'
    endif
    let bufid = info[0]
    if bufid == 0
        let bufid = '%:~'
    endif
    let name = bufname(bufid)
    let parts = split(name, '/')
    if len(parts) > 2
        let parts = ['*', parts[-2], parts[-1]]
    endif
    return join(parts, '/')
endfun

fun! FileMarkMap()
    let marks = [Target('Q'), Target('W'), Target('E'), '|']
    let marks += [Target('A'), Target('S'), Target('D'), '|']
    let marks += [Target('Z'), Target('X'), Target('C')]
    echo join(marks, ' ')
endfun


"----- git ------

fun! GitDiff()
    " make % relative to current working dir
    cd .
    let name = expand('%')
    let type = &ft
    let lnum = line('.')
    vert new
    exec 'setlocal bt=nofile bh=wipe ft='.type
    exec '0read !git show HEAD:./'.file_name
    exec lnum
endfun


"----- mysql -----

com! -nargs=1 DB let g:mysql_conf = <q-args>

fun! ExecMySQLQuery(query)
    new
    exec 'setlocal bt=nofile bh=wipe'
    exec '0read !mysql --login-path='.g:mysql_conf.' -e "'.a:query.'"'
endfun

com! -nargs=1 Q call ExecMySQLQuery(<q-args>)
com! -nargs=1 S call ExecMySQLQuery('SHOW FULL COLUMNS FROM <args>')
com! ST call ExecMySQLQuery('SHOW TABLES')
com! SD call ExecMySQLQuery('SHOW DATABASES')


"----- python -----

com! PL compiler pylint | make %


" ----- mappings -----

" open current file's directory (after making it the alternate file)
nmap - :edit %:h/<CR>

" swap list items (separated by ', ')
nmap gx `sv`ty`uv`vp`tv`sp
nmap L mst,mtlllmu/\v(,<Bar>\)<Bar>\}<Bar>\])<CR>?\S<CR>mvgxlll
nmap H mvT,lmuhhhmt?\v(,<Bar>\(<Bar>\{<Bar>\[)<CR>/\S<CR>msgx

" next quickfix
nmap Q :cnext<CR>

" function mappings
nmap <leader>u :call UpdateConfig()<CR>
nmap <leader>f :call FileMarkMap()<CR>
nmap <leader>c :call TermEnv('git')<CR>
nmap <leader>e :call TermEnv('debug')<CR>
nmap <leader>v :call GitDiff()<CR>

" toggle settings
nmap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>
nmap <leader>p :setlocal paste!<CR>:setlocal paste?<CR>
nmap <leader>t :setlocal tabstop+=4<CR>
nmap <leader>s :let g:netrw_sizestyle=( g:netrw_sizestyle == 'H' ? 'b' : 'H' )<CR>:let g:netrw_sizestyle<CR>

" make current file executable
nmap <leader>x :silent !chmod +x %<CR>
