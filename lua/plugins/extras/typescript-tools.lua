local Lsp = require("utils.lsp")

return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
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
      on_attach = function(client, bufnr)
        require("twoslash-queries").attach(client, bufnr)
      end,
      root_dir = function(fname)
        if Lsp.deno_config_exist() then
          return true
        end

        -- INFO: stealed from:
        -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/tsserver.lua#L22
        local util = require("lspconfig.util")
        local root_dir = util.root_pattern("tsconfig.json")(fname)
          or util.root_pattern("package.json", "jsconfig.json", ".git")(fname)

        -- INFO: this is needed to make sure we don't pick up root_dir inside node_modules
        local node_modules_index = root_dir and root_dir:find("node_modules", 1, true)
        if node_modules_index and node_modules_index > 0 then
          root_dir = root_dir:sub(1, node_modules_index - 2)
        end

        return root_dir
      end,
      settings = {
        -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
        -- possible values: ("off"|"all"|"implementations_only"|"references_only")
        code_lens = "references_only",

        tsserver_file_preferences = {
          includeInlayParameterNameHints = "literals",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayVariableTypeHints = false,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = false,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        -- Disable tsserver
        tsserver = function()
          return true
        end,
        -- Disable vtsls
        vtsls = function()
          return true
        end,
      },
    },
  },
}
