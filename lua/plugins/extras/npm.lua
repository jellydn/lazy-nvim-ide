return {
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    keys = {
      {
        "<leader>pi",
        "<cmd>Telescope package_info<cr>",
        desc = "Telescope Package Info",
      },
    },
    opts = {},
    config = function(_, options)
      local status_ok, pkg = pcall(require, "package-info")
      if not status_ok then
        return
      end

      pkg.setup(options)

      local tele_status_ok, telescope = pcall(require, "telescope")
      if not tele_status_ok then
        return
      end

      telescope.load_extension("package_info")
    end,
  },
}
