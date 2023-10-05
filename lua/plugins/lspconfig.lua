return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Typescript formatter
    {
      "davidosomething/format-ts-errors.nvim",
      ft = "javascript,typescript,typescriptreact,svelte",
    },
    -- Php
    {
      "gbprod/phpactor.nvim",
      ft = { "php", "yaml" },
      cmd = { "PhpActor" },
      keys = {
        { "<leader>pc", ":PhpActor context_menu<cr>", desc = "PhpActor context menu" },
      },
      build = function()
        require("phpactor.handler.update")()
      end,
      opts = {
        install = {
          check_on_startup = "daily",
          bin = vim.fn.stdpath("data") .. "/mason/bin/phpactor",
        },
        lspconfig = {
          enabled = true,
          init_options = {
            ["language_server_phpstan.enabled"] = true,
            ["phpunit.enabled"] = true,
          },
        },
      },
    },
  },
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
        handlers = {
          -- format error code with better error message
          ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
            if result.diagnostics == nil then
              return
            end

            local idx = 1

            while idx <= #result.diagnostics do
              local entry = result.diagnostics[idx]
              local formatter = require("format-ts-errors")[entry.code]
              entry.message = formatter and formatter(entry.message) or entry.message
              if entry.code == 80001 then
                table.remove(result.diagnostics, idx)
              else
                idx = idx + 1
              end
            end
            vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
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
                  only = { "source.organizeImports.ts" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Organize Imports",
          },
        },
        -- inlay hints
        settings = {
          typescript = {
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
          },
          javascript = {
            inlayHints = {
              -- You can set this to 'all' or 'literals' to enable more hints
              includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all'
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayVariableTypeHints = false,
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
      biome = {
        -- root_dir = require("lspconfig").util.root_pattern("biome.json"),
        -- Fallback to nvim config dir if biome.json is not found
        root_dir = function()
          local dir = require("lspconfig").util.root_pattern("biome.json")()
          local config_dir = vim.fn.stdpath("config")
          if dir == nil then
            vim.notify("biome.json not found, using nvim config dir as root", vim.log.levels.WARN)
            return config_dir
          end

          local biome_file = dir .. "/biome.json"
          if vim.fn.filereadable(biome_file) == 0 then
            vim.notify("biome.json not found, using nvim config dir as root", vim.log.levels.WARN)
            return config_dir
          end

          return dir
        end,
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
    -- setup = {
    --   tsserver = function(_, opts)
    --     return true
    --   end,
    -- },
  },
}
