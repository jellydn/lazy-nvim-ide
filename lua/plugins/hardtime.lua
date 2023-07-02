return {
  {
    "m4xshen/hardtime.nvim",
    opts = {
      -- default values is disabled the arrow keys
      disabled_keys = {},
      -- allow use jk to escape
      restricted_keys = {
        ["h"] = { "n", "v" },
        ["l"] = { "n", "v" },
        ["-"] = { "n", "v" },
        ["+"] = { "n", "v" },
        ["gj"] = { "n", "v" },
        ["gk"] = { "n", "v" },
        ["<CR>"] = { "n", "v" },
        ["<C-M>"] = { "n", "v" },
        ["<C-N>"] = { "n", "v" },
        ["<C-P>"] = { "n", "v" },
      },
    },
  },
}
