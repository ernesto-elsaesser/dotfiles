local function get_llm_completion()
  local client = vim.lsp.get_clients({ name = "llm-ls", bufnr = 0 })[1]
  if client == nil then return end

  local params = vim.lsp.util.make_position_params()
  params.backend = "ollama"
  params.url = "http://192.168.178.25:11434"
  params.model = "gemma4-ctx8k"
  params.requestBody = { temperature = 0, max_new_tokens = 50 }
  params.tokensToClear = { "<|endoftext|>" }
  params.fim = {
    enabled = false,
    prefix = "",
    middle = "",
    suffix = "",
  }
  params.contextWindow = 8192
  params.ide = "neovim"
  params.disableUrlPathCompletion = false
  params.tlsSkipVerifyInsecure = true

  client.request("llm-ls/getCompletions", params, function(err, response)
    if err then
      print(err)
      return
    end
    if not response then
      print("NO RESPONSE")
      return
    end
    if #response == 0 then
      print("EMPTY RESPONSE")
      return
    end
    local text = response[1].generated_text
    if not text then
      print("NO TEXT")
      return
    end
    if text ~= "" then
      print("EMPTY TEXT")
      return
    end
    print(text)
    -- local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    -- vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, vim.split(text, "\n", { plain = true }))
  end, 0)
end

vim.api.nvim_create_user_command('Complete', get_llm_completion, {})
