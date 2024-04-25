return {
  {
    "laytan/cloak.nvim",
    -- TODO: Support for Fzf lua when it's available, refer https://github.com/laytan/cloak.nvim/issues/17
    opts = { enabled = true, cloak_character = "*" },
    event = "VeryLazy",
    keys = {
      {
        "<leader>tC",
        "<cmd>CloakToggle<cr>",
        desc = "Toggle cloak",
      },
    },
  },
}
