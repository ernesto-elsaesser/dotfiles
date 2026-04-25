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

  client.request("llm-ls/getCompletions", params, function(err, result, context)
    if err then
      print(err)
      return
    end
    if not result then
      print("NO RESULT")
      return
    end
    vim.g.llmres = result
    local completions = result.completions
    local text = result.completions[1].generated_text
    local lines = vim.split(text, "\n", { plain = true })
    local row = params.position.line
    local col = params.position.character
    vim.api.nvim_buf_set_text(0, row, col + 1, row, col + 1, lines)
  end, 0)
end

vim.api.nvim_create_user_command('Complete', get_llm_completion, {})
