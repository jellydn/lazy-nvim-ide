return {
  -- Disable persistence.nvim, use persisted.nvim instead
  {
    "folke/persistence.nvim",
    enabled = false,
  },
  {
    "olimorris/persisted.nvim",
    lazy = false, -- make sure the plugin is always loaded at startup
    opts = {
      save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/persisted-session/"), -- Resolves to ~/.local/share/nvim/persisted-sessions/
      use_git_branch = true,
      silent = true,
      should_autosave = function()
        -- Ignore certain filetypes from autosaving
        local excluded_filetypes = {
          "alpha",
          "oil",
          "lazy",
          "toggleterm",
          "",
        }

        for _, filetype in ipairs(excluded_filetypes) do
          if vim.bo.filetype == filetype then
            return false
          end
        end

        return true
      end,
    },
    config = function(_, options)
      require("persisted").setup(options)

      local ok, telescope = pcall(require, "telescope")
      if not ok then
        return
      end
      telescope.load_extension("persisted")
    end,
  },
}
