return {
  {
    "andrewferrier/debugprint.nvim",
    opts = {
      create_keymaps = false,
      print_tag = "DEBUGGING",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "<leader>d",
        function()
          return require("debugprint").debugprint({
            variable = true,
          })
        end,
        desc = "Debug print",
        expr = true,
      },
    },
  },
}
