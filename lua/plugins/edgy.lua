return {
  {
    "folke/edgy.nvim",
    keys = {
      {
        "<leader>uE",
        function()
          require("edgy").select()
        end,
        desc = "Edgy Select Window",
      },
      {
        "<leader>ue",
        function()
          require("edgy").toggle()
        end,
        desc = "Edgy Toggle",
      },
    },
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
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
        { ft = "spectre_panel", size = { width = 0.3 } },
        { ft = "undotree", title = "UndoTree" },
      },
      right = {
        { title = "Neotest Summary", ft = "neotest-summary" },
        {
          ft = "Outline",
          open = "SymbolsOutlineOpen",
        },
        "aerial",
        "lspsagaoutline",
      },
    },
  },
}
