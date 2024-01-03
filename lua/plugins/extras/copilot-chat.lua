return {
  -- Import the copilot plugin
  { import = "lazyvim.plugins.extras.coding.copilot" },
  {
    "jellydn/CopilotChat.nvim",
    branch = "canary",
    opts = {
      mode = "split",
    },
    build = function()
      vim.defer_fn(function()
        vim.cmd("UpdateRemotePlugins")
        vim.notify("CopilotChat - Updated remote plugins. Please restart Neovim.")
      end, 3000)
    end,
    event = "VeryLazy",
    keys = {
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
    },
  },
}
