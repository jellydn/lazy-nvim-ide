local IS_DEV = false

return {
  {
    "jellydn/quick-code-runner.nvim",
    dir = IS_DEV and "~/Projects/research/quick-code-runner.nvim" or nil,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      debug = false,
    },
    cmd = { "QuickCodeRunner", "QuickCodePad" },
    keys = {
      {
        "<leader>cr",
        ":QuickCodeRunner<CR>",
        desc = "Quick Code Runner",
        mode = { "v" },
      },
      {
        "<leader>cp",
        ":QuickCodePad<CR>",
        desc = "Quick Code Pad",
      },
    },
  },
}
