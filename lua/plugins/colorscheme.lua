-- Select colorscheme based on the time, and load it with LazyVim
-- day time: tokyonight (moon)
-- night time: kanagawa, nightfox, dracula
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
    local night_themes = { "kanagawa", "nightfox", "dracula", "cobalt2", "everforest" }
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
    "lalitmee/cobalt2.nvim",
    event = { "ColorSchemePre" }, -- if you want to lazy load
    dependencies = { "tjdevries/colorbuddy.nvim" },
    init = function()
      -- Disable spell check as it's too red
      vim.o.spell = false
      require("colorbuddy").colorscheme("cobalt2")
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
