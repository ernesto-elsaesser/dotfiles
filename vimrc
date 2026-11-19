source $VIMRUNTIME/defaults.vim

set background=dark
set noswapfile
set shiftwidth=2
set expandtab
set autoindent
set pastetoggle=<C-y>
set laststatus=2
set statusline=%f%(\ %m%r%)\ -\ line\ %l\ of\ %L%=%c%V

highlight Comment ctermfg=darkgray
highlight MatchParen cterm=underline ctermbg=NONE

inoremap ö <Esc>
inoremap § ö
vnoremap ö <Esc>

nmap <Space> <CR>

nmap - :e .<CR>
nmap _ <C-]>
nmap + :setl wrap!<CR>
nmap # <C-^>

let s:script_dir = expand('<sfile>:p:h') . '/vim'
for s:script_file in glob(s:script_dir . '/*.vim', 1, 1)
  execute 'source' s:script_file
endfor
