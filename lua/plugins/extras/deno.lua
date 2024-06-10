return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    servers = {
      denols = {
        root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc", "deno.lock"),
      },
    },
    setup = {},
  },
}
