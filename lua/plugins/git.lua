-- Only load those plugins if the current buffer is a git repository
local is_inside_git_repo = function()
  local git_dir = vim.fn.finddir(".git", vim.fn.expand("%:p:h") .. ";")
  return vim.fn.isdirectory(git_dir) ~= 0
end

return {
  {
    "akinsho/git-conflict.nvim",
    opts = {
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = "DiffAdd",
        current = "DiffText",
      },
    },
    lazy = not is_inside_git_repo(),
    keys = {
      -- Chose conflict
      { "<leader>gfc", "<cmd>GitConflictChooseTheirs<cr>", desc = "Git Conflict Choose - Incoming changes" },
      { "<leader>gfo", "<cmd>GitConflictChooseOurs<cr>", desc = "Git Conflict Choose - Current changes" },
      { "<leader>gfb", "<cmd>GitConflictChooseBoth<cr>", desc = "Git Conflict Choose - Both changes" },
      -- Navigate conflicts
      { "<leader>gfl", "<cmd>GitConflictListQf<cr>", desc = "Git Conflict Quicklist" },
      { "<leader>gfp", "<cmd>GitConflictPrevConflict<cr>", desc = "Git Conflict Previous" },
      { "<leader>gfp", "<cmd>GitConflictPrevConflict<cr>", desc = "Git Conflict Previous" },
    },
  },
  {
    "sindrets/diffview.nvim",
    lazy = not is_inside_git_repo(),
    cmd = "DiffviewOpen",
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Git Diff" } },
  },
}
