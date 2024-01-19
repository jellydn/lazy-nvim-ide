local IS_DEV = false

return {
  {
    "jellydn/typecheck.nvim",
    dir = IS_DEV and "~/Projects/research/typecheck.nvim" or nil,
    ft = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescriptreact" },
    opts = {
      debug = true,
    },
    keys = {
      {
        "<leader>ck",
        "<cmd>Typecheck<cr>",
        desc = "Run Type Check",
      },
    },
  },
}
