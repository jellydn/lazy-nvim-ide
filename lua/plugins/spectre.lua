local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

local function is_git_repo()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  return vim.v.shell_error == 0
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
        function()
          local opts = {}
          if is_git_repo() then
            opts.cwd = get_git_root()
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
          if is_git_repo() then
            opts.cwd = get_git_root()
          end
          require("spectre").open_visual(opts)
        end,
        desc = "Replace current word (Root dir)",
      },
    },
  },
}
