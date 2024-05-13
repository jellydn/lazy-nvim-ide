return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- markdown = { "markdownlint" },
        -- Need to install golangci-lint
        -- e.g: brew install golangci-lint
        go = { "golangcilint" },
        python = { "ruff" },
        ["*"] = { "cspell", "codespell" },
        javascript = { "oxlint" },
        typescript = { "oxlint" },
        javascriptreact = { "oxlint" },
        typescriptreact = { "oxlint" },
      },
    },
    init = function()
      -- Register oxlint
      require("lint").linters.oxlint = {
        name = "oxlint",
        -- Refer to setup https://oxc-project.github.io/docs/contribute/development.html#cargo-binstall
        -- Or use the following command to install
        -- cargo install --features allocator --git https://github.com/oxc-project/oxc oxc_cli
        cmd = "oxlint",
        stdin = false,
        args = { "--format", "unix" },
        stream = "stdout",
        ignore_exitcode = true,
        parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
          source = "oxlint",
          severity = vim.diagnostic.severity.WARN,
        }),
      }
    end,
  },
}
