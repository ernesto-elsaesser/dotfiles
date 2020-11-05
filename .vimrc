source $VIMRUNTIME/defaults.vim

" no swap files
set noswapfile

" always show status line
set laststatus=2

" do not abandon unloaded buffers
set hidden

" complete from current buffer and tags, do not use popup menu
set complete=.,t completeopt=

" use login shells
set shell=/bin/bash\ -l

" configure netrw (keep alternate file, declutter banner)
let g:netrw_altfile=1
let g:netrw_sort_sequence='\/$,\*$,*'

" configure SQL filetype plugin (MySQL syntax, prevent stupid <C-C> mapping)
let g:sql_type_default='mysql'
let g:omni_sql_no_default_maps=1

" quick buffer switching and closing
nmap <leader>s :b <Tab>
nmap <leader>q :bd <Tab>

" make current file executable
nmap <leader>x :silent !chmod +x %<CR>

" toggle local settings
nmap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>
nmap <leader>p :setlocal paste!<CR>:setlocal paste?<CR>

" increate tabstop stepwise
nmap <leader>t :setlocal tabstop+=4<CR>

" move list item (separated by ', ') one to the right
nmap <leader>l mxdt,llv/\v ?[,)}\]$]<CR>hp`xPlll


"----- config -----

com! U so ~/.vimrc
com! UR exec '!cd ~/dotfiles && git pull' | U

com! TSS let g:netrw_sizestyle=( g:netrw_sizestyle == 'H' ? 'b' : 'H' )

fun! ConfigBuffer()
    if &ft == 'netrw'
        nmap <buffer> h :TSS<CR><C-L>
    else
        setlocal tabstop=4 shiftwidth=4 expandtab formatoptions=
        nmap <buffer> - :edit %:h<CR>
    endif
endfun

autocmd BufEnter * call ConfigBuffer()


"---- terminal -----

fun! TermRun(cmd)
    let g:run_cmd = a:cmd
    let g:run_buf_nr = term_start(g:run_cmd)
    let g:run_win_id = win_findbuf(g:run_buf_nr)[0]
endfun

com! -nargs=1 -complete=file R call TermRun(<q-args>)
com! RI echo job_info(term_getjob(g:run_buf_nr))

fun! TermRerun()
    call win_gotoid(g:run_win_id)
    call term_start(g:run_cmd, {'curwin': 1})
endfun

com! RR call TermRerun()


"----- git ------

com! GA !git add --all && git status
com! -nargs=1 GC !git commit -m <q-args>
com! GK !git push
com! GU !git push -u origin HEAD
com! GJ !git pull
com! GD ter git --no-pager diff

com! -nargs=1 G exe 'GA' | exe 'GC <args>' | exe 'GK'

fun! GitDiff()
    " make % relative to current working dir
    cd .
    let @d = system("git show HEAD:./".expand('%'))
    let l:ft = &ft
    let l:ln = line('.')
    vert new
    exec "set bt=nofile bh=wipe ft=".l:ft
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
