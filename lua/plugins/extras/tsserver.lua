local Lsp = require("utils.lsp")

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Typescript formatter
    {
      "dmmulroy/ts-error-translator.nvim",
      ft = "javascript,typescript,typescriptreact,svelte",
    },
    {
      "marilari88/twoslash-queries.nvim",
      ft = "javascript,typescript,typescriptreact,svelte",
      opts = {
        is_enabled = false, -- Use :TwoslashQueriesEnable to enable
        multi_line = true, -- to print types in multi line mode
        highlight = "Type", -- to set up a highlight group for the virtual text
      },
      keys = {
        { "<leader>dt", ":TwoslashQueriesEnable<cr>", desc = "Enable twoslash queries" },
        { "<leader>dd", ":TwoslashQueriesInspect<cr>", desc = "Inspect twoslash queries" },
      },
    },
  },
  ---@class PluginLspOpts
  opts = {
    servers = {
      tsserver = {
        root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json"),
        single_file_support = false,
        handlers = {
          -- format error code with better error message
          ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
            require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
            vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
          end,
        },
        -- add keymap
        keys = {
          {
            "<leader>co",
            function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.organizeImports" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Organize Imports",
          },
          {
            "<leader>cR",
            function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.removeUnused" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Remove Unused Imports",
          },
        },
        -- inlay hints & code lens, refer to https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md/#workspacedidchangeconfiguration
        settings = {
          typescript = {
            -- Inlay Hints preferences
            inlayHints = {
              -- You can set this to 'all' or 'literals' to enable more hints
              includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all'
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = false,
              includeInlayVariableTypeHints = false,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = false,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            -- Code Lens preferences
            implementationsCodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enabled = true,
              showOnAllFunctions = true,
            },
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
          },
          javascript = {
            -- Inlay Hints preferences
            inlayHints = {
              -- You can set this to 'all' or 'literals' to enable more hints
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
              includeInlayVariableTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            -- Code Lens preferences
            implementationsCodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enabled = true,
              showOnAllFunctions = true,
            },
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
          },
          completions = {
            completeFunctionCalls = true,
          },
        },
      },
    },
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
    setup = {
      -- Disable vtsls
      vtsls = function()
        return true
      end,
      tsserver = function()
        -- Disable tsserver if denols is present
        if Lsp.deno_config_exist() then
          return true
        end

        require("lazyvim.util").lsp.on_attach(function(client, bufnr)
          if client.name == "tsserver" then
            -- Attach twoslash queries
            require("twoslash-queries").attach(client, bufnr)
          end
        end)
      end,
    },
  },
}
