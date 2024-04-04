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
      },
    },
  },
}
