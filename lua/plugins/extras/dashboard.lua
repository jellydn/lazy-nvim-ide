return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function()
    local logo = [[
      ██╗████████╗    ███╗   ███╗ █████╗ ███╗   ██╗
      ██║╚══██╔══╝    ████╗ ████║██╔══██╗████╗  ██║
      ██║   ██║       ██╔████╔██║███████║██╔██╗ ██║
      ██║   ██║       ██║╚██╔╝██║██╔══██║██║╚██╗██║
      ██║   ██║       ██║ ╚═╝ ██║██║  ██║██║ ╚████║
      ╚═╝   ╚═╝       ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
    ]]

    logo = string.rep("\n", 6) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        -- Center the dashboard
        header = vim.split(logo, "\n"),
      -- stylua: ignore
      center = {
        { action = "Telescope find_files",                                      desc = " Find file",       icon = " ", key = "f" },
        { action = "ene | startinsert",                                         desc = " New file",        icon = " ", key = "n" },
        { action = "Telescope oldfiles",                                        desc = " Recent files",    icon = " ", key = "r" },
        { action = "Telescope live_grep",                                       desc = " Find text",       icon = " ", key = "g" },
        { action = "Telescope harpoon marks",                                   desc = " Open mark",       icon = " ", key = "m" },
        { action = [[lua require('telescope').extensions.projects.projects()]], desc = " Projects",        icon = " ", key = "p" },
        { action = [[lua require("lazyvim.util").telescope.config_files()()]],  desc = " Config",          icon = " ", key = "c" },
        { action = 'lua require("persistence").load()',                         desc = " Restore Session", icon = " ", key = "s" },
        { action = "LazyExtras",                                                desc = " Lazy Extras",     icon = " ", key = "x" },
        { action = "Lazy",                                                      desc = " Lazy",            icon = "󰒲 ", key = "l" },
        { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
      },
        footer = function()
          return { "productsway.com" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
