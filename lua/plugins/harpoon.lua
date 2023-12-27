return {
  {
    "ThePrimeagen/harpoon",
    event = "BufRead",
    branch = "harpoon2",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    keys = {
      {
        "<leader>fm",
        "<cmd>Telescope harpoon marks<cr>",
        desc = "Telescope Harpoon Marks",
      },
      {
        "<leader>hh",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon toggle menu",
      },
      {
        "<leader>ha",
        function()
          local harpoon = require("harpoon")
          harpoon:list():append()
        end,
        desc = "Harpoon Add File",
      },
    },
    opts = {},
    config = function(_, options)
      local status_ok, harpoon = pcall(require, "harpoon")
      if not status_ok then
        return
      end

      harpoon.setup(options)

      local tele_status_ok, telescope = pcall(require, "telescope")
      if not tele_status_ok then
        return
      end

      telescope.load_extension("harpoon")
    end,
  },
}
