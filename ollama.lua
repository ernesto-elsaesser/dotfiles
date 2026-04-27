local function llm_fim()
  local cursor = vim.api.nvim_win_get_cursor(0) -- {row, col}, row is 1-indexed
  local row = cursor[1]
  local col = cursor[2]

  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local start_row = 1
  local end_row = #lines
  if end_row > 500 then
    end_row = row + 100
    -- TODO increase start_row?
  end

  -- Split at cursor: prefix = everything up to cursor, suffix = everything after
  local prefix_lines = vim.list_slice(lines, start_row, row)
  prefix_lines[#prefix_lines] = string.sub(prefix_lines[#prefix_lines], 1, col)

  local suffix_lines = vim.list_slice(lines, row, end_row)
  suffix_lines[1] = string.sub(suffix_lines[1], col + 1)

  local prefix = table.concat(prefix_lines, "\n")
  local suffix = table.concat(suffix_lines, "\n")

  local body = vim.json.encode({
    model = "codestral",
    prompt = prefix,
    suffix = suffix,
    stream = false,
    options = {
      temperature = 0,
      num_ctx = 8192,
      num_predict = 24,
    },
  })

  vim.system(
    { "curl", "-s", "-X", "POST", "http://192.168.178.25:11434/api/generate",
      "-H", "Content-Type: application/json",
      "-d", body },
    { text = true },
    function(result)
      vim.schedule(function()
        if result.code ~= 0 then
          vim.notify("curl failed: " .. (result.stderr or ""), vim.log.levels.ERROR)
          return
        end

        local ok, decoded = pcall(vim.json.decode, result.stdout)
        if not ok or not decoded.response then
          vim.notify("Bad response: " .. result.stdout, vim.log.levels.ERROR)
          return
        end

        vim.g.llmres = decoded.response
        local insert_lines = vim.split(decoded.response, "\n", { plain = true })
        local insert_lines = { insert_lines[1] }
        vim.api.nvim_buf_set_text(buf, row - 1, col, row - 1, col, insert_lines)
      end)
    end
  )
end

vim.api.nvim_create_user_command('Complete', llm_fim, {})
