local logo = [[
  ██╗████████╗    ███╗   ███╗ █████╗ ███╗   ██╗
  ██║╚══██╔══╝    ████╗ ████║██╔══██╗████╗  ██║
  ██║   ██║       ██╔████╔██║███████║██╔██╗ ██║
  ██║   ██║       ██║╚██╔╝██║██╔══██║██║╚██╗██║
  ██║   ██║       ██║ ╚═╝ ██║██║  ██║██║ ╚████║
  ╚═╝   ╚═╝       ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
]]

logo = string.rep("\n", 6) .. logo .. "\n\n"

return {
  "nvimdev/dashboard-nvim",
  opts = {
    config = {
      -- Center the dashboard
      header = vim.split(logo, "\n"),
      footer = function()
        return { "productsway.com" }
      end,
    },
  },
}
