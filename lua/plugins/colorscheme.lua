local function is_weekend()
  local day = tonumber(os.date("%w"))
  return day == 0 or day == 6
end

local function is_day_time()
  local hour = tonumber(os.date("%H"))
  return hour >= 9 and hour < 19
end

local is_transparent = is_day_time() and not is_weekend()

-- Default colorscheme
local default_color_scheme = "kanagawa"

-- Select colorscheme based on the time, and load it with LazyVim
local function selectColorSchemeByTime()
  -- skip if running in vscode
  if vim.g.vscode then
    return "tokyonight"
  end

  if is_transparent then
    return default_color_scheme
  else
    local night_themes = {
      "tokyonight",
      "nightfox",
      "rose-pine",
      "catppuccin-frappe",
      "everforest",
      "dracula",
      "cobalt2",
      "kanagawa",
    }
    local idx = tonumber(os.date("%S")) % #night_themes + 1

    local colorscheme = night_themes[idx]
    vim.notify("Selected colorscheme: " .. colorscheme)
    return colorscheme
  end
end

--- Set random colorscheme with turning off transparent background
local function randomize_theme()
  is_transparent = false
  local colorscheme = selectColorSchemeByTime()
  vim.cmd.colorscheme(colorscheme)
end

-- Define a keymap to randomize colorscheme
vim.keymap.set("n", "<leader>tc", randomize_theme, {
  desc = "Randomize colorscheme",
})

--- Set color theme with transparent background
local function theme_maker(colorscheme)
  if colorscheme == "everforest" then
    vim.g.everforest_transparent_background = is_transparent and 1 or 0
  end

  if colorscheme == "dracula" then
    local dracula = require("dracula")
    local opts = {
      transparent_bg = is_transparent,
      show_end_of_buffer = true,
      -- set italic comment
      italic_comment = true,
    }
    dracula.setup(opts)
  end

  if colorscheme == "catppuccin-frappe" then
    local opts = {
      transparent_background = is_transparent,
    }
    local catppuccin = require("catppuccin")
    catppuccin.setup(opts)
  end

  if colorscheme == "rose-pine" then
    local opts = {
      variant = "moon",
      disable_background = is_transparent,
      disable_float_background = is_transparent,
    }

    local rose_pine = require("rose-pine")
    rose_pine.setup(opts)
  end

  if colorscheme == "nightfox" then
    local opts = {
      transparent = is_transparent,
      styles = {
        comments = "italic",
        keywords = "bold",
        types = "italic,bold",
      },
    }
    local nightfox = require("nightfox")
    nightfox.setup(opts)
  end

  if colorscheme == "tokyonight" then
    local opts = {
      style = "moon",
      transparent = is_transparent,
      styles = is_transparent and {
        sidebars = "transparent",
        floats = "transparent",
      } or {},
    }
    local tokyonight = require("tokyonight")
    tokyonight.setup(opts)
  end
end

-- Toggle background with <leader>tb
vim.keymap.set("n", "<leader>tb", function()
  is_transparent = not is_transparent
  local colorscheme = selectColorSchemeByTime()
  theme_maker(colorscheme)
  vim.cmd("colorscheme " .. colorscheme)
end, {
  desc = "Toggle background",
})

return {
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        transparent = is_transparent,
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
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "moon",
      disable_background = is_transparent,
      disable_float_background = is_transparent,
    },
    lazy = true,
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      transparent_background = is_transparent,
    },
  },
  {
    "lalitmee/cobalt2.nvim",
    lazy = true,
    dependencies = { "tjdevries/colorbuddy.nvim" },
    config = function()
      require("colorbuddy").colorscheme("cobalt2")
      -- Disable spell checking as it is not readable
      vim.o.spell = false
    end,
  },
  {
    "sainnhe/everforest",
    config = function()
      -- " Available values: 'hard', 'medium'(default), 'soft'
      if is_transparent then
        vim.g.everforest_background = "soft"
        vim.g.everforest_transparent_background = 1
      end
      -- For better performance
      vim.g.everforest_better_performance = 1
      -- Enable italic
      vim.g.everforest_enable_italic = 1
    end,
    lazy = true,
  },
  {
    "Mofiqul/dracula.nvim",
    opts = {
      transparent_bg = is_transparent,
      show_end_of_buffer = true,
      -- set italic comment
      italic_comment = true,
    },
    config = function(_, opts)
      local dracula = require("dracula")
      dracula.setup(opts)
      -- Disable spell check as it's too red
      vim.o.spell = false
    end,
    lazy = true,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      -- Remove gutter background
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Transparent background
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Borderless telescope
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        }
      end,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon",
      transparent = is_transparent,
      styles = is_transparent and {
        sidebars = "transparent",
        floats = "transparent",
      } or {},
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
