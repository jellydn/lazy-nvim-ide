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
        -- inlay hints
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all'
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = false,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = false,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all'
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayVariableTypeHints = true,
              includeInlayFunctionParameterTypeHints = false,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = false,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },
      denols = {
        root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
      },
      rome = {
        root_dir = require("lspconfig").util.root_pattern("rome.json", "rome.jsonc"),
        single_file_support = false,
      },
    },
    -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
    -- Be aware that you also will need to properly configure your LSP server to
    -- provide the inlay hints.
    inlay_hints = {
      enabled = true,
    },
    format = {
      timeout_ms = 10000, -- 10 seconds
    },
    ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
    setup = {
      -- tsserver = function(_, opts)
      --   -- Configure `typescript.nvim`.
      --   require("typescript").setup({
      --     server = opts,
      --   })
      --   return true
      -- end,
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
