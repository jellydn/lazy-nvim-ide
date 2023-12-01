return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint" },
        ["*"] = { "cspell", "codespell" },
      },
    },
  },
}
