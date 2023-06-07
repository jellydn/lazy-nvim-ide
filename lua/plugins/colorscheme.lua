return {
  -- add nord
  {
    "gbprod/nord.nvim",
    lazy = true,
  },
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim", lazy = true },

  -- add nightfox
  { "EdenEast/nightfox.nvim", lazy = true },

  -- add night-owl
  { "haishanh/night-owl.vim", lazy = true },

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
      -- colorscheme = "nightfox",
    },
  },
}
