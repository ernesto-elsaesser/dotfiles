" --- settings ---

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
set completeopt=
set updatetime=1000

" --- key mappings ---

" quit
nnoremap <C-d> :quit<CR>

" scroll
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
vnoremap <C-j> <C-d>
vnoremap <C-k> <C-u>

" reload config
nnoremap <C-u> :source $HOME/.vimrc<CR>

" return no normal mode
inoremap öö <Esc>
tnoremap öö <C-\><C-n>

" save
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

" jump to tag under cursor
nnoremap gt <C-]>

" toggle word wrap
nnoremap + :setl wrap!<CR>

" command mode home key
cnoremap <C-A> <Home>

" tab completion
if !exists('g:loaded_copilot')
    " Copilot maps <Tab> to accept-suggestion, with the previous mapping as
    " fallback when no suggestion is displayed. Reinstalling the mapping
    " after loading Copilot would erase the Copilot mapping.
    inoremap <Tab> <C-n>
endif

" --- leader mappings ---

let g:mapleader = "ö"

" search in files
nmap <Leader>f :vim // *<Left><Left><Left>
nmap <Leader><Leader> :cc<CR>
nmap <Leader>j :cn<CR>
nmap <Leader>k :cp<CR>

" git
nmap <Leader>s :!git status<CR>
nmap <Leader>m :!git status --short<CR>
nmap <Leader>d :vert rightb ter git diff<CR>
nmap <Leader>i :vert rightb ter git diff --staged<CR>
nmap <Leader>a :!git add --all --verbose<CR>
nmap <Leader>x :!git reset HEAD<CR>
nmap <Leader>c :!git commit -m ""<Left>
nmap <Leader>p :!git push<CR>
nmap <Leader>g :!git pull<CR>
nmap <Leader>l :!git log -8<CR>
nmap <Leader>r :!git reset --hard HEAD<CR>
nmap <Leader>b :!git reset --hard HEAD^<CR>
nmap <Leader>h <Plug>(GitGutterStageHunk)
nmap <Leader>u <Plug>(GitGutterUndoHunk)

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

" --- plugins ---

" copilot
let g:copilot_filetypes = { "markdown": v:false }

" gitgutter
highlight GitGutterAdd guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#aaaa00 ctermfg=3

