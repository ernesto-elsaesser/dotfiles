if !has('nvim')
    source $VIMRUNTIME/defaults.vim
    syntax on
    set ttymouse=sgr
    set viminfo=
    set laststatus=2
    set pastetoggle=<C-t>
endif

set background=dark
set noswapfile
set mouse=a
set expandtab autoindent shiftwidth=4 tabstop=4 softtabstop=4
set nowrap
set scrolloff=3
set splitbelow splitright
set completeopt=

" --- key mapping ---

" quick quit
nnoremap <C-d> :quit<CR>
nnoremap <C-j> <C-d>
vnoremap <C-j> <C-d>

" quick save
nnoremap <Space> :w<CR>

" open parent directory
nnoremap - :Explore<CR>

" terminal interaction
if has('nvim')
    nnoremap q :split <Bar> terminal<CR>:let g:termchan = b:terminal_job_id<CR>
    nnoremap ä :call chansend(g:termchan, trim(getline('.')) . "\n")<CR><CR>
    nnoremap ü :call chansend(g:termchan, getreg('"') . "\n")<CR>
    tnoremap <C-w> <C-\><C-n><C-w>
else
    nnoremap q :terminal<CR><C-w>:let g:termbuf = bufnr('$')<CR>
    nnoremap ä :call term_sendkeys(g:termbuf, trim(getline('.')) . "\r")<CR><CR>
    nnoremap ü :call term_sendkeys(g:termbuf, getreg('"') . "\r")<CR>
endif

" exit insert/visual/terminal mode with ö
inoremap ö <Esc>
vnoremap ö <Esc>
tnoremap ö <C-\><C-n>

" unindent in insert mode
inoremap <S-Tab> <C-d>

" tab auto-completion
inoremap <expr> <Tab> trim(getline('.')) == '' ? "\<Tab>" :  "\<C-n>"

" jump to tag under cursor
nnoremap + <C-]>

if has('nvim')
    imap <C-Space> <Plug>(copilot-suggest)
endif

" --- netrw ---

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

" reload config
command! RR source $HOME/.vimrc

" edit markdown notes
command! -nargs=1 MD vs scp://gcp/notes/<args>.md
