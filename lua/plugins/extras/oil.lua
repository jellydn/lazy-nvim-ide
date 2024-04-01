local function max_height()
  local height = vim.fn.winheight(0)
  if height >= 40 then
    return 30
  elseif height >= 30 then
    return 20
  else
    return 10
  end
end

return {
  -- Disable neo-tree and use oil.nvim instead, simple and fast
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "stevearc/oil.nvim",
    opts = {
      -- Set to false if you still want to use netrw.
      default_file_explorer = true,
      -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
      skip_confirm_for_simple_edits = true,
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = false,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name)
          local ignore_folders = { "node_modules", "dist", "build", "coverage" }
          return vim.startswith(name, ".") or vim.tbl_contains(ignore_folders, name)
        end,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        padding = 2,
        max_width = 120,
        max_height = max_height(),
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
      -- Custom Keymap
      keymaps = {
        ["<C-c>"] = false,
        ["<C-s>"] = "actions.save",
        ["q"] = "actions.close",
        ["<C-y>"] = "actions.copy_entry_path",
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
