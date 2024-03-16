local IS_DEV = false

--- Get all the changes in the git repository
---@param staged? boolean
---@return string
local function get_git_diff(staged)
  local cmd = staged and "git diff --staged" or "git diff"
  local handle = io.popen(cmd)
  if not handle then
    return ""
  end

  local result = handle:read("*a")
  handle:close()
  return result
end

local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

return {
  { import = "plugins.extras.copilot-vim" }, -- Or use { import = "lazyvim.plugins.extras.coding.copilot" },
  {
    dir = IS_DEV and "~/Projects/research/CopilotChat.nvim" or nil,
    "CopilotC-Nvim/CopilotChat.nvim",
    version = "1.9.1",
    dependencies = {
      { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      show_help = "no",
      prompts = prompts,
      debug = false, -- Set to true to see response from Github Copilot API. The log file will be in ~/.local/state/nvim/CopilotChat.nvim.log.
      disable_extra_info = "no", -- Disable extra information (e.g: system prompt, token count) in the response.
      hide_system_prompt = "yes", -- Show user prompts only and hide system prompts.
      proxy = "", -- Proxies requests via https or socks
    },
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    event = "VeryLazy",
    keys = {
      -- Show help actions with telescope
      {
        "<leader>ah",
        function()
          require("CopilotChat.code_actions").show_help_actions()
        end,
        desc = "CopilotChat - Help actions",
      },
      -- Show prompts actions with telescope
      {
        "<leader>ap",
        function()
          require("CopilotChat.code_actions").show_prompt_actions()
        end,
        desc = "CopilotChat - Prompt actions",
      },
      {
        "<leader>ap",
        ":lua require('CopilotChat.code_actions').show_prompt_actions(true)<CR>",
        mode = "x",
        desc = "CopilotChat - Prompt actions",
      },
      -- Code related commands
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
      { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
      { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
      -- Chat with Copilot in visual mode
      {
        "<leader>av",
        ":CopilotChatVisual",
        mode = "x",
        desc = "CopilotChat - Open in vertical split",
      },
      {
        "<leader>ax",
        ":CopilotChatInPlace<cr>",
        mode = "x",
        desc = "CopilotChat - Run in-place code",
      },
      -- Custom input for CopilotChat
      {
        "<leader>ai",
        function()
          local input = vim.fn.input("Ask Copilot: ")
          if input ~= "" then
            vim.cmd("CopilotChat " .. input)
          end
        end,
        desc = "CopilotChat - Ask input",
      },
      -- Generate commit message based on the git diff
      {
        "<leader>am",
        function()
          local diff = get_git_diff()
          if diff ~= "" then
            vim.fn.setreg('"', diff)
            vim.cmd("CopilotChat Write commit message for the change with commitizen convention.")
          end
        end,
        desc = "CopilotChat - Generate commit message for all changes",
      },
      {
        "<leader>aM",
        function()
          local diff = get_git_diff(true)
          if diff ~= "" then
            vim.fn.setreg('"', diff)
            vim.cmd("CopilotChat Write commit message for the change with commitizen convention.")
          end
        end,
        desc = "CopilotChat - Generate commit message for staged changes",
      },
      -- Quick chat with Copilot
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            vim.cmd("CopilotChatBuffer " .. input)
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      -- Debug
      { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
      -- Fix the issue with diagnostic
      { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
      { "<leader>aF", "<cmd>CopilotChatFixError<cr>", desc = "CopilotChat - Fix Error" },
      -- Clear buffer and chat history
      { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
      -- Toggle Copilot Chat Vsplit
      { "<leader>av", "<cmd>CopilotChatVsplitToggle<cr>", desc = "CopilotChat - Toggle Vsplit" },
    },
  },
}
