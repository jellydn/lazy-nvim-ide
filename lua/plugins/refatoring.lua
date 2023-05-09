return {
  {
    "ThePrimeagen/refactoring.nvim",
    event = "BufRead",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      local status_ok, refactoring = pcall(require, "refactoring")
      if not status_ok then
        return
      end

      refactoring.setup({})

      local tele_status_ok, telescope = pcall(require, "telescope")
      if not tele_status_ok then
        return
      end

      telescope.load_extension("refactoring")
    end,
  },
}
