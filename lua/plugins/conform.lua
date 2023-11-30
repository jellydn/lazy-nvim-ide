return {
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
        ["markdown"] = { { "biome", "prettierd", "prettier" } },
        ["markdown.mdx"] = { { "biome", "prettierd", "prettier" } },
        -- Use a sub-list to run only the first available formatter
        ["javascript"] = { { "biome", "prettierd", "prettier" } },
        ["javascriptreact"] = { "rustywind", { "biome", "prettierd", "prettier" } },
        ["typescript"] = { { "biome", "prettierd", "prettier" } },
        ["typescriptreact"] = { "rustywind", { "biome", "prettierd", "prettier" } },
      },
      formatters = {
        rustywind = {
          command = "rustywind",
          stdin = true,
          -- A function that calculates the directory to run the command in
          cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
          -- When cwd is not found, don't run the formatter (default false)
          require_cwd = true,
        },
        biome = {
          condition = function(ctx)
            return vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        prettierd = {
          condition = function(ctx)
            return not vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        prettier = {
          condition = function(ctx)
            return not vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
