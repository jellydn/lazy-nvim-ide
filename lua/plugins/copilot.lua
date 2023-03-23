return {
  -- copilot
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      -- For copilot.vim
      -- enable copilot for specific filetypes
      vim.g.copilot_filetypes = {
        ["TelescopePrompt"] = false,
      }

      -- disable tab completion if you want to use tab for something else
      -- let g:copilot_no_tab_map = v:true
      vim.cmd([[
        let g:copilot_assume_mapped = v:true
        let g:copilot_no_tab_map = v:true
        imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")
      ]])

      -- setup keymap
      local keymap = vim.keymap.set
      -- Silent keymap option
      local opts = { silent = true }

      -- imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")
      -- let g:copilot_no_tab_map = v:true

      -- Copilot
      keymap("i", "<C-j>", "<Plug>(copilot-next)", opts)
      keymap("i", "<C-k>", "<Plug>(copilot-previous)", opts)
      keymap("i", "<C-l>", "<Plug>(copilot-suggest)", opts)
    end,
  },
}
