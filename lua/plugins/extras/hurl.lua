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
      { "<leader>tA", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
      { "<leader>ta", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
      { "<leader>te", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
      { "<leader>tm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
      { "<leader>tv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
      -- Run Hurl request in visual mode
      { "<leader>h", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
    },
  },
}
