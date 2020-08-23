set background=dark
set ruler
set colorcolumn=100
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
nmap <space> <cr>

hi MatchParen ctermfg=Red ctermbg=NONE
hi ColorColumn ctermbg=DarkGray
hi link netrwMarkFile Title

fun! CommitAndPush(message, newbranch)
	!git add -v --all
	exec '!git commit -m "'.a:message.'"'
	if a:newbranch
		!git push -u origin HEAD
	else
		!git push
	endif
endfun

fun! DiffMaster()
	" ensure % is relative to working dir
	cd .
	silent !git show master:% > /tmp/%
	redraw!
	vs /tmp/%
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

fun! MySQL(login, db, sql)
	let c = 'ter ++close mysql --login-path="'.a:login.'"'
	if a:db != ''
		let c .= ' '.a:db
	endif
	if a:sql != ''
		let c .= ' -e "'.a:sql.'"'
	endif
	exec c
endfun

if !exists("*Update")
	fun Update()
		silent cd g:config_dir
		!git pull
		silent cd -
		so ~/.vimrc
	endfun
endif

com! -nargs=1 G call CommitAndPush(<args>, 0)
com! Gs !git diff --name-status
com! Gp !git pull
com! Gr !git reset --hard
com! Gl !git log --oneline
com! Gd call DiffMaster()
com! Gx call QuitDiff()

com! P ter python3 %
com! Pl ter pylint %
com! Pi py3file %
com! -nargs=+ Py py3 <args>

com! L 15Lexplore
