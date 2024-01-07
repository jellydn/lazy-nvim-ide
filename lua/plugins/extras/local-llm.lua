return {
  -- Easy to use, need to have a model downloaded
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "mistral", -- The default model to use. If you don't have, run `ollama pull mistral` on your terminal.
      display_mode = "split", -- The display mode. Can be "float" or "split".
      show_model = true, -- Displays which model you are using at the beginning of your chat session.
      debug = false, -- Prints errors and the command which is run.
    },
    event = "VeryLazy",
    keys = {
      {
        "<leader>mm",
        function()
          require("gen").select_model()
        end,
        desc = "Gen - Select AI Model",
      },
    },
  },
  -- A bit lower level than gen.nvim, works out of the box with local models like ollama, llama.cpp
  {
    "gsuuon/model.nvim",
    cmd = { "M", "Model", "Mchat" },
    init = function()
      vim.filetype.add({
        extension = {
          mchat = "mchat",
        },
      })
    end,
    enabled = false, -- NOTE: Will revise this later when https://github.com/gsuuon/model.nvim/discussions/9 is done
    config = function()
      local ollama = require("model.providers.ollama")
      require("model").setup({
        providers = {
          ["ollama:starling"] = {
            provider = ollama,
            params = {
              model = "starling-lm",
            },
            builder = function(input)
              return {
                prompt = "GPT4 Correct User: " .. input .. "<|end_of_turn|>GPT4 Correct Assistant: ",
              }
            end,
          },
        },
      })
    end,
    ft = "mchat",
  },
}
