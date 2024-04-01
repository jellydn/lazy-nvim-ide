-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local Util = require("lazyvim.util")
local Diagnostics = require("utils.diagnostics")
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

local Lsp = require("utils.lsp")
local Cmd = require("utils.cmd")

-- Create command to stop LSP client
Cmd.create_cmd("StopLspClient", function()
  -- List all active clients
  local clients = vim.lsp.get_active_clients()
  local items = {}
  for _, client in ipairs(clients) do
    table.insert(items, client.name)
  end

  -- Show list of clients with ui select
  vim.ui.select(items, {
    prompt = "Select LSP client to stop",
  }, function(choice)
    if choice ~= nil then
      Lsp.stop_lsp_client_by_name(choice)
    end
  end)
end, { nargs = 0 })

-- Refer [FAQ - Neovide](https://neovide.dev/faq.html#how-can-i-use-cmd-ccmd-v-to-copy-and-paste)
if vim.g.neovide then
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set({ "n", "v" }, "<D-v>", '"+P') -- Paste normal and visual mode
  vim.keymap.set({ "i", "c" }, "<D-v>", "<C-R>+") -- Paste insert and command mode
  vim.keymap.set("t", "<D-v>", [[<C-\><C-N>"+P]]) -- Paste terminal mode  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
end

-- Disable `q` for macro recording as default
-- Set initial state for 'q'
vim.g.q_record_macro = false

-- Function to toggle 'q' functionality
function _G.toggle_q_macro()
  if vim.g.q_record_macro then
    -- If currently set for recording macros, make 'q' do nothing
    keymap("n", "q", "<Nop>", { noremap = true })
    vim.g.q_record_macro = false
  else
    -- If currently set to do nothing, make 'q' record macros
    keymap("n", "q", "q", { noremap = true })
    vim.g.q_record_macro = true
  end
end

keymap(
  "n",
  "<leader>uq",
  "<cmd>lua _G.toggle_q_macro()<CR>",
  { noremap = true, silent = true, desc = "Toggle 'q' Functionality" }
)
keymap("n", "q", "<Nop>", { noremap = true })

keymap("n", "<leader>uD", function()
  Diagnostics.toggle_diagnostics_level()
end, { noremap = true, silent = true, desc = "Toggle Diagnostics Level" })

local function open_dashboard()
  if Util.has("alpha-nvim") then
    require("alpha").start(true)
  elseif Util.has("dashboard-nvim") then
    vim.cmd("Dashboard")
  end
end

-- Dashboard
-- Add keymap to open alpha dashboard
keymap("n", "<leader>;", function()
  -- close all open buffers before open dashboard
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    ---@diagnostic disable-next-line: redundant-parameter
    local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
    if buftype ~= "terminal" then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end

  open_dashboard()
end, opts)

-- Close buffers
if Util.has("mini.bufremove") then
  keymap("n", "<S-q>", function()
    require("mini.bufremove").delete(0, false)
    local bufs = vim.fn.getbufinfo({ buflisted = true })
    -- open alpha if no buffers are left
    if bufs ~= nil and not bufs[2] and Util.has("alpha-nvim") then
      open_dashboard()
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

-- Select all text in buffer with Alt-a
keymap("n", "<A-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Easier access to beginning and end of lines
keymap("n", "<A-h>", "^", {
  desc = "Go to start of line",
  silent = true,
})
keymap("n", "<A-l>", "$", {
  desc = "Go to end of line",
  silent = true,
})

-- Move live up or down
-- moving
keymap("n", "<A-Down>", ":m .+1<CR>", opts)
keymap("n", "<A-Up>", ":m .-2<CR>", opts)
keymap("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts)
keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)

-- Show Lsp info
keymap("n", "<leader>cl", "<cmd>LspInfo<CR>", opts)

-- Gitsigns
-- Add toggle gitsigns blame line
if Util.has("gitsigns.nvim") then
  keymap("n", "<leader>ub", "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>", {
    desc = "Toggle current line blame",
  })
end

-- Fix Spell checking
keymap("n", "z0", "1z=", {
  desc = "Fix world under cursor",
})

-- Lazy Format Info
keymap("n", "<leader>fI", "<cmd>LazyFormatInfo<CR>", {
  desc = "Lazy Format Info",
})

keymap(
  "n",
  "<leader>cs",
  "<cmd>lua require('utils.cspell').add_word_to_c_spell_dictionary()<CR>",
  { noremap = true, silent = true, desc = "Add unknown to cspell dictionary" }
)

-- Disable lazyterm keymaps, use toggleterm keymaps instead
vim.api.nvim_del_keymap("n", "<leader>ft")
vim.api.nvim_del_keymap("n", "<leader>fT")
