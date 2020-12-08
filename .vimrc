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
com! NS let g:netrw_sizestyle=( g:netrw_sizestyle == 'H' ? 'b' : 'H' ) | Ex

" configure SQL filetype plugin (MySQL syntax, prevent stupid <C-C> mapping)
let g:sql_type_default='mysql'
let g:omni_sql_no_default_maps=1


" ----- mappings -----

" yank from cursor
nmap Y y$

" open current file's directory (after making it the alternate file)
nmap - :edit %:h/<CR>

" swap list items (separated by ', ')
nmap gx `sv`ty`uv`vp`tv`sp
nmap L mst,mtlllmu/\v(,<Bar>\)<Bar>\}<Bar>\])<CR>?\S<CR>mvgxlll
nmap H mvT,lmuhhhmt?\v(,<Bar>\(<Bar>\{<Bar>\[)<CR>/\S<CR>msgx

" next quickfix
nmap Q :cn<CR>

" make current file executable
nmap <leader>x :silent !chmod +x %<CR>

" toggle local settings
nmap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>
nmap <leader>p :setlocal paste!<CR>:setlocal paste?<CR>

" increment tabstop stepwise
nmap <leader>t :setlocal tabstop+=4<CR>


"----- config -----

let g:dotfile_dir = '~/dotfiles'

com! U so ~/.vimrc
com! UR exec '!cd ' . g:dotfile_dir . ' && git pull' | U

com! T exec 'ter ++close bash --rcfile ' . g:dotfile_dir . '/aliases.sh'


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

nmap M :call FileMarkMap()<CR>


"---- terminal -----

fun! TermRun(cmd)
    let g:run_cmd = a:cmd
    let g:run_buf_nr = term_start(g:run_cmd)
    let g:run_win_id = win_findbuf(g:run_buf_nr)[0]
endfun

com! -nargs=1 -complete=file R call TermRun(<q-args>)
com! -nargs=1 RS call TermRun('ssh -t '.<q-args>)
com! RI echo job_info(term_getjob(g:run_buf_nr))

fun! TermRerun()
    call win_gotoid(g:run_win_id)
    call term_start(g:run_cmd, {'curwin': 1})
endfun

com! RR call TermRerun()


"----- git ------

com! GD ter git --no-pager diff

fun! GitDiff()
    " make % relative to current working dir
    cd .
    let @d = system("git show HEAD:./".expand('%'))
    let l:ft = &ft
    let l:ln = line('.')
    vert new
    exec "setlocal nobl bt=nofile bh=wipe ft=".l:ft
    put d
    0delete
    exec l:ln
endfun

com! D call GitDiff()


"----- mysql -----

fun! MySQL(login, ...)
    let l:options = ' ++close'
    let l:args = ''
    if a:0 > 0
        let l:args = ' '.a:1
        if a:0 > 1
            let l:sql = join(a:000[1:], ' ')
            let l:args .= ' -e "'.l:sql.'"'
            let l:options = ''
        endif
    endif
    exec 'vert to ter'.l:options.' mysql --login-path='.a:login.' -A'.l:args
endfun

com! -nargs=+ M call MySQL(<f-args>)


"----- ptyhon -----

com! P ter ++close python3
com! PI ter python3 -i %
com! PL compiler pylint | make %
