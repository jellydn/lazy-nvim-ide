-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local Util = require("lazyvim.util")
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

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

-- Set initial state for diagnostic level
vim.g.diagnostics_level = "all"

-- Function to toggle diagnostic level
function _G.toggle_diagnostics_level()
  if vim.g.diagnostics_level == "all" then
    vim.notify("Diagnostics level: error", "info", { title = "Diagnostics" })
    vim.g.diagnostics_level = "error"
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
    vim.notify("Diagnostics level: all", "info", { title = "Diagnostics" })
    vim.g.diagnostics_level = "all"
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

keymap(
  "n",
  "<leader>uD",
  "<cmd>lua toggle_diagnostics_level()<CR>",
  { noremap = true, silent = true, desc = "Toggle Diagnostics Level" }
)

local function open_dashboard()
  if Util.has("alpha-nvim") then
    require("alpha").start(true)
  elseif Util.has("dashboard-nvim") then
    -- TODO: Will do this when Dashboard plugin support this feature
    vim.notify("Dashboard plugin does not support this feature yet", "warn", { title = "Dashboard" })
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

-- Show references on telescope
if Util.has("telescope.nvim") then
  keymap("n", "gr", "<cmd>Telescope lsp_references<CR>")
end

-- LspSaga
if Util.has("lspsaga.nvim") then
  -- Diagnostic jump with filters such as only jumping to an error
  keymap("n", "[E", function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end)
  keymap("n", "]E", function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
  end)
end

-- Trouble
-- Add keymap only show FIXME
if Util.has("todo-comments.nvim") then
  -- show fixme on telescope
  keymap("n", "<leader>xf", "<cmd>TodoTelescope keywords=FIX,FIXME<CR>", {
    desc = "Show FIXME",
  })
end

-- Gitsigns
-- Add toggle gitsigns blame line
if Util.has("gitsigns.nvim") then
  keymap("n", "<leader>ub", "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>", {
    desc = "Toggle current line blame",
  })
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

-- Lazy Format Info
keymap("n", "<leader>fI", "<cmd>LazyFormatInfo<CR>", {
  desc = "Lazy Format Info",
})
