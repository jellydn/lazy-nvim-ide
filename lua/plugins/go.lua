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
        -- linters: revive, errcheck, staticcheck, golangci-lint
        linter = "revive",
        -- linter_flags: e.g., {revive = {'-config', '/path/to/config.yml'}}
        -- formatter: goimports, gofmt, gofumpt, lsp
        formatter = "gofmt",
      })
      go.config.update_tool("quicktype", function(tool)
        tool.pkg_mgr = "yarn"
      end)
    end,
  },
}
