return {
  {
    "dmmulroy/tsc.nvim",
    opts = {
      auto_open_qflist = true,
      auto_close_qflist = false,
      enable_progress_notifications = false,
      -- support monorepo
      flags = {
        build = true,
      },
    },
    keys = {
      { "<leader>ck", "<cmd>TSC<CR>", desc = "Check TypeScript error" },
    },
  },
}
