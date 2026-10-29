highlight TabLineSel ctermfg=cyan

function! Tabline()
  let line = ''
  for i in range(tabpagenr('$'))
    let n = i + 1
    let hl = n == tabpagenr() ? 'TabLineSel' : 'TabLine'
    let cwd = fnamemodify(getcwd(1, n), ':~')
    let line .= '%#' . hl . '#%' . n . 'T ' . n . ':' . cwd . ' |'
  endfor
  let line .= '%#TabLineFill#'
  return line
endfunction

set tabline=%!Tabline()

