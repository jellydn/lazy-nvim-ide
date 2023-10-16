return {
  {
    "dmmulroy/tsc.nvim",
    cmd = "TSC",
    opts = {
      flags = {
        build = true, -- support monorepos
      },
    },
    keys = {
      {
        "<leader>ck",
        "<cmd>TSC<cr>",
        desc = "Run Type Check",
      },
    },
  },
}
