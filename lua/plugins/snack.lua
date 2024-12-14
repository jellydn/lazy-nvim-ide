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
  },
}
