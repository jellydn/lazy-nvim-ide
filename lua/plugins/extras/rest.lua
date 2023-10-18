return {
  {
    "ray-x/web-tools.nvim",
    ft = "hurl",
    cmd = { "HurlRun", "TagRename" },
    dependencies = {
      { "ray-x/guihua.lua", build = "cd lua/fzy && make", opts = { maps = {
        close_view = "q",
      } } },
    },
    opts = {
      -- debug = true,
      hurl = {
        floating = true,
        show_headers = false, -- Formatter does not work with well with headers
        formatters = { -- format the result by file type
          json = { "jq" },
          html = { "prettier", "--parser", "html" },
        },
      },
    },
    keys = {
      { "<leader>cRa", "<cmd>HurlRun<CR>", desc = "Run API requests" },
      { "<leader>cRt", "<cmd>TagRename<CR>", desc = "Rename HTML tag" },
      -- Run API request in visual mode
      { "<leader>cr", ":HurlRun<CR>", desc = "Run API request", mode = "v" },
    },
  },
}
