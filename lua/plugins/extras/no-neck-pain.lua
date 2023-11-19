-- Either use code zen or no neck pain plugin. It's using the same keybinding.
return {
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = "NoNeckPain",
    opts = {
      width = 120,
    },
    keys = {
      {
        "<leader>cz",
        "<cmd>NoNeckPain<cr>",
        desc = "Distraction Free Mode",
      },
    },
  },
}
