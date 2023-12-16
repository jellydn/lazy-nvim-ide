--- Send reminder to quickfix list for manual steps
---@param line string
local function send_to_quickfix(line)
  vim.fn.setqflist({ { filename = "CopilotChat.nvim", lnum = 0, text = line } }, "a")
end

return {
  -- Import the copilot plugin
  { import = "lazyvim.plugins.extras.coding.copilot" },
  {
    "gptlang/CopilotChat.nvim",
    build = function()
      local copilot_chat_dir = vim.fn.stdpath("data") .. "/lazy/CopilotChat.nvim"
      -- Copy remote plugin to config folder
      vim.fn.system({ "cp", "-r", copilot_chat_dir .. "/rplugin", vim.fn.stdpath("config") })
      vim.fn.system({ "pip", "install", "-r", copilot_chat_dir .. "/requirements.txt" })

      -- Notify the user about manual steps
      send_to_quickfix("Please run 'pip install -r " .. copilot_chat_dir .. "/requirements.txt' if needed.")
      send_to_quickfix("Afterwards, open Neovim and run ':UpdateRemotePlugins', then restart Neovim.")
    end,
  },
}
