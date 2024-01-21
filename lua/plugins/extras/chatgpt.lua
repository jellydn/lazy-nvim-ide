return {
  {
    "jackMort/ChatGPT.nvim",
    -- Not enabled if neovide
    enabled = not vim.g.neovide,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      -- Option 1: Use Nitro https://nitro.jan.ai/ and load the model from huggingface, e.g: https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF/blob/main/mistral-7b-instruct-v0.1.Q5_K_M.gguf
      -- Option 2: Github Copilot https://github.com/aaamoon/copilot-gpt4-service
      api_key_cmd = "echo -n " .. os.getenv("GITHUB_COPILOT_TOKEN"),
      -- Install nitro on local machine, refer https://nitro.jan.ai/
      api_host_cmd = "echo -n http://localhost:3928",
      chat = {
        welcome_message = "Chat With Local AI",
      },
    },
    cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatGPTRun" },
  },
}
