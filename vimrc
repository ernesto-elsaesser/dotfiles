" --- settings ---

if &compatible
  set nocompatible
  set viminfo=
  set ttymouse=sgr
  set pastetoggle=<C-y>
endif

syntax on
filetype plugin on

set mouse=a
set background=dark
set noswapfile
set incsearch
set backspace=indent,eol,start
set laststatus=2
set ruler
set wildmenu
set scrolloff=5
set splitright
set shiftwidth=2 softtabstop=-1 expandtab
set autoindent

" --- key mappings ---

" quick save
nmap <Space> :w<CR>

" quick quit
nmap qq :q<CR>

" quick tab switch
nmap <Tab> gt
nmap <S-Tab> gT

" exit insert/visual mode
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>

" scrolling
nmap <C-j> <C-d>
nmap <C-k> <C-u>

" alternate file
nmap # <C-^>

" open parent directory
nmap - :Ex<CR>

" toggle word wrap
nmap + :setl wrap!<CR>

" jump to keyword under cursor
nmap gk <C-]>

" split linked terminal
nmap ü :VTerm<CR>
nmap Ü :Term<CR>

" exit terminal mode
tnoremap ö <C-\><C-n>

" paste to linked terminal
nmap Ö :call term_sendkeys(b:tb, trim(getreg('"')) .. "\n")<CR>
nmap ö yyÖ

" repeat previous command in linked terminal
nmap ä :call term_sendkeys(b:tb, "\x10\r")<CR>

" flutter hot reload / restart
nmap gr :call term_sendkeys(b:tb, "r")<CR>
nmap gR :call term_sendkeys(b:tb, "R")<CR>

" --- leader mappings ---

let g:mapleader = ","

" scratch buffer
nmap <Leader>t :split new<CR>:setl bt=nofile bh=wipe<CR>

" show unsaved changes
nmap <Leader>z :w !diff % -<CR>

" reload config
nmap <Leader>u :so $DOTDIR/vimrc<CR>

" toggle color column
nmap <Leader>i :let &l:cc=(empty(&l:cc) ? '80' : '')<CR>

" search in files
nmap <Leader>o :vim // *<Left><Left><Left>

" navigate quickfix list
nmap <Leader><Leader> :cc<CR>
nmap <Leader>j :cn<CR>
nmap <Leader>k :cp<CR>

" show line numbers
nmap <Leader>l :setl number! relativenumber!<CR>

" LLM completion
nmap <Leader>n :Complete<CR>

" git
nmap <Leader>w :echo b:gitsigns[line('.')]<CR>
nmap <Leader>e :call GitSigns()<CR>
nmap <Leader>a :echo system("git commit -a -m ''")<Left><Left><Left>
nmap <Leader>s :silent !tig status<CR><C-l>
nmap <Leader>d :silent !tig<CR><C-l>
nmap <Leader>f :!git pull --ff-only<CR>
nmap <Leader>c :echo system("git commit -m ''")<Left><Left><Left>
nmap <Leader>v :!git push<CR>

" --- netrw ---

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

" --- colors ---

highlight LineNr ctermfg=darkgray
highlight Comment ctermfg=darkgray
highlight ColorColumn ctermbg=darkgray
highlight SignColumn ctermbg=NONE

" --- terminal ---

command! Term let n = bufnr() | exec 'bel ter' | call setbufvar(n, "tb", bufnr())
command! VTerm let n = bufnr() | exec 'vert ter' | call setbufvar(n, "tb", bufnr())

" --- formatting ---

augroup noro
  autocmd!
  autocmd FileType * setlocal formatoptions-=ro
augroup END

" --- tabline ---

function! Tabline()
  let line = ''
  for i in range(tabpagenr('$'))
    let n = i + 1
    let hl = n == tabpagenr() ? 'TabLineSel' : 'TabLine'
    let cwd = fnamemodify(getcwd(1, n), ':~')
    let line ..= '%#' .. hl .. '#%' .. n .. 'T ' .. n .. ':' .. cwd .. ' '
  endfor
  let line ..= '%#TabLineFill#'
  return line
endfunction

set tabline=%!Tabline()

" --- git ---

highlight GitDelete ctermfg=red
highlight GitAdd ctermfg=green
highlight GitChange ctermfg=yellow

sign define sdel text=_ texthl=GitDelete
sign define sadd text=+ texthl=GitAdd
sign define smod text=| texthl=GitChange

function! GitSigns() abort

  let bufnr = bufnr()
  exe 'sign unplace * buffer=' . bufnr

  let diff_lines = systemlist('git diff --unified=0 HEAD -- ' . expand('%'))
  if v:shell_error
    echo 'Not a git file.'
    return
  endif

  let quick = []
  let b:gitsigns = repeat([""], line('$'))

  for i in range(len(diff_lines))

    let diff_line = diff_lines[i]
    " Hunk header: @@ -old_start[,old_count] +new_start[,new_count] @@
    let m = matchlist(diff_line, '^@@ -\(\d\+\),\?\(\d*\) +\(\d\+\),\?\(\d*\) @@')
    if empty(m)
      continue
    endif
    let old_count = m[2] ==# '' ? 1 : str2nr(m[2])
    let new_start = str2nr(m[3])
    let new_count = m[4] ==# '' ? 1 : str2nr(m[4])

    if old_count == 0
      let msg = 'added ' .. new_count .. ' lines'
      for l in range(new_start, new_start + new_count - 1)
        exe 'sign place ' .. l .. ' name=sadd line=' .. l .. ' buffer=' .. bufnr
      endfor
    elseif new_count == 0
      let msg = 'removed ' .. old_count .. ' lines'
      let l = new_start > 0 ? new_start : 1
      exe 'sign place ' .. l .. ' name=sdel line=' .. l .. ' buffer=' .. bufnr
      let b:gitsigns[l] = join(diff_lines[i + 1:i + old_count], "\n")
    else
      let msg = 'changed ' .. new_count .. ' lines'
      for j in range(1, new_count)
        let l = new_start + j - 1
        exe 'sign place ' .. l .. ' name=smod line=' .. l .. ' buffer=' .. bufnr
        let b:gitsigns[l] = diff_lines[i + j][1:]
      endfor
    endif

    let quick += [{'bufnr': bufnr, 'lnum': new_start, 'text': msg}]

  endfor

  call setqflist(quick, 'r')

endfunction

" --- python ---

command! AP %!autopep8 -

augroup py
  autocmd!
  autocmd FileType python compiler pylint
augroup END

" --- ollama ---

function! Complete() abort
  let first = 0
  let row = line('.')
  let last = line('$')

  if last > 500
    let last = row + 100
    " TODO increase first?
  endif
  
  let pre_lines = getline(first, row)
  let post_lines = getline(row + 1, last)

  let prefix = join(pre_lines, "\n")
  let suffix = join(post_lines, "\n")

  let request = {'model': 'codestral', 'prompt': prefix, 'suffix': suffix, 'stream': v:false}
  let request.options = {'temperature': 0, 'num_ctx': 8192, 'num_predict': 64}

  let cmd = "curl -s -X POST http://localhost:11434/api/generate"
  let cmd .= " -H Content-Type: application/json"
  let cmd .= " -d '" .. json_encode(request) .. "'"

  let output = system(cmd)

  let response = json_decode(output)
  let g:llmres = response

  let gen_lines = split(response.response, "\n")
  call setline(row, pre_lines[-1] .. gen_lines[0])
  if len(gen_lines) > 1
    call append(row, gen_lines[1:])
  endif
endfunction

command! Complete call Complete()

" --- neovim ---

if has('nvim')

  " fix tabline highlighting
  hi TabLineSel ctermfg=yellow

  lua vim.lsp.config('*', {root_markers = {'README.md', '.git'}})
  lua vim.lsp.config('ty', {cmd = {'ty', 'server'}, filetypes = {'python'}, root_markers = {'pyproject.toml', 'setup.py'}})
  command! Ty lua vim.lsp.enable('ty')

endif

