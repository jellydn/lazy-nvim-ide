return {
  {
    "m4xshen/hardtime.nvim",
    opts = {
      -- default values is disabled the arrow keys
      disabled_keys = {},
      -- allow use jk to escape
      restricted_keys = {
        ["h"] = { "n", "x" },
        ["l"] = { "n", "x" },
        ["-"] = { "n", "x" },
        ["+"] = { "n", "x" },
        ["<CR>"] = { "n", "x" },
        ["<C-M>"] = { "n", "x" },
        ["<C-N>"] = { "n", "x" },
        ["<C-P>"] = { "n", "x" },
      },
    },
  },
}
