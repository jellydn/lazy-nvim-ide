--- General configuration for spectre base on current git repo
---@param default_opts table | nil
---@return table
function _G.get_spectre_options(default_opts)
  local Path = require("utils.path")
  local opts = default_opts or {}

  if Path.is_git_repo() then
    opts.cwd = Path.get_git_root()
  end

  return opts
end

return {
  {
    -- Search and replace with pattern
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files",
      },
      {
        "<leader>sp",
        ":lua require('spectre').open(_G.get_spectre_options())<CR>",
        desc = "Replace in files (Root dir)",
      },
      -- Search current word
      {
        "<leader>sP",
        ":lua require('spectre').open_visual(_G.get_spectre_options({ select_word = true }))<CR>",
        desc = "Replace current word (Root dir)",
      },
      -- Open search with select word in visual mode
      {
        "<leader>sr",
        ":lua require('spectre').open_visual(_G.get_spectre_options())<CR>",
        mode = "v",
        silent = true,
        desc = "Replace current word (Root dir)",
      },
      -- Search on current file
      {
        "<leader>sf",
        ":lua require('spectre').open_file_search(_G.get_spectre_options({ select_word = true }))<CR>",
        desc = "Replace in current file",
      },
    },
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.left = opts.left or {}
      table.insert(opts.left, {
        title = "Spectre",
        ft = "spectre_panel",
        size = { width = 0.3 },
      })
    end,
  },
}
