return {
  -- Send buffers into early retirement by automatically closing them after x minutes of inactivity.
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },
}
