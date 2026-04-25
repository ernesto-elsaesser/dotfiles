-- General

vim.lsp.config('*', {root_markers = {'README.md', '.git'}})

-- Python
-- https://pypi.org/project/ty/

vim.lsp.config('ty', {
  cmd = {'ty', 'server'},
  filetypes = {'python'},
  root_markers = {'pyproject.toml', 'setup.py'},
})

vim.api.nvim_create_user_command('Ty', function()
  vim.lsp.enable('ty')
end, {})

-- Dart / Flutter
-- https://pub.dev/packages/lsp_server

vim.lsp.config('dart', {
  cmd = {'dart', 'language-server'},
  filetypes = {'dart'},
  root_markers = {'pubspec.yaml'},
})

vim.api.nvim_create_user_command('Dart', function()
  vim.lsp.enable('dart')
end, {})

-- Local LLM Completions
-- https://github.com/huggingface/llm-ls/releases

vim.lsp.config('llm-ls', {
  cmd = {'llm-ls'},
})

vim.api.nvim_create_user_command('Ollama', function()
  vim.lsp.enable('llm-ls')
end, {})

