let g:mapleader = ","

" open HOME in new tab
nmap <Leader>t :tabe ~/<CR>

" toggle word wrap
nmap <Leader>w :setl wrap!<CR>

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
nmap <Leader>e :!clear && git add %<CR>
nmap <Leader>r :!clear && git rm --cached %<CR>
nmap <Leader>g :!clear && git pull --ff-only<CR>
nmap <Leader>a :!clear && git add --all --verbose<CR>
nmap <Leader>s :!clear && git status<CR>
nmap <Leader>x :!clear && git commit -a -m ''<Left>
nmap <Leader>c :!clear && git commit -m ''<Left>
nmap <Leader>p :!clear && git push<CR>

" show spaces
nmap <Leader>v :setl lcs=space:·<CR>:l<CR>

" top
nmap <Leader>h :silent !htop<CR><C-l>
nmap <Leader>n :silent !nvtop<CR><C-l>

