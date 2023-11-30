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
        ["markdown"] = { { "biome", "prettier" } },
        ["markdown.mdx"] = { { "biome", "prettier" } },
        -- Use a sub-list to run only the first available formatter
        ["javascript"] = { { "biome", "prettier" } },
        ["javascriptreact"] = { "rustywind", { "biome", "prettier" } },
        ["typescript"] = { { "biome", "prettier" } },
        ["typescriptreact"] = { "rustywind", { "biome", "prettier" } },
      },
      formatters = {
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
