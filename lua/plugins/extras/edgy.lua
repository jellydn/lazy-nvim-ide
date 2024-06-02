return {
  { import = "lazyvim.plugins.extras.ui.edgy" },
  {
    "folke/edgy.nvim",
    opts = {
      wo = {
        spell = false,
      },
      animate = {
        enabled = false,
      },
      left = {
        "neo-tree",
        { title = "Spectre", ft = "spectre", size = { width = 0.3 } },
        { title = "UndoTree", ft = "undotree" },
      },
      right = {
        { title = "Neotest Summary", ft = "neotest-summary" },
      },
    },
  },
}
