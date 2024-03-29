return {
  {
    "adalessa/laravel.nvim",
    ft = "php",
    dependencies = {
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Laravel", "LaravelInfo" },
    keys = {
      { "<leader>pla", ":Laravel artisan<cr>", desc = "Laravel Application Commands" },
      { "<leader>plr", ":Laravel routes<cr>", desc = "Laravel Application Routes" },
      {
        "<leader>plt",
        function()
          require("laravel.tinker").send_to_tinker()
        end,
        mode = "v",
        desc = "Laravel Application Routes",
      },
    },
    config = function()
      require("laravel").setup()
      local tele_status_ok, telescope = pcall(require, "telescope")
      if not tele_status_ok then
        return
      end

      telescope.load_extension("laravel")
    end,
  },
}
