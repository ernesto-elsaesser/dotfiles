if !has('nvim')
    source $VIMRUNTIME/defaults.vim
    syntax on
    set ttymouse=sgr
    set viminfo=
    set laststatus=2
    set hidden
endif

set noswapfile
set mouse=a
set expandtab autoindent shiftwidth=4 tabstop=4 softtabstop=4
set nowrap
set splitbelow splitright
set complete=. completeopt=

" --- key mapping ---

" quick quit
nnoremap <C-e> :quit<CR>

" quick save
nnoremap <Space> :w<CR>

" open explorer side bar
nnoremap - :15Lexplore<CR>

" change to open directory
nnoremap + :cd %:p<CR>:pwd<CR>

" terminal interaction
if has('nvim')
    nnoremap q :split <Bar> terminal<CR>:let g:termchan = b:terminal_job_id<CR>i
    nnoremap ä :call chansend(g:termchan, getreg('"') . "\n")<CR>
    tnoremap <C-w> <C-\><C-n><C-w>
else
    nnoremap q :terminal<CR><C-w>:let g:termbuf = bufnr('$')<CR>
    nnoremap ä :call term_sendkeys(g:termbuf, getreg('"') . "\r")<CR><CR>
endif

" exit insert/visual/terminal mode with ö
inoremap ö <Esc>
vnoremap ö <Esc>
tnoremap ö <C-\><C-n>

" unindent in insert mode
inoremap <S-Tab> <C-d>

" jump to tag under cursor
nnoremap ß <C-]>

" --- netrw ---

" open files in previous window
let g:netrw_browse_split = 4

" split window size
let g:netrw_winsize = 85

" hide banner (toggle with I)
let g:netrw_banner = 0

" configure sorting
let g:netrw_sort_sequence = '\/$,*'

" configure hiding (a)
let g:netrw_list_hide = '^\.[^.]'

" set current directory to browsing directory
let g:netrw_keepdir = 0

" no ~/.vim/netrwhist file
let g:netrw_dirhistmax = 0

" --- misc ---

" yank to X11 clipboard
augroup Clipboard
    autocmd!
    if executable('xclip')
        autocmd TextYankPost * call system('xclip -i -selection clipboard', getreg(v:event.regname))
    endif
augroup END

" reload config
command! RR source $HOME/.vimrc

