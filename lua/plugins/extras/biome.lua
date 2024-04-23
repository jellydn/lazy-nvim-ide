local Lsp = require("utils.lsp")

return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    servers = {
      biome = {
        root_dir = function()
          if Lsp.biome_config_exists() then
            return Lsp.biome_config_path()
          end

          return vim.fn.stdpath("config")
        end,
        keys = {
          {
            "<leader>cb",
            function()
              -- NOTE:Migrate to LSP later if it's available
              local file = vim.fn.fnameescape(vim.fn.expand("%:p")) -- Escape file path for shell
              vim.cmd("silent !biome lint --apply-unsafe " .. file)
            end,
            desc = "Biome apply unsafe check",
          },
        },
      },
    },
    setup = {},
  },
}
