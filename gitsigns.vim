
highlight SignColumn ctermbg=NONE

sign define sdel text=_ texthl=Special
sign define sadd text=+ texthl=Type
sign define smod text=| texthl=PreProc

function! GitSigns() abort

  let bufnr = bufnr()
  exe 'sign unplace * buffer=' . bufnr

  let diff_lines = systemlist('git diff --unified=0 HEAD -- ' . expand('%'))
  if v:shell_error
    echo 'Not a git file.'
    return
  endif

  let quick = []
  let b:diff = repeat([""], line('$'))

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
      let msg = 'added ' . new_count . ' lines'
      for l in range(new_start, new_start + new_count - 1)
        exe 'sign place ' . l . ' name=sadd line=' . l . ' buffer=' . bufnr
      endfor
    elseif new_count == 0
      let msg = 'removed ' . old_count . ' lines'
      let l = new_start > 0 ? new_start : 1
      exe 'sign place ' . l . ' name=sdel line=' . l . ' buffer=' . bufnr
      let b:diff[l] = join(diff_lines[i + 1:i + old_count], "\n")
    else
      let msg = 'changed ' . new_count . ' lines'
      for j in range(1, new_count)
        let l = new_start + j - 1
        exe 'sign place ' . l . ' name=smod line=' . l . ' buffer=' . bufnr
        let b:diff[l] = diff_lines[i + j][1:]
      endfor
    endif

    let quick += [{'bufnr': bufnr, 'lnum': new_start, 'text': msg}]

  endfor

  call setqflist(quick, 'r')

endfunction

