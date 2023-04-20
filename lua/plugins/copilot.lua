return {
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      -- For copilot.vim
      -- enable copilot for specific filetypes
      vim.g.copilot_filetypes = {
        ["TelescopePrompt"] = false,
      }

      vim.cmd([[
        let g:copilot_assume_mapped = v:true
      ]])

      -- setup keymap
      local keymap = vim.keymap.set
      -- Silent keymap option
      local opts = { silent = true }

      -- Copilot
      keymap("i", "<C-j>", "<Plug>(copilot-next)", opts)
      keymap("i", "<C-k>", "<Plug>(copilot-previous)", opts)
      keymap("i", "<C-l>", "<Plug>(copilot-suggest)", opts)
    end,
  },
}
