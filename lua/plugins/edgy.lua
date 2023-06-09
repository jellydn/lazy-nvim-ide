return {
  {
    "folke/edgy.nvim",
    keys = {
      {
        "<leader>ue",
        function()
          require("edgy").select()
        end,
        desc = "Edgy Select Window",
      },
    },
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      bottom = {
        -- lazyterm
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
        { ft = "undotree", title = "UndoTree" },
      },
    },
  },
}
