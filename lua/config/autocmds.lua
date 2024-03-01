-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
local function augroup(name)
  return vim.api.nvim_create_augroup("my_lazyvim_" .. name, { clear = true })
end

-- Set filetype for .env and .env.* files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("env_filetype"),
  pattern = { "*.env", ".env.*" },
  callback = function()
    vim.opt_local.filetype = "sh"
  end,
})

local is_stable_version = true
if vim.fn.has("nvim-0.10.0") == 1 then
  is_stable_version = false
end

if is_stable_version then
  -- Set filetype for .hurl files
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("env_filetype"),
    pattern = { "*.hurl" },
    callback = function()
      vim.opt_local.filetype = "sh"
    end,
  })
end
