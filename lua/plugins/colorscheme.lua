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
    local night_themes = { "kanagawa", "nightfox", "dracula" }
    local idx = math.random(#night_themes)
    colorscheme = night_themes[idx]
  end

  -- notify about the selected colorscheme based on the time
  vim.notify("Selected colorscheme: " .. colorscheme)

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
