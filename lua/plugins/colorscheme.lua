return {
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      transparent = true,
      theme = "wave",
    },
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        transparent = true,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
    },
    lazy = true,
  },
  {
    "Mofiqul/dracula.nvim",
    config = function()
      -- Disable spell check as it's too red
      vim.o.spell = false

      local dracula = require("dracula")
      dracula.setup({
        transparent_bg = true, -- default false
        -- set italic comment
        italic_comment = true, -- default false
        overrides = {},
      })
    end,
    lazy = true,
  },

  -- default is tokyonight
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- set LazyVim to load colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "dracula",
    },
  },
}
