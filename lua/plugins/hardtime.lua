return {
  {
    "m4xshen/hardtime.nvim",
    opts = {
      -- default values is disabled the arrow keys
      disabled_keys = {},
    },
    keys = {
      -- disable hardtime by default, only Enable it when I need it
      {
        "<leader>ht",
        "<cmd>Hardtime toggle<cr>",
        desc = "Toggle hardtime.nvim",
      },
    },
  },
}
