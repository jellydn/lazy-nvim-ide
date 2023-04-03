return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = {
      [[                                                        ]],
      [[      ██╗████████╗    ███╗   ███╗ █████╗ ███╗   ██╗     ]],
      [[      ██║╚══██╔══╝    ████╗ ████║██╔══██╗████╗  ██║     ]],
      [[      ██║   ██║       ██╔████╔██║███████║██╔██╗ ██║     ]],
      [[      ██║   ██║       ██║╚██╔╝██║██╔══██║██║╚██╗██║     ]],
      [[      ██║   ██║       ██║ ╚═╝ ██║██║  ██║██║ ╚████║     ]],
      [[      ╚═╝   ╚═╝       ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝     ]],
      [[                                                        ]],
    }

    dashboard.section.header.val = logo
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
      dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("p", " " .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
      dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
      dashboard.button("s", "勒" .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
      dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }
    dashboard.section.footer.val = "productsway.com"

    return dashboard
  end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)
  end,
}
