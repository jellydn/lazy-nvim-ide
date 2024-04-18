return {
  "aznhe21/actions-preview.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "nvim-telescope/telescope.nvim", Change back to telescope if you want to use telescope
  },
  opts = {
    backend = { "nui" },
    -- options for nui.nvim components
    nui = {
      -- options for nui Layout component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/layout
      layout = {
        position = "50%",
        size = {
          width = "80%",
          height = "80%",
        },
        min_width = 40,
        min_height = 10,
        relative = "editor",
      },
      -- options for preview area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
      preview = {
        size = "60%",
        border = {
          padding = { 0, 1 },
        },
      },
      -- options for selection area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu
      select = {
        size = "40%",
        border = {
          padding = { 0, 1 },
        },
      },
    },
  },
  keys = {
    {
      "<leader>cP",
      function()
        require("actions-preview").code_actions()
      end,
      desc = "Code Action Preview",
    },
  },
}
