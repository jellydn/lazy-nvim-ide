-- Need install `sad` first, e.g: brew install sad
--
-- Usage:
-- <Tab> To toggle the individual item in the replacement list
-- <CR> to confirm and apply all the replacement
-- <Esc> to cancel all changes
-- <Ctrl-a> toggle select all
--
return {
  "ray-x/sad.nvim",
  dependencies = { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
  opts = {
    diff = "delta", -- you can use `less`, `diff-so-fancy`
  },
  cmd = {
    "Sad",
  },
}
