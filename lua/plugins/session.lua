return {
  {
    "olimorris/persisted.nvim",
    cmd = { "SessionDelete", "SessionSave" },
    keys = {
      -- add <leader>fs to find session
      {
        "<leader>fs",
        "<cmd>Telescope persisted<cr>",
        desc = "Telescope persisted",
      },
    },
    opts = {
      use_git_branch = true,
      save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- Resolves to ~/.local/share/nvim/my-sessions/
      ignored_dirs = {
        "~/Projects/research/",
        "~/.local/nvim",
      },
    },
    config = function(_, options)
      require("persisted").setup(options)
      require("telescope").load_extension("persisted")
    end,
  },
}
