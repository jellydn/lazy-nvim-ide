return {
  -- cmdline tools and lsp servers
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        -- formatters
        "eslint_d",
        "prettier",
        -- code spell
        "codespell",
        "misspell",
        -- rustywind for tailwindcss
        "rustywind",
        -- php
        "pint",
      },
    },
  },
}
