function! TermSend(msg) abort
  let l:bufnums = tabpagebuflist()
  let l:termnums = filter(l:bufnums, 'bufname(v:val)[0] == "!"')
  if len(l:termnums) > 0
    call term_sendkeys(l:termnums[0], a:msg)
  else
    echo 'no terminal'
  endif
endfunction

" open terminal
nmap ü :rightb vert ter<CR>
nmap Ü :bel ter<CR>

" send to terminal
nmap ä :call TermSend("\x10\r")<CR>
nmap Ä :call TermSend(getreg('"'))<CR>
nmap ö yy:call TermSend(getreg('"'))<CR><CR>
nmap Ö yy:call TermSend(trim(getreg('"'), ' '))<CR><CR>

