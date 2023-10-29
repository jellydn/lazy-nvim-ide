return {
  {
    "jellydn/hurl.nvim",
    ft = "hurl",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = { "HurlRunner" },
    opts = {
      mode = "split",
    },
    keys = {
      -- Run API request
      { "<leader>ra", "<cmd>HurlRunner<CR>", desc = "Run API requests" },
      -- Run API request in visual mode
      { "<leader>cr", ":HurlRunner<CR>", desc = "Run API request", mode = "v" },
    },
  },
}
