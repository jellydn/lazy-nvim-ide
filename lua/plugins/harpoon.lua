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
    opts = {
      menu = {
        -- 50% width, height
        width = vim.api.nvim_win_get_width(0) / 2,
        height = vim.api.nvim_win_get_height(0) / 2,
      },
    },
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
