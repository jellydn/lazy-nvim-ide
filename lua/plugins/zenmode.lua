return {
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    config = true,
    keys = {
      -- add <leader>cz to enter zen mode
      {
        "<leader>cz",
        "<cmd>ZenMode<cr>",
        desc = "Zen Mode",
      },
    },
  },
}
