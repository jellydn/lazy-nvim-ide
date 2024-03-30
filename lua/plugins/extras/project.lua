return {
  -- project management
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)

      local tele_status_ok, telescope = pcall(require, "telescope")
      if not tele_status_ok then
        return
      end

      telescope.load_extension("projects")

      vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<CR>", {
        noremap = true,
        silent = true,
        desc = "Switch to project",
      })
    end,
  },
}
