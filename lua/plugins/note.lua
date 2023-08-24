return {
  {
    "jellydn/my-note.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      {
        "<leader>mn",
        "<cmd>MyNote<cr>",
        desc = "Open MyNote",
      },
      {
        "<leader>mg",
        "<cmd>MyNote global<cr>",
        desc = "Open MyNote Global",
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
