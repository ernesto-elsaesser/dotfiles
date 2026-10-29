" comments

augroup noro
  autocmd!
  autocmd FileType * setlocal formatoptions-=ro
augroup END

" python

command! Format !uv run ruff format %

augroup py
  autocmd!
  autocmd FileType python setl makeprg=uv\ run\ ruff\ check\ --output-format\ concise\ % errorformat=%f:%l:%c:\ %m
augroup END

tmap Ö import pandas as pd<CR>

" dart

augroup dart
  autocmd!
  autocmd FileType dart setl makeprg=flutter\ build\ bundle
  autocmd FileType dart setl errorformat=lib/%f:%l:%c:\ Error:\ %m,%f:%l:%c:\ Warning:\ %m,%f:%l:%c:\ %m,%-G%.%#
augroup END

