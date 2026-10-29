let g:mapleader = ","

" open HOME in new tab
nmap <Leader>t :tabe ~/<CR>

" toggle color column
nmap <Leader>i :let &l:cc=(empty(&l:cc) ? '80' : '')<CR>

" scratch buffer
nmap <Leader>z :split new<CR>:setl bt=nofile bh=wipe<CR>

" search in files
nmap <Leader>f :vim // *<Left><Left><Left>

" quickfix list
nmap <Leader><Leader> :cc<CR>
nmap <Leader>j :cn<CR>
nmap <Leader>k :cp<CR>

" git
nmap <Leader>g :!git pull --ff-only<CR>
nmap <Leader>a :!git add --all --verbose<CR>
nmap <Leader>x :!git commit -a -m ''<Left>
nmap <Leader>c :!git commit -m ''<Left>
nmap <Leader>p :!git push<CR>
nmap <Leader>e :!git add %<CR>
nmap <Leader>r :!git rm --cached %<CR>

" tig
nnoremap <Leader>w :silent !tig blame %<CR><C-l>
nnoremap <Leader>s :silent !tig status<CR><C-l>
nnoremap <Leader>l :silent !tig<CR><C-l>

" top
nmap <Leader>h :silent !htop<CR><C-l>
nmap <Leader>n :silent !nvtop<CR><C-l>

