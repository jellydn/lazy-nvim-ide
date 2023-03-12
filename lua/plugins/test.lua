return {
  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestFile" },
    keys = {
      { "<leader>ct", "<cmd>TestNearest<cr>", desc = "Run Test Nearest" },
      { "<leader>cT", "<cmd>TestFile<cr>", desc = "Run Test File" },
    },
    config = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "vertical"
    end,
  },
}
