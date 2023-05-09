return {
  {
    "ThePrimeagen/harpoon",
    event = "BufRead",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    keys = {
      {
        "<leader>fm",
        "<cmd>Telescope harpoon marks<cr>",
        desc = "Telescope Harpoon Marks",
      },
    },
    config = function()
      local status_ok, harpoon = pcall(require, "harpoon")
      if not status_ok then
        return
      end

      harpoon.setup({})

      local tele_status_ok, telescope = pcall(require, "telescope")
      if not tele_status_ok then
        return
      end

      telescope.load_extension("harpoon")
    end,
  },
}
