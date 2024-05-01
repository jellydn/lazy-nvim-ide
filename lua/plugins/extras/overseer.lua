local icons = {
  Canceled = " ",
  Failure = " ",
  Success = " ",
  Running = " ",
}
return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      local overseer = require("overseer")
      table.insert(opts.sections.lualine_x, {
        "overseer",
        label = "", -- Prefix for task counts
        colored = true, -- Color the task icons and counts
        symbols = {
          [overseer.STATUS.CANCELED] = icons.Canceled,
          [overseer.STATUS.FAILURE] = icons.Failure,
          [overseer.STATUS.SUCCESS] = icons.Success,
          [overseer.STATUS.RUNNING] = icons.Running,
        },
        unique = false, -- Unique-ify non-running task count by name
        name = nil, -- List of task names to search for
        name_not = false, -- When true, invert the name search
        status = nil, -- List of task statuses to display
        status_not = false, -- When true, invert the status search
      })
    end,
  },
  {
    "stevearc/overseer.nvim",
    dependencies = {
      "akinsho/toggleterm.nvim",
    },
    opts = {
      dap = false,
      -- Configuration for task floating windows
      task_win = {
        -- How much space to leave around the floating window
        padding = 2,
        border = "single", -- or double
        -- Set any window options here (e.g. winhighlight)
        win_opts = {
          winblend = 2,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
      },
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
