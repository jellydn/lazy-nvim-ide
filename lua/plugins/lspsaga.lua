local keymap = vim.keymap.set

return {
  {
    "glepnir/lspsaga.nvim",
    event = "VeryLazy",
    config = function()
      require("lspsaga").setup({})

      -- when you use action in finder like open vsplit then you can
      -- use <C-t> to jump back
      keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

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
    end,
  },
}
