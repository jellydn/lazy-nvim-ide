return {
  {
    dir = "jellydn/hurl.nvim",
    ft = "hurl",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = { "HurlRun" },
    opts = {
      mode = "popup",
    },
    keys = {
      -- Run API request
      { "<leader>ra", "<cmd>HurlRun<CR>", desc = "Run API requests" },
      -- Run API request in visual mode
      { "<leader>cr", ":HurlRun<CR>", desc = "Run API request", mode = "v" },
    },
  },
}
