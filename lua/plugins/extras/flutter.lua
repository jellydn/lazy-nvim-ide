return {
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    keys = {
      {
        "<leader>F",
        "<cmd>Telescope flutter commands<cr>",
        desc = "Telescope Flutter commands",
      },
    },
    config = function(_, options)
      local status_ok, flutter = pcall(require, "flutter-tools")
      if not status_ok then
        return
      end

      flutter.setup(options)

      local tele_status_ok, telescope = pcall(require, "telescope")
      if not tele_status_ok then
        return
      end

      telescope.load_extension("flutter")
    end,
  },
}
