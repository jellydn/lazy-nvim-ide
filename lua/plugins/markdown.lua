return {
  {
    "previm/previm",
    cmd = "PrevimOpen",
    ft = "markdown",
    config = function()
      -- define global for open markdonw preview, let g:previm_open_cmd = 'open -a Safari'
      vim.g.previm_open_cmd = "open -a Arc"
    end,
    keys = {
      -- add <leader>m to open markdown preview
      {
        "<leader>m",
        "<cmd>PrevimOpen<cr>",
        desc = "Markdown preview",
      },
    },
  },
}
