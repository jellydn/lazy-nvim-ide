-- Select colorscheme based on the time, and load it with LazyVim
-- day time: tokyonight (moon)
-- night time: random from {kanagawa, nightfox, dracula, cobalt2, everforest, rose-pine}
local function selectColorSchemeByTime()
  -- skip if running in vscode
  if vim.g.vscode then
    return "tokyonight"
  end

  local hour = tonumber(os.date("%H"))
  local colorscheme

  if hour >= 8 and hour < 18 then
    colorscheme = "tokyonight"
  else
    local night_themes = { "kanagawa", "nightfox", "dracula", "everforest", "rose-pine", "catppuccin-frappe" }
    local idx = tonumber(os.date("%S")) % #night_themes + 1
    colorscheme = night_themes[idx]

    vim.notify("Selected colorscheme: " .. colorscheme)
  end

  return colorscheme
end

return {
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      transparent = true,
      theme = "wave",
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
              float = {
                bg = "none",
              },
            },
          },
        },
      },
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
  {
    "sainnhe/everforest",
    config = function()
      -- " Available values: 'hard', 'medium'(default), 'soft'
      vim.g.everforest_background = "soft"
      vim.g.everforest_transparent_background = 1
      -- For better performance
      vim.g.everforest_better_performance = 1
      -- Enable italic
      vim.g.everforest_enable_italic = 1
    end,
    lazy = true,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "moon",
      disable_background = true,
      disable_float_background = true,
    },
    lazy = true,
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      transparent_background = true,
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = false,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
  -- default is tokyonight in moon style
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
      colorscheme = selectColorSchemeByTime(),
    },
  },
}
