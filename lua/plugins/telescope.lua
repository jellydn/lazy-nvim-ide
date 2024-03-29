local Path = require("utils.path")

--- Open selected file in vertical split
local function open_selected_file_in_vertical()
  local entry = require("telescope.actions.state").get_selected_entry()
  require("telescope.actions").close(entry)
  vim.cmd("vsplit " .. entry.path)
end

local function find_files_from_project_git_root()
  local opts = {}
  if Path.is_git_repo() then
    opts = {
      cwd = Path.get_git_root(),
    }
  end
  require("telescope.builtin").find_files(opts)
end

local function live_grep_from_project_git_root()
  local opts = {}

  if Path.is_git_repo() then
    opts = {
      cwd = Path.get_git_root(),
    }
  end

  require("telescope.builtin").live_grep(opts)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = "   ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        path_display = { "truncate" },
      },
    },
    keys = {
      -- add <leader>fa to find all, including hidden files
      {
        "<leader>fa",
        "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
        desc = "Find All Files (including hidden)",
      },
      -- add <leader>fl to live grep from git root
      {
        "<leader>fl",
        function()
          live_grep_from_project_git_root()
        end,
        desc = "Live Grep From Project Git Root",
      },
      -- add <leader>fg to find files from project git root
      {
        "<leader>fg",
        function()
          find_files_from_project_git_root()
        end,
        desc = "Find Files From Project Git Root",
      },
    },
    mapping = {
      i = {
        ["C-v"] = open_selected_file_in_vertical,
      },
    },
  },
}
