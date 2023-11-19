return {
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    opts = {
      window = {
        width = 0.70, -- width will be 70% of the editor width
      },
    },
    config = true,
    keys = {
      -- add <leader>cz to enter zen mode
      {
        "<leader>cz",
        "<cmd>ZenMode<cr>",
        desc = "Distraction Free Mode",
      },
    },
  },
}
