--- Live grep from project git root
local function live_grep_from_project_git_root()
  local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")

    return vim.v.shell_error == 0
  end

  local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
  end

  local opts = {}

  if is_git_repo() then
    opts = {
      cwd = get_git_root(),
    }
  end

  require("telescope.builtin").live_grep(opts)
end

--- Fallback to find_files if not in git repo
local function fallback_to_find_files_if_not_git()
  local opts = {} -- define here if you want to define something
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    require("telescope.builtin").git_files(opts)
  else
    require("telescope.builtin").find_files(opts)
  end
end

--- Open selected file in vertical split
local function open_selected_file_in_vertical()
  local entry = require("telescope.actions.state").get_selected_entry()
  require("telescope.actions").close(entry)
  vim.cmd("vsplit " .. entry.path)
end

return {
  {
    "telescope.nvim",
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
      -- add a keymap to browse plugin files
      {
        "<leader>fg",
        function()
          fallback_to_find_files_if_not_git()
        end,
        desc = "Find Git File",
      },
      -- find in file
      {
        "<leader>fw",
        function()
          live_grep_from_project_git_root()
        end,
        desc = "Live Grep in Project Root",
      },
      -- add gR to resume telescope
      {
        "gR",
        function()
          require("telescope.builtin").resume()
        end,
        desc = "Resume Last Telescope",
      },
      -- add <leader>fa to find all, including hidden files
      {
        "<leader>fa",
        "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
        desc = "Find All Files (including hidden)",
      },
    },
    mapping = {
      i = {
        ["C-v"] = open_selected_file_in_vertical,
      },
    },
  },
}
