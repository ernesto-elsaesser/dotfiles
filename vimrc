if !has('nvim')
    source $VIMRUNTIME/defaults.vim
    syntax on
    set background=dark
    set ttymouse=sgr
    set viminfo=
    set laststatus=2
    set pastetoggle=<C-t>
    set autoindent
endif

set noswapfile
set mouse=a
set tabstop=4 shiftwidth=0 softtabstop=-1 expandtab
set relativenumber
set scrolloff=3
set nowrap
set completeopt=
set updatetime=1000

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
    nnoremap q :below split <Bar> terminal<CR>:let g:termchan = b:terminal_job_id<CR>i
    nnoremap ä :call chansend(g:termchan, trim(getline('.')) . "\n")<CR><CR>
    nnoremap ü :call chansend(g:termchan, getreg('"') . "\n")<CR>
    nnoremap # :call chansend(g:termchan, "\x10\n")<CR>
    " directly switch into and out of terminal mode
    tnoremap <C-w> <C-\><C-n><C-w>
    augroup TermAutoInsert
      autocmd!
      autocmd WinEnter term://* startinsert
    augroup END
else
    nnoremap q :below terminal<CR><C-w>:let g:termbuf = bufnr('$')<CR>
    nnoremap ä :call term_sendkeys(g:termbuf, trim(getline('.')) . "\r")<CR><CR>
    nnoremap ü :call term_sendkeys(g:termbuf, getreg('"') . "\r")<CR>
    nnoremap # :call term_sendkeys(g:termbuf, "\x10\n")<CR>
endif

" exit insert/visual/terminal mode
inoremap ö <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
tnoremap <C-k> <C-\><C-n>

" jump to tag under cursor
nnoremap gt <C-]>

" command mode home key
cnoremap <C-A> <Home>

" git
let g:mapleader = ","
nmap <Leader>s :!git status --short<CR>
nmap <Leader>a :!git add --all --verbose<CR>
nmap <Leader>c :!git commit -m ""<Left>
nmap <Leader>p :!git push<CR>
nmap <Leader>g :!git pull<CR>
nmap <Leader>l :!git log -8<CR>
nmap <Leader>h <Plug>(GitGutterStageHunk)
nmap <Leader>u <Plug>(GitGutterUndoHunk)

" tab completion
if !exists('g:loaded_copilot')
    " Copilot maps <Tab> to accept-suggestion, with the previous mapping as
    " fallback when no suggestion is displayed. Reinstalling the mapping
    " after loading Copilot would erase the Copilot mapping.
    inoremap <Tab> <C-n>
endif

" Copilot
let g:copilot_filetypes = { "markdown": v:false }

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

" human-readable file sizes
let g:netrw_sizestyle = 'H'

" --- misc ---

" gitgutter sign colors
highlight GitGutterAdd guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#aaaa00 ctermfg=3

" reload config
command! RC source $HOME/.vimrc

