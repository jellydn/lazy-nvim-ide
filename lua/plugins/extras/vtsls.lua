local Lsp = require("utils.lsp")

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "yioneko/nvim-vtsls",
      },
      -- Typescript formatter
      {
        "dmmulroy/ts-error-translator.nvim",
        ft = "javascript,typescript,typescriptreact,svelte",
        opts = {
          auto_override_publish_diagnostics = true,
        },
      },
      -- Type queries
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
    opts = {
      servers = {
        tsserver = {
          enabled = false,
        },
        -- ---@type lspconfig.options.vtsls
        vtsls = {
          -- add keymap
          keys = {
            {
              "<leader>cV",
              "<cmd>VtsExec select_ts_version<cr>",
              desc = "Select TS workspace version",
            },
            {
              "gD",
              function()
                require("vtsls").commands.goto_source_definition(0)
              end,
              desc = "Goto Source Definition",
            },
            {
              "gR",
              function()
                require("vtsls").commands.file_references(0)
              end,
              desc = "File References",
            },
            {
              "<leader>co",
              function()
                require("vtsls").commands.organize_imports(0)
              end,
              desc = "Organize Imports",
            },
            {
              "<leader>cM",
              function()
                require("vtsls").commands.add_missing_imports(0)
              end,
              desc = "Add missing imports",
            },
            {
              "<leader>cu",
              function()
                require("vtsls").commands.remove_unused_imports(0)
              end,
              desc = "Remove unused imports",
            },
            {
              "<leader>cD",
              function()
                require("vtsls").commands.fix_all(0)
              end,
              desc = "Fix all diagnostics",
            },
          },

          -- Settings
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            javascript = {
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              updateImportsOnFileMove = {
                enabled = "always",
              },
            },
            typescript = {
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              updateImportsOnFileMove = {
                enabled = "always",
              },
            },
          },
        },
      },
      setup = {
        -- Disable tsserver
        tsserver = function()
          return true
        end,
        vtsls = function()
          -- Disable tsserver if denols is present
          if Lsp.deno_config_exist() then
            return true
          end

          require("lazyvim.util").lsp.on_attach(function(client, bufnr)
            if client.name == "vtsls" then
              -- Attach twoslash queries
              require("twoslash-queries").attach(client, bufnr)
            end
          end)
        end,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "vtsls" })
    end,
  },
}
