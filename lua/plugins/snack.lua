return {
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      dashboard = { enabled = false },
      zen = {
        enabled = true,
        win = {
          -- Hide backdrop
          backdrop = { transparent = false },
        },
        toggles = {
          -- Turn off dim plugin for zen mode
          dim = false,
        },
      },
    },
    keys = {
      -- Zen mode
      {
        "<leader>cz",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
    },
  },
}
