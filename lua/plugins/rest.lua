return {
  {
    -- Run "brew install hurl" if you want to use this
    "pfeiferj/nvim-hurl",
    cmd = "Hurl",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    keys = {
      { "<leader>cR", "<cmd>Hurl<CR>", desc = "Run API request" },
    },
  },
}
