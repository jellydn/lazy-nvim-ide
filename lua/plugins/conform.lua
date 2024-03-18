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
        ["markdown"] = { { "prettier" } },
        ["markdown.mdx"] = { { "prettier" } },
        ["javascript"] = { { "biome", "deno_fmt", "prettier" } },
        ["javascriptreact"] = { "rustywind", { "biome", "deno_fmt", "prettier" } },
        ["typescript"] = { { "biome", "deno_fmt", "prettier" } },
        ["typescriptreact"] = { "rustywind", { "biome", "deno_fmt", "prettier" } },
        ["svelte"] = { "rustywind", { "biome", "deno_fmt", "prettier" } },
      },
      formatters = {
        biome = {
          condition = function(ctx)
            return vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        deno_fmt = {
          condition = function(ctx)
            return vim.fs.find({ "deno.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        prettier = {
          condition = function(ctx)
            return not vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
              and not vim.fs.find({ "deno.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
