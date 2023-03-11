return {
  -- Go
  {
    "crispgm/nvim-go",
    ft = "go",
    config = function()
      -- import packages automatically
      local go = require("go")
      go.setup({
        -- lint_prompt_style: qf (quickfix), vt (virtual text)
        lint_prompt_style = "vt",
      })
      go.config.update_tool("quicktype", function(tool)
        tool.pkg_mgr = "yarn"
      end)
    end,
  },
}
