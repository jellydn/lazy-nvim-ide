local function is_weekend()
  local day = tonumber(os.date("%w"))
  return day == 0 or day == 6
end

local function is_day_time()
  local hour = tonumber(os.date("%H"))
  return hour >= 9 and hour < 19
end

local is_transparent = is_day_time() and not is_weekend()
local colorscheme = "tokyonight"

-- Select colorscheme based on the time, and load it with LazyVim
-- day time on weekday: tokyonight (moon)
-- night time or weekend: random from {nightfox, rose-pine, catppuccin-frappe, everforest, dracula}
local function selectColorSchemeByTime()
  -- skip if running in vscode
  if vim.g.vscode then
    return "tokyonight"
  end

  if is_transparent then
    colorscheme = "tokyonight"
  else
    local night_themes = { "nightfox", "rose-pine", "catppuccin-frappe", "everforest", "dracula" }
    local idx = tonumber(os.date("%S")) % #night_themes + 1
    if colorscheme == night_themes[idx] then
      -- if the same theme is selected, select the next one
      idx = idx % #night_themes + 1
    end

    colorscheme = night_themes[idx]
  end

  vim.notify("Selected colorscheme: " .. colorscheme)
  return colorscheme
end

--- Set random colorscheme with turning off transparent background
local function randomize_theme()
  is_transparent = false
  colorscheme = selectColorSchemeByTime()
  vim.cmd.colorscheme(colorscheme)
end

-- Define a keymap to randomize colorscheme
vim.keymap.set("n", "<leader>tc", randomize_theme, {
  desc = "Randomize colorscheme",
})

--- Set color theme with transparent background
local function theme_maker()
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

-- Define a keymap to toggle transparent background for nightfox
vim.keymap.set("n", "<leader>tb", function()
  is_transparent = not is_transparent
  vim.notify("Transparent: " .. tostring(is_transparent))

  theme_maker()

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
  -- NOTE: Will revisit Cobalt2 later
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
  -- default is tokyonight in moon style
  {
    "folke/tokyonight.nvim",
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
