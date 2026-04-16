local ns = vim.api.nvim_create_namespace('git_diag')
local s  = vim.diagnostic.severity

vim.diagnostic.config({
  virtual_text = false,
  underline    = false,
  signs        = {
    text = { [s.ERROR] = '_', [s.WARN] = '~', [s.INFO] = '+' },
  },
}, ns)

-- Collect removed lines (starting with '-') from output starting at index i.
local function old_lines(output, i)
  local lines = {}
  for j = i + 1, #output do
    local ch = output[j]:sub(1, 1)
    if ch == '-' then
      table.insert(lines, output[j]:sub(2))
    elseif ch ~= '\\' then
      break
    end
  end
  return table.concat(lines, '\n')
end

local function update()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.diagnostic.reset(ns, bufnr)

  local path   = vim.api.nvim_buf_get_name(bufnr)
  local output = vim.fn.systemlist('git diff --unified=0 HEAD -- ' .. vim.fn.shellescape(path))
  if vim.v.shell_error ~= 0 then
    vim.notify('Not a git file.', vim.log.levels.WARN)
    return
  end

  local diags = {}

  for i, line in ipairs(output) do
    -- Hunk header: @@ -old_start[,old_count] +new_start[,new_count] @@
    local old_cs, new_start_s, new_cs =
      line:match('^@@ %-%d+,?(%d*) %+(%d+),?(%d*) @@')
    if new_start_s then
      local old_count = old_cs ~= '' and tonumber(old_cs) or 1
      local new_start = tonumber(new_start_s)
      local new_count = new_cs ~= '' and tonumber(new_cs) or 1

      if old_count == 0 then
        -- pure addition: no old code to show
        table.insert(diags, {
          lnum     = new_start - 1,
          end_lnum = new_start + new_count - 2,
          col      = 0,
          severity = s.INFO,
          message  = 'added ' .. new_count .. ' line(s)',
          source   = 'git',
        })
      elseif new_count == 0 then
        -- pure deletion: anchor to surrounding line
        local lnum = math.max(new_start, 1)
        table.insert(diags, {
          lnum     = lnum - 1,
          col      = 0,
          severity = s.ERROR,
          message  = old_lines(output, i),
          source   = 'git',
        })
      else
        -- change: spans all new lines
        table.insert(diags, {
          lnum     = new_start - 1,
          end_lnum = new_start + new_count - 2,
          col      = 0,
          severity = s.WARN,
          message  = old_lines(output, i),
          source   = 'git',
        })
      end
    end
  end

  vim.diagnostic.set(ns, bufnr, diags)
end

vim.api.nvim_create_user_command('GitSigns', update, {})
