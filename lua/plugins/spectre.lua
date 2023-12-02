local Path = require("utils.path")

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
        function()
          local opts = {}
          if Path.is_git_repo() then
            opts.cwd = Path.get_git_root()
          end
          require("spectre").open(opts)
        end,
        desc = "Replace in files (Root dir)",
      },
      -- Search current word
      {
        "<leader>sP",
        function()
          local opts = {
            select_word = true,
          }
          if Path.is_git_repo() then
            opts.cwd = Path.get_git_root()
          end
          require("spectre").open_visual(opts)
        end,
        desc = "Replace current word (Root dir)",
      },
      -- Open search with select word in visual mode
      {
        "<leader>sr",
        function()
          local opts = {}
          if Path.is_git_repo() then
            opts.cwd = Path.get_git_root()
          end
          require("spectre").open_visual(opts)
        end,
        mode = "v",
        silent = true,
        desc = "Replace current word (Root dir)",
      },
    },
  },
}
