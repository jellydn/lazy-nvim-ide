return {
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "http",
    keys = {
      -- require('rest-nvim').run()
      { "<leader>cR", "<cmd>lua require('rest-nvim').run()<CR>", desc = "Run API request" },
    },
    opts = {
      result = {
        formatters = {
          json = "jq",
          html = false,
        },
      },
    },
    config = function(_, options)
      require("rest-nvim").setup(options)
    end,
  },
}
