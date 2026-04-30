vim.api.nvim_create_user_command("TermSplit", function(opts)
  local orig_buf = vim.api.nvim_get_current_buf()
  local term_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(term_buf, true, { split = opts.args })
  local job_id = vim.fn.termopen(vim.o.shell)
  vim.api.nvim_buf_set_var(orig_buf, "tjid", job_id)
end, { nargs = 1 })

vim.api.nvim_create_user_command("TermPaste", function(opts)
  local job_id = vim.api.nvim_buf_get_var(0, "term_job_id")
  local cmd = vim.fn.trim(vim.fn.getregister('"'))
  vim.fn.chansend(job_id, cmd .. "\n")
end, { nargs = 1 })

