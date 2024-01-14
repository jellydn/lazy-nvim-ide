local IS_DEV = false

return {
  -- Easy to use, need to have a model downloaded
  {
    "jellydn/gen.nvim",
    dir = IS_DEV and "~/Projects/research/gen.nvim" or nil,
    opts = {
      model = "mistral", -- The default model to use. If you don't have, run `ollama pull mistral` on your terminal.
      display_mode = "split", -- The display mode. Can be "float" or "split".
      show_prompt = true, -- Shows the Prompt submitted to Ollama.
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
    config = function(_, opts)
      local gen = require("gen")
      gen.setup(opts)
      gen.prompts["Elaborate_Text"] = {
        prompt = "Elaborate the following text:\n$text",
      }
      gen.prompts["Fix_Code"] = {
        prompt = "Fix the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        extract = "```$filetype\n(.-)```",
      }
    end,
  },
}
