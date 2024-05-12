-- Calculate min width of the window should be 70% of the editor width or 90 columns
-- whichever is smaller
local function zen_mode_width()
  local width = vim.api.nvim_win_get_width(0)
  local min_width = math.max(width * 0.70, 90)
  return math.min(width, min_width)
end

return {
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    opts = {
      window = {
        width = zen_mode_width(),
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          laststatus = 0, -- turn off the statusline in zen mode
        },
        -- NOTE: Those options are disables by default, change to enabled = true to enable
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = false }, -- disables the tmux statusline
        -- NOTE: Need to add to wezterm config https://github.com/folke/zen-mode.nvim#wezterm
        wezterm = {
          enabled = false,
          font = "+1", -- +1 font size or fixed size, e.g. 21
        },
      },
    },
    config = true,
    keys = {
      -- add <leader>cz to enter zen mode
      {
        "<leader>cz",
        "<cmd>ZenMode<cr>",
        desc = "Distraction Free Mode",
      },
    },
  },
}
