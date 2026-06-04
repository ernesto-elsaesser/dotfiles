
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
  let cmd .= " -d '" . json_encode(request) . "'"

  let output = system(cmd)

  let response = json_decode(output)
  let g:llmres = response

  let gen_lines = split(response.response, "\n")
  call setline(row, pre_lines[-1] . gen_lines[0])
  if len(gen_lines) > 1
    call append(row, gen_lines[1:])
  endif

endfunction

