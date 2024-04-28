local Lsp = require("utils.lsp")

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "dprint" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        dprint = {
          root_dir = require("lspconfig").util.root_pattern("dprint.json"),
        },
      },
      setup = {
        -- Disable dprint if not found config
        dprint = function()
          local has_config = Lsp.dprint_config_exist()
          if not has_config then
            return true
          end
        end,
      },
    },
  },
}
