-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local Util = require("lazyvim.util")
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Dashboard
-- Add keymap to open alpha dashboard
keymap("n", "<leader>;", function()
  -- close all open buffers before open dashboard
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
    if buftype ~= "terminal" then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end

  if Util.has("alpha-nvim") then
    require("alpha").start(true)
  end
end, opts)

-- Close buffers
if Util.has("mini.bufremove") then
  keymap("n", "<S-q>", function()
    require("mini.bufremove").delete(0, false)
    local bufs = vim.fn.getbufinfo({ buflisted = true })
    -- open alpha if no buffers are left
    if not bufs[2] and Util.has("alpha-nvim") then
      require("alpha").start(true)
    end
  end, opts)
else
  keymap("n", "<S-q>", "<cmd>bd<CR>", opts)
end

-- Better paste
-- remap "p" in visual mode to delete the highlighted text without overwriting your yanked/copied text, and then paste the content from the unnamed register.
keymap("v", "p", '"_dP', opts)

-- Copy whole file content to clipboard with C-c
keymap("n", "<C-c>", ":%y+<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move live up or down
-- moving
keymap("n", "<A-Down>", ":m .+1<CR>", opts)
keymap("n", "<A-Up>", ":m .-2<CR>", opts)
keymap("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts)
keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)

-- LspSaga
if Util.has("lspsaga.nvim") then
  -- when you use action in finder like open vsplit then you can
  keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

  -- Code action
  keymap({ "n", "v" }, "gla", "<cmd>Lspsaga code_action<CR>")

  -- Rename all occurrences of the hovered word for the entire file
  keymap("n", "glr", "<cmd>Lspsaga rename<CR>")

  -- Rename all occurrences of the hovered word for the selected files
  keymap("n", "glR", "<cmd>Lspsaga rename ++project<CR>")

  -- Peek definition
  keymap("n", "gld", "<cmd>Lspsaga peek_definition<CR>")

  -- Diagnostic jump can use `<c-o>` to jump back
  keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
  keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

  -- Diagnostic jump with filters such as only jumping to an error
  keymap("n", "[E", function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end)
  keymap("n", "]E", function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
  end)

  -- Toggle Outline
  keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

  -- Callhierarchy
  keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
  keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
end

-- Trouble
-- Add keymap only show FIXME
if Util.has("todo-comments.nvim") then
  -- show fixme on telescope
  keymap("n", "<leader>xf", "<cmd>TodoTelescope keywords=FIX,FIXME<CR>")
end

-- Gitsigns
-- Add toggle gitsigns blame line
if Util.has("gitsigns.nvim") then
  keymap("n", "<leader>ub", "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>", {
    desc = "Toggle current line blame",
  })
end

-- Refactoring
if Util.has("refactoring.nvim") then
  -- remap to open the Telescope refactoring menu in visual mode
  keymap(
    "v",
    "<leader>rr",
    "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    { desc = "Refactors", noremap = true }
  )
end

-- Harpoon
if Util.has("harpoon") then
  keymap("n", "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", {
    desc = "Toggle Harpoon menu",
  })

  keymap("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", {
    desc = "Add file to Harpoon",
  })
end

-- Fix Spell checking
keymap("n", "z0", "1z=", {
  desc = "Fix world under cursor",
})
