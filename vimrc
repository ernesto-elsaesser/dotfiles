set background=dark
set ruler
set number
set backspace=indent,eol,start
set scrolloff=3
set complete=.,t
set completeopt=
set noswapfile
set nowrap
set splitright
set splitbelow
syntax on
filetype plugin indent on

let g:netrw_banner=0
let g:netrw_list_hide='^\.[^.].*'
let g:netrw_sizestyle='H'
"let g:netrw_sort_sequence='\/$,\*$,*'
nmap <space> <cr>

vmap gz de/\w<cr>vep``P

hi MatchParen ctermfg=Red ctermbg=NONE
hi LineNr ctermfg=DarkGray
hi link netrwMarkFile Title

fun! CommitAndPush(message, ...)
	!git add -v --all
	exec '!git commit -m "'.a:message.'"'
	" optional flag for newly created branches
	if a:0 > 0
		!git push -u origin HEAD
	else
		!git push
	endif
endfun

fun! DiffMaster()
	" ensure % is relative to working dir
	cd .
	let l:tf = '/tmp/'.expand('%:t')
	exec 'silent !git show master:./% > '.l:tf
	redraw!
	exec 'keepalt vs '.l:tf
	set diff scrollbind
	wincmd h
	set diff scrollbind
	diffupdate
endfun

fun! QuitDiff()
	set nodiff noscrollbind
	wincmd l
	quit
endfun

fun! MySQL(login)
	exec 'ter ++close mysql --login-path="'.a:login.'"'
endfun

fun! MySQLExec(login, database, ...)
	let l:sql = join(a:000, ' ')
	exec 'ter mysql --login-path="'.a:login.'" '.a:database.' -e "'.l:sql.'"'
endfun

if !exists("*Update")
	fun Update()
		exec "silent cd ".g:config_dir
		!git pull
		silent cd -
		so ~/.vimrc
	endfun
endif

com! L 15Lexplore
com! U call Update()
com! -nargs=? R ter % <args>

com! -nargs=1 G call CommitAndPush(<args>)
com! GS !git diff --name-status
com! GP !git pull
com! GR !git reset --hard
com! GL !git log --oneline
com! GD call DiffMaster()
com! GX call QuitDiff()

com! -nargs=+ P py3 <args>
com! PF py3file %
com! PL compiler pylint | make %

com! -nargs=1 M call MySQL(<q-args>)
com! -nargs=+ ME call MySQLExec(<f-args>)
