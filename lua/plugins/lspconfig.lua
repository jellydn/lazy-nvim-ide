return {
  "neovim/nvim-lspconfig",
  dependencies = { "jose-elias-alvarez/typescript.nvim" },
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      tsserver = {
        root_dir = require("lspconfig").util.root_pattern("package.json"),
        single_file_support = false,
        -- refer https://github.com/jose-elias-alvarez/null-ls.nvim/discussions/274#discussioncomment-1515526
        on_attach = function(client)
          client.resolved_capabilities.document_formatting = false -- disable formatting in tsserver in favor of null-ls
        end,
      },
      denols = {
        root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
      },
      rome = {
        root_dir = require("lspconfig").util.root_pattern("rome.json", "rome.jsonc"),
        single_file_support = false,
      },
    },
    format = {
      timeout_ms = 10000, -- 10 seconds
    },
    ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
    setup = {
      --   tsserver = function(_, opts)
      --     require("typescript").setup({
      --       server = opts,
      --       root_dir = lspconfig.util.root_pattern("package.json"),
      --       single_file_support = false,
      --     })
      --     return true
      --   end,
      --
      ruff_lsp = function(_, opts)
        -- Configure `ruff-lsp`.
        -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
        -- For the default config, along with instructions on how to customize the settings
        require("lspconfig").ruff_lsp.setup({
          on_attach = function(client, bufnr)
            client.server_capabilities.hoverProvider = false
          end,
          init_options = {
            settings = {
              -- Any extra CLI arguments for `ruff` go here.
              args = { "--line-length=120" },
            },
          },
        })
        return true
      end,
    },
  },
}
