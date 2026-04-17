local ns_diags = vim.api.nvim_create_namespace('git_diag')
local ns_signs = vim.api.nvim_create_namespace('git_diag_signs')
local s = vim.diagnostic.severity

vim.diagnostic.config({
  virtual_text = false,
  underline    = false,
  signs        = false,
}, ns_diags)

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
  vim.diagnostic.reset(ns_diags, bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, ns_signs, 0, -1)

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

      local lnum = new_start - 1
      local end_lnum = new_start + new_count - 2

      if old_count == 0 then
        -- pure addition: no old code to show
        table.insert(diags, {
          lnum     = lnum,
          end_lnum = end_lnum,
          col      = 0,
          severity = s.INFO,
          message  = 'added ' .. new_count .. ' line(s)',
          source   = 'git',
        })
        vim.api.nvim_buf_set_extmark(bufnr, ns_signs, lnum, 0, {
          end_row = end_lnum,
          sign_text = "┃",
          sign_hl_group = "Visual",
          -- hl_group = "Visual",
        })
      elseif new_count == 0 then
        -- pure deletion: anchor to surrounding line
        local anchor_lnum = math.max(new_start, 1)
        local diag_lnum   = anchor_lnum - 1
        table.insert(diags, {
          lnum     = diag_lnum,
          col      = 0,
          severity = s.ERROR,
          message  = old_lines(output, i),
          source   = 'git',
        })
      else
        -- change: spans all new lines
        table.insert(diags, {
          lnum     = lnum,
          end_lnum = end_lnum,
          col      = 0,
          severity = s.WARN,
          message  = old_lines(output, i),
          source   = 'git',
        })
        for j = lnum, end_lnum do
          --number_hl_group = 'GitDiagChange',
          vim.api.nvim_buf_set_extmark(bufnr, ns_signs, j, 0, {
            sign_text = "┃",
            sign_hl_group = "Visual",
          })
        end
      end
    end
  end

  vim.diagnostic.set(ns_diags, bufnr, diags)
end

vim.api.nvim_create_user_command('GitDiag', update, {})
