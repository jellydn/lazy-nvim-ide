return {
  {
    "nvim-zh/better-escape.vim",
    event = "InsertEnter",
    config = function()
      vim.cmd([[
        let g:better_escape_shortcut = ['jk', 'jj']
      ]])
    end,
  },
}
