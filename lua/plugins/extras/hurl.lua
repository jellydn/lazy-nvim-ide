local IS_DEV = false

return {
  {
    "jellydn/hurl.nvim",
    dir = IS_DEV and "~/Projects/research/hurl.nvim" or nil,
    ft = "hurl",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-treesitter/nvim-treesitter" },
    opts = {
      mode = "split",
      auto_close = false,
      debug = false,
      show_notification = false,
      formatters = {
        json = { "jq" },
        html = {
          "prettier",
          "--parser",
          "html",
        },
      },
    },
    keys = {
      -- Run API request
      { "<leader>rA", "<cmd>HurlRunner<CR>", desc = "Hurl - Run All requests" },
      { "<leader>ra", "<cmd>HurlRunnerAt<CR>", desc = "Hurl - Run Api request" },
      { "<leader>re", "<cmd>HurlRunnerToEntry<CR>", desc = "Hurl -Run Api request to entry" },
      { "<leader>th", "<cmd>HurlToggleMode<CR>", desc = "Hurl - Toggle Mode" },
      { "<leader>rv", "<cmd>HurlVerbose<CR>", desc = "Hurl - Run Api in verbose mode" },
      -- Run Hurl request in visual mode
      { "<leader>rh", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
      -- Show last response
      { "<leader>rh", "<cmd>HurlShowLastResponse<CR>", desc = "Hurl History", mode = "n" },
      -- Manage variable
      { "<leader>hg", ":HurlSetVariable", desc = "Hurl - Set global variable" },
      { "<leader>hG", "<cmd>HurlManageVariable<CR>", desc = "Hurl - Manage global variable" },
    },
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        title = "hurl.nvim",
        ft = "hurl-nvim",
        size = { width = 0.5 },
      })
    end,
  },
}
