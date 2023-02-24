return {
  "neovim/nvim-lspconfig",
  dependencies = { "jose-elias-alvarez/typescript.nvim" },
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      tsserver = { root_dir = require("lspconfig").util.root_pattern("package.json"), single_file_support = false },
      denols = { root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc") },
    },
    ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
    -- setup = {
    --   tsserver = function(_, opts)
    --     require("typescript").setup({
    --       server = opts,
    --       root_dir = lspconfig.util.root_pattern("package.json"),
    --       single_file_support = false,
    --     })
    --     return true
    --   end,
    -- },
  },
}
