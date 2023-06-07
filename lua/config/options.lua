-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- UFO folding
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Enable spell check by default
vim.o.spell = true

-- Persist undo, refer https://github.com/mbbill/undotree#usage
local undodir = vim.fn.expand("~/.undo-nvim")

if vim.fn.has("persistent_undo") == 1 then
  if vim.fn.isdirectory(undodir) == 0 then
    os.execute("mkdir -p " .. undodir)
  end

  vim.opt.undodir = undodir
  vim.opt.undofile = true
end
