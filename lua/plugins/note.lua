return {
  {
    "jellydn/my-note.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      {
        "<leader>n",
        "<cmd>MyNote<cr>",
        desc = "Open note",
      },
      {
        "<leader>ng",
        "<cmd>MyNote global<cr>",
        desc = "Open note",
      },
    },
    opts = {
      files = {
        -- Using the parent .git folder as the cwd
        cwd = function()
          local bufPath = vim.api.nvim_buf_get_name(0)
          local cwd = require("lspconfig").util.root_pattern(".git")(bufPath)

          return cwd
        end,
      },
    },
  },
}
