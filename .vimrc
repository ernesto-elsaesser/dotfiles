unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" no swap files
set noswapfile

" always show status line
set laststatus=2

" do not abandon unloaded buffers
set hidden

" complete from current buffer and tags, do not use popup menu
set complete=.,t completeopt=

" spaces > tabs
set tabstop=4 shiftwidth=4 expandtab

" no wrapping
set nowrap

" use autocmd to set formatoptions after ftplugins
autocmd BufEnter * setlocal formatoptions=

" configure netrw (preserve alternate file, declutter banner, size style toggle)
let g:netrw_altfile=1
let g:netrw_sort_sequence='\/$,\*$,*'
com! NS let g:netrw_sizestyle=( g:netrw_sizestyle == 'H' ? 'b' : 'H' ) | Ex

" configure SQL filetype plugin (MySQL syntax, prevent stupid <C-C> mapping)
let g:sql_type_default='mysql'
let g:omni_sql_no_default_maps=1

" open current file's directory (after making it the alternate file)
nmap - :edit %:h<CR>

" swap list items (separated by ', ')
nmap gx `sv`ty`uv`vp`tv`sp
nmap <leader>l mst,mtlllmu/\v ?(,<Bar>\)<Bar>\}<Bar>\])<CR>hmvgxlll
nmap <leader>h mvT,lmuhhhmt?\v(,<Bar>\(<Bar>\{<Bar>\[)<CR>wmsgx

" next quickfix
nmap <leader>q :cn<CR>

" make current file executable
nmap <leader>x :silent !chmod +x %<CR>

" toggle local settings
nmap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>
nmap <leader>p :setlocal paste!<CR>:setlocal paste?<CR>

" increate tabstop stepwise
nmap <leader>t :setlocal tabstop+=4<CR>


"----- config -----

com! U so ~/.vimrc
com! UR exec '!cd ~/dotfiles && git pull' | U


"----- bookmarks -----

com! BC let g:bms = {}
com! BL echo map(copy(g:bms), 'fnamemodify(v:val, ":t")')
com! -nargs=1 B let g:bms[<args>] = @% | BL
com! -nargs=1 BG exec 'edit '.g:bms[<args>]

if !exists('g:bms')
    BC
endif

nmap <leader><leader> :BL<CR>
nmap <leader>1 :BG 1<CR>
nmap <leader>2 :BG 2<CR>
nmap <leader>3 :BG 3<CR>
nmap <leader>4 :BG 4<CR>
nmap <leader>5 :BG 5<CR>
nmap <leader>6 :BG 6<CR>
nmap <leader>7 :BG 7<CR>
nmap <leader>8 :BG 8<CR>
nmap <leader>9 :BG 9<CR>


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
