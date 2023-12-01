-- TODO: Move those to common util functions
local function is_git_repo()
  vim.fn.system("git rev-parse --is-inside-work-tree")

  return vim.v.shell_error == 0
end
local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  return vim.fn.fnamemodify(dot_git_path, ":h")
end
local function biome_config_exists()
  local current_dir = vim.fn.getcwd()
  local config_file = current_dir .. "/biome.json"
  if vim.fn.filereadable(config_file) == 1 then
    return true
  end

  -- If the current directory is a git repo, check if the root of the repo
  -- contains a biome.json file
  local git_root = get_git_root()
  if is_git_repo() and git_root ~= current_dir then
    config_file = git_root .. "/biome.json"
    if vim.fn.filereadable(config_file) == 1 then
      return true
    end
  end

  return false
end
local function deno_config_exist()
  local current_dir = vim.fn.getcwd()
  local config_file = current_dir .. "/deno.json"
  if vim.fn.filereadable(config_file) == 1 then
    return true
  end

  -- If the current directory is a git repo, check if the root of the repo
  -- contains a deno.json file
  local git_root = get_git_root()
  if is_git_repo() and git_root ~= current_dir then
    config_file = git_root .. "/deno.json"
    if vim.fn.filereadable(config_file) == 1 then
      return true
    end
  end

  return false
end

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
        root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json"),
        single_file_support = false,
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
          {
            "<leader>cR",
            function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.removeUnused.ts" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Remove Unused Imports",
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
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
          },
          javascript = {
            inlayHints = {
              -- You can set this to 'all' or 'literals' to enable more hints
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all'
              includeInlayVariableTypeHints = false,
              includeInlayFunctionParameterTypeHints = false,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = false,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
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
      denols = {
        root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc", "deno.lock"),
      },
      biome = {
        -- root_dir = require("lspconfig").util.root_pattern("biome.json"),
        -- Fallback to nvim config dir if biome.json is not found
        root_dir = function()
          if biome_config_exists() then
            return require("lspconfig").util.root_pattern("biome.json")()
          end

          return vim.fn.stdpath("config")
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
    setup = {
      tsserver = function(_, opts)
        -- Disable tsserver if denols is present
        if deno_config_exist() then
          return true
        end
      end,
    },
  },
}
