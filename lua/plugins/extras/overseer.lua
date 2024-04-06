return {
  {
    "stevearc/overseer.nvim",
    dependencies = {
      "akinsho/toggleterm.nvim",
    },
    opts = {
      dap = false,
    },
    keys = {
      {
        "<leader>rt",
        "<CMD>OverseerRun<CR>",
        desc = "Overseer - Run Task",
      },
      -- Quick action
      {
        "<leader>rq",
        "<CMD>OverseerQuickAction<CR>",
        desc = "Overseer - Quick Action",
      },
      -- Rerun last command
      {
        "<leader>rr",
        function()
          local overseer = require("overseer")
          local tasks = overseer.list_tasks({ recent_first = true })
          if vim.tbl_isempty(tasks) then
            vim.notify("No tasks found", vim.log.levels.WARN)
          else
            overseer.run_action(tasks[1], "restart")
          end
        end,
        desc = "Overseer - Rerun Last Task",
      },
      -- Toggle
      {
        "<leader>ro",
        "<CMD>OverseerToggle bottom<CR>",
        desc = "Overseer - Toggle at bottom",
      },
    },
  },
}
