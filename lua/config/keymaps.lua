-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Copilot
keymap("i", "<C-j>", "<Plug>(copilot-next)", opts)
keymap("i", "<C-k>", "<Plug>(copilot-previous)", opts)
keymap("i", "<C-l>", "<Plug>(copilot-suggest)", opts)
keymap("i", "<C-a>", "<Plug>(copilot-accept)", opts)
