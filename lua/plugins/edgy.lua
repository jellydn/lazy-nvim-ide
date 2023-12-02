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
        { ft = "spectre_panel", size = { width = 0.3 } },
        { ft = "undotree", title = "UndoTree" },
      },
      right = {
        { title = "Neotest Summary", ft = "neotest-summary" },
        {
          ft = "Outline",
          open = "SymbolsOutlineOpen",
        },
        { title = "hurl.nvim", ft = "hurl-nvim", size = { 0.4 } },
        "aerial",
        "lspsagaoutline",
      },
    },
  },
}
