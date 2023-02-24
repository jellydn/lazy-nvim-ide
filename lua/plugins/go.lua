return {
  -- Go
  {
    "crispgm/nvim-go",
    ft = "go",
    config = function()
      require("go").config.update_tool("quicktype", function(tool)
        tool.pkg_mgr = "yarn"
      end)
    end,
  },
}
