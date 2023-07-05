return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = {
      {
        "<leader>r",
        ":lua require('refactoring').select_refactor()<CR>",
        mode = "v",
        noremap = true,
        silent = true,
        expr = false,
        desc = "Refactoring",
      },
    },
    opts = {},
  },
}
