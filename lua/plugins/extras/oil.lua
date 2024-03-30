return {
  -- Disable neo-tree and use oil.nvim instead, simple and fast
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "stevearc/oil.nvim",
    opts = {
      -- Set to false if you still want to use netrw.
      default_file_explorer = true,
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = false,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name)
          local ignore_folders = { "node_modules", "dist", "build" }
          return vim.startswith(name, ".") or vim.tbl_contains(ignore_folders, name)
        end,
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- Use g? to see default key mappings
    keys = {
      {
        "<leader>e",
        function()
          require("oil").toggle_float()
        end,
        desc = "Open file explorer",
      },
    },
  },
}
