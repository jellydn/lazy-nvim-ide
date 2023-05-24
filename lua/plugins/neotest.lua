return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      -- add adapter for neotest
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-vim-test",
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "markemmons/neotest-deno",
      "nvim-neotest/neotest-go",
      "rouge8/neotest-rust",
    },
    opts = {
      -- Can be a list of adapters like what neotest expects,
      -- or a table of adapter names, mapped to adapter configs.
      -- The adapter will then be automatically loaded with the config.
      adapters = {
        ["neotest-deno"] = {},
        ["neotest-jest"] = {},
        ["neotest-vitest"] = {},
        ["neotest-vim-test"] = {
          ignore_file_types = { "python", "vim", "lua", "go", "rust" },
        },
        ["neotest-python"] = {},
        ["neotest-go"] = {},
        ["neotest-rust"] = {},
      },
    },
  },
}
