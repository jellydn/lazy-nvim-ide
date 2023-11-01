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
        "biome",
        -- code spell
        "codespell",
        "misspell",
        "cspell",
        -- markdown
        "markdownlint",
        -- rustywind for tailwindcss
        "rustywind",
        -- php
        "pint",
        -- astro
        "astro-language-server",
        -- Solidity
        "solidity",
      },
    },
  },
}
