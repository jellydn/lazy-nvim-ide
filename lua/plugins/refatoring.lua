return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = {
      {
        "<leader>rm",
        function()
          require("refactoring").select_refactor()
        end,
        mode = { "v" },
        desc = "Refactoring menu",
      },
      -- Debug variable
      {
        "<leader>dv",
        function()
          require("refactoring").debug.print_var({
            below = true,
          })
        end,
        mode = { "n", "x" },
        desc = "Print below variables",
      },
      {
        "<leader>dV",
        function()
          require("refactoring").debug.print_var({
            below = false,
          })
        end,
        mode = { "n", "x" },
        desc = "Print above variables",
      },
      -- Clean up debugging
      {
        "<leader>dc",
        function()
          require("refactoring").debug.cleanup({
            force = true,
          })
        end,
        desc = "Clear debugging",
      },
    },
    opts = {
      prompt_func_return_type = {
        go = false,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
    },
    config = function(_, options)
      require("refactoring").setup(options)

      local tele_status_ok, telescope = pcall(require, "telescope")
      if not tele_status_ok then
        return
      end

      telescope.load_extension("refactoring")
    end,
  },
}
