local M = {}

-- Set initial state for diagnostic level
vim.g.diagnostics_level = "all"

-- Function to toggle diagnostic level
function M.toggle_diagnostics_level()
  if vim.g.diagnostics_level == "all" then
    M.set_diagnostics_level("error")
  else
    M.set_diagnostics_level("all")
  end
end

--- Change diagnostic level
---@param level 'all' | 'error'
function M.set_diagnostics_level(level)
  vim.g.diagnostics_level = level
  vim.notify("Diagnostics level: " .. level, "info", { title = "Diagnostics" })
  if level == "error" then
    vim.diagnostic.config({
      severity_sort = true,
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = { severity = vim.diagnostic.severity.ERROR },
      virtual_text = {
        prefix = "●",
        spacing = 2,
        severity = vim.diagnostic.severity.ERROR,
      },
    })
  else
    vim.diagnostic.config({
      severity_sort = true,
      underline = true,
      signs = true,
      virtual_text = {
        prefix = "●",
        spacing = 2,
      },
    })
  end
end

return M
