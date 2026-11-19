let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

function! ListDir(path) abort

  call clearmatches()

  if !isdirectory(a:path)
    return
  endif

  exec 'lcd ' . fnameescape(a:path)
  setl bt=nofile nomod

  let l:ls = systemlist('ls -AF --group-directories-first')
  let l:lines = [getcwd(), ""] + l:ls

  let l:lnum = max([line("'\""), 3])
  1,$delete _
  call setline(1, l:lines)
  call setpos('.', [0, l:lnum, 1, 0])

  call matchaddpos('Underlined', [1])
  call matchadd('Comment', '^\..\+')  " hidden
  call matchadd('Identifier', '.\+@$')  " symlinks
  call matchadd('Statement', '.\+\.\(sh\|py\)\*\=$', 9)  " scripts

  nmap <buffer> - :e ..<CR>
  nmap <buffer> i :let @p = fnameescape(trim(getline('.'), '/*@'))<CR>
  nmap <buffer> <Space> i:dr <C-r>p<CR>
  nmap <buffer> s i:echo trim(system('ls -lh ' . @p))<CR>
  nmap <buffer> r i:!mv <C-r>p <C-r>p
  nmap <buffer> m i:!mv <C-r>p 
  nmap <buffer> c i:!cp <C-r>p 
  nmap <buffer> d :!mkdir 
  nmap <buffer> D i:!rm -rf <C-r>p
  au! ShellCmdPost <buffer> call ListDir(getcwd())

endfunction

augroup mynetrw
    autocmd!
    autocmd BufEnter * call ListDir(expand('%'))
augroup END

