return {
  -- copilot
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      -- For copilot.vim
      -- enable copilot for specific filetypes
      -- vim.g.copilot_filetypes = {
      --   ["*"] = false,
      -- }

      -- disable tab completion if you want to use tab for something else
      -- let g:copilot_no_tab_map = v:true
      vim.cmd([[
        let g:copilot_assume_mapped = v:true
      ]])
    end,
  },
}
