return {
  {
    --- Search and replace with sad
    "ray-x/sad.nvim",
    dependencies = { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
    cmd = "Sad",
    opts = {},
  },
}
