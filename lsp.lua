# general
vim.lsp.config('*', {root_markers = {'README.md', '.git'}})

# python
vim.lsp.config('ty', {
  cmd = {'ty', 'server'},
  filetypes = {'python'},
  root_markers = {'pyproject.toml', 'setup.py'},
})

vim.api.nvim_create_user_command('Ty', function()
  vim.lsp.enable('ty')
end, {})

# dart
vim.lsp.config('dart', {
  cmd = {'dart', 'language-server'},
  filetypes = {'dart'},
  root_markers = {'pubspec.yaml'},
})

vim.api.nvim_create_user_command('Dart', function()
  vim.lsp.enable('dart')
end, {})

# llm-ls
vim.lsp.config('llm-ls', {
  cmd = {'llm-ls'},
  init_options = {
    backend = "ollama",
    url = "http://192.168.178.25:11434",
    model = "gemma4-ctx8k",
    request_body = {
      parameters = {
        max_new_tokens = 50,
        temperature = 0,
      },
    },
    context_window = 8192,
  },
})

vim.api.nvim_create_user_command('Ollama', function()
  vim.lsp.enable('llm-ls')
end, {})

