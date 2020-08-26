set background=dark
set ruler
set number
set backspace=indent,eol,start
set complete=.,t
set completeopt=
set noswapfile
set nowrap
set hlsearch
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
	keepalt vs /tmp/%
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
		exec "silent cd ".g:config_dir
		!git pull
		silent cd -
		so ~/.vimrc
	endfun
endif

com! -nargs=1 G call CommitAndPush(<args>, 0)
com! GS !git diff --name-status
com! GP !git pull
com! GR !git reset --hard
com! GL !git log --oneline
com! GD call DiffMaster()
com! GX call QuitDiff()

com! P ter python3 %
com! PL ter pylint %
com! PI py3file %
com! -nargs=+ PP py3 <args>

com! L 15Lexplore
