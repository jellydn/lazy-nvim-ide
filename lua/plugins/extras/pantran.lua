return {
  -- Run :Pantran to translate the current line or visual selection. Then type 'g?' to see the available binding.
  {
    "potamides/pantran.nvim",
    cmd = { "Pantran" },
    opts = {
      default_engine = "argos",
    },
  },
}
