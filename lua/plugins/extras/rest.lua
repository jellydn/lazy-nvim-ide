return {
  {
    "ray-x/web-tools.nvim",
    -- dependencies = { { "ray-x/guihua.lua", build = "cd lua/fzy && make" } },
    cmd = { "HurlRun", "TagRename" },
    opts = {
      hurl = { -- hurl default
        show_headers = false, -- do not show http headers
        floating = false, -- use floating windows (need guihua.lua)
        formatters = { -- format the result by filetype
          json = { "jq" },
          html = { "prettier", "--parser", "html" },
        },
      },
    },
    keys = {
      { "<leader>cRa", "<cmd>HurlRun<CR>", desc = "Run API request" },
      { "<leader>cRt", "<cmd>TagRename<CR>", desc = "Rename HTML tag" },
    },
  },
}
