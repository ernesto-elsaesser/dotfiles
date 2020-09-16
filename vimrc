unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set background=dark
set mouse=
set hidden
set number
set cursorline
set complete=.,t
set completeopt=
set noswapfile
set nowrap
set splitright
set splitbelow

let g:netrw_liststyle=1
let g:netrw_list_hide='^\.'
let g:netrw_sort_sequence='\/,*'
let g:netrw_sizestyle='H'

nmap gz de/\w<cr>vep``P

hi MatchParen ctermfg=Green ctermbg=NONE
hi LineNr ctermfg=DarkGray
hi CursorLineNr cterm=NONE ctermbg=DarkGray ctermfg=Black
hi CursorLine cterm=NONE
hi link netrwMarkFile Title

let g:diff_branch='master'

fun! DiffGit()
	cd .
	let @d = system("git show ".g:diff_branch.":./".bufname('%'))
	let l:ft = &ft
	let l:ln = line('.')
	setlocal diff scrollbind
	vert new
	exec "set bt=nofile bh=wipe ft=".l:ft
	autocmd BufWipeout <buffer> diffoff!
	put d
	0delete
	exec l:ln
	setlocal diff scrollbind 
	diffupdate
endfun

fun! MySQL(login, database)
	exec 'ter ++rows=40 ++close mysql --login-path="'.a:login.'" '.a:database
endfun

fun! MySQLExec(login, database, ...)
	let l:sql = join(a:000, ' ')
	exec 'ter ++rows=40 mysql --login-path="'.a:login.'" '.a:database.' -e "'.l:sql.'"'
endfun

com! H exec "Explore ".getcwd()
com! U so ~/.vimrc
com! UR call system('update-repo.sh')
com! -nargs=? -complete=file R exec "ter ++rows=24 ".expand('%:p')." <args>"

com! G ter ++close commit-and-push.sh
com! GD ter git --no-pager diff
com! GP call system("git pull")
com! D call DiffGit()

com! -nargs=+ P py3 <args>
com! -nargs=1 PP py3 print(<args>)
com! PF py3file %
com! PL compiler pylint | make %

com! -nargs=+ M call MySQL(<f-args>)
com! -nargs=+ ME call MySQLExec(<f-args>)
