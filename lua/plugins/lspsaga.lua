return {
  {
    "glepnir/lspsaga.nvim",
    event = "VeryLazy",
    config = function()
      require("lspsaga").setup({})

      -- when you use action in finder like open vsplit then you can
      -- use <C-t> to jump back
      vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
    end,
  },
}
