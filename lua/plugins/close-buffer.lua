return {
  -- Send buffers into early retirement by automatically closing them after x minutes of inactivity.
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
    opts = {
      -- if a buffer has been inactive for this many minutes, close it
      retirementAgeMins = 30,
    },
  },
}
