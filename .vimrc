unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" ----- options -----

" spaces > tabs
set tabstop=4 shiftwidth=4 expandtab

" disable unwanted features
set mouse= nowrap noswapfile

" always show status line
set laststatus=2

" do not abandon unloaded buffers
set hidden

" complete only from current buffer
set complete=.

" use autocmd to reset formatoptions after ftplugins
autocmd BufEnter * setlocal formatoptions=

" disable parenthese highlighting
let loaded_matchparen = 1

" configure netrw (preserve alternate file, declutter banner)
let g:netrw_altfile=1
let g:netrw_sort_sequence='\/$,\*$,*'

" configure SQL filetype plugin (MySQL syntax, prevent stupid <C-C> mapping)
let g:sql_type_default='mysql'
let g:omni_sql_no_default_maps=1


"----- config -----

let g:dotfile_dir = $HOME.'/dotfiles'

com! U so ~/.vimrc
com! UP exec '!cd ' . g:dotfile_dir . ' && git pull --ff-only' | U

fun! LaunchEnv(name, prefix)
    exec a:prefix.'ter ++close '.g:dotfile_dir.'/launch-env.sh '.a:name.' '.expand('%')
endfun


"---- marks -----

fun! ListFileMarks(...)
    for mrk in a:000
        let info = getpos("'" . mrk)
        if info[1] == 0
            continue
        endif
        let bufid = info[0]
        if bufid == 0
            let bufid = '%:~'
        endif
        echo mrk . '  ' . bufname(bufid)
    endfor
endfun


"----- git ------

fun! ShowGitRev(ref)
    " make % relative to current working dir
    cd .
    let name = expand('%')
    let type = &ft
    let lnum = line('.')
    vert new
    exec 'setlocal bt=nofile bh=wipe ft='.type
    exec '0read !git show '.a:ref.':./'.name
    exec lnum
endfun

com! -nargs=? RV call ShowGitRev('HEAD<args>')


"----- mysql -----

com! -nargs=1 DB let g:mysql_conf = <q-args>

fun! ExecSQLQuery(query)
    new
    exec 'setlocal bt=nofile bh=wipe ts=20'
    exec '0read !mysql --login-path='.g:mysql_conf.' -e "'.a:query.'"'
endfun

com! -nargs=1 Q call ExecSQLQuery(<q-args>)
com! -nargs=1 S call ExecSQLQuery('SHOW FULL COLUMNS FROM <args>')
com! ST call ExecSQLQuery('SHOW TABLES')
com! SD call ExecSQLQuery('SHOW DATABASES')

fun! ExecSQLScript(line1, line2)
    let lines = getbufline('%', a:line1, a:line2)
    let query = ''
    for line in lines
        let query .= line . ' '
    endfor
    call ExecSQLQuery(query)
endfun

com! -range=% QS call ExecSQLScript(<line1>,<line2>)


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

" leader mappings
nmap <Leader>q 'Q
nmap <Leader>w 'W
nmap <Leader>e 'E
nmap <Leader>r :call LaunchEnv('dbg', 'vert ')<CR>

nmap <Leader>a 'A
nmap <Leader>s 'S
nmap <Leader>d 'D
nmap <Leader>f :call ListFileMarks('Q','W','E','A','S','D')<CR>

nmap <Leader>x :setlocal wrap!<CR>:setlocal wrap?<CR>
nmap <Leader>c :call LaunchEnv('git', '')<CR>
nmap <Leader>v :setlocal paste!<CR>:setlocal paste?<CR>
nmap <Leader>t :setlocal tabstop+=4<CR>
nmap <Leader>b :let g:netrw_sizestyle=( g:netrw_sizestyle == 'H' ? 'b' : 'H' )<CR>:let g:netrw_sizestyle<CR>
