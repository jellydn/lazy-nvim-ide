local Lsp = require("utils.lsp")

return {
  -- Setup config for formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    keys = {
      -- Add keymap for show info
      { "<leader>cn", "<cmd>ConformInfo<cr>", desc = "Conform Info" },
    },
    opts = {
      formatters_by_ft = {
        fish = {},
        -- Conform will run multiple formatters sequentially
        go = { "goimports", "gofmt" },
        python = { "ruff_fix", "ruff_format" },
        php = { "pint" },
        rust = { "rustfmt" },
        -- Use a sub-list to run only the first available formatter
        ["markdown"] = { { "prettierd", "prettier" } },
        ["markdown.mdx"] = { { "prettierd", "prettier" } },
        ["javascript"] = { { "deno_fmt", "prettierd", "prettier", "biome" } },
        ["javascriptreact"] = { "rustywind", { "biome", "deno_fmt", "prettierd", "prettier" } },
        ["typescript"] = { { "deno_fmt", "prettierd", "prettier", "biome" } },
        ["typescriptreact"] = { "rustywind", { "deno_fmt", "prettierd", "prettier", "biome" } },
        ["svelte"] = { "rustywind", { "deno_fmt", "prettierd", "prettier", "biome" } },
      },
      formatters = {
        biome = {
          condition = function()
            return Lsp.biome_config_exists()
          end,
        },
        deno_fmt = {
          condition = function()
            return Lsp.deno_config_exist()
          end,
        },
        prettier = {
          condition = function()
            return not Lsp.biome_config_exists()
          end,
        },
        prettierd = {
          condition = function()
            return not Lsp.biome_config_exists()
          end,
        },
      },
    },
  },
}
