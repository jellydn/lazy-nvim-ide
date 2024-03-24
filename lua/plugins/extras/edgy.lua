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
      bottom = {
        {
          ft = "lazyterm",
          title = "LazyTerm",
          size = { height = 0.4 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
        "Trouble",
        { ft = "qf", title = "QuickFix" },
        {
          ft = "help",
          size = { height = 20 },
          -- only show help buffers
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
      },
      left = {
        "neo-tree",
        { title = "Spectre", ft = "spectre_panel", size = { width = 0.3 } },
        { title = "UndoTree", ft = "undotree" },
      },
      right = {
        {
          title = "CopilotChat.nvim",
          ft = "copilot-chat",
          size = { width = 0.5 },
          -- exclude floating windows
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        { title = "Neotest Summary", ft = "neotest-summary" },
        {
          ft = "Outline",
          open = "SymbolsOutlineOpen",
        },
        { title = "hurl.nvim", ft = "hurl-nvim", size = { width = 0.4 } },
        "aerial",
        "lspsagaoutline",
      },
    },
  },
}
