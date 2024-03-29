return {
  {
    "olimorris/persisted.nvim",
    cmd = { "SessionDelete", "SessionSave" },
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

      local tele_status_ok, telescope = pcall(require, "telescope")
      if not tele_status_ok then
        return
      end
      telescope.load_extension("persisted")
    end,
  },
}
