return {
  "neovim/nvim-lspconfig",
  dependencies = {},
  ---@class PluginLspOpts
  opts = {
    servers = {},
    -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
    -- Be aware that you also will need to properly configure your LSP server to
    -- provide the inlay hints.
    inlay_hints = {
      enabled = true,
    },
    -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
    -- Be aware that you also will need to properly configure your LSP server to
    -- provide the code lenses.
    codelens = {
      enabled = false, -- Run `lua vim.lsp.codelens.refresh({ bufnr = 0 })` for refreshing code lens
    },
    format = {
      timeout_ms = 10000, -- 10 seconds
    },
    setup = {},
  },
}
