local servers = {
  "lua_ls",
  -- web
  "rome",
  "tsserver",
  "jsonls",
  "yamlls",
  "html",
  "cssls",
  "tailwindcss",
  "jsonls",
  -- rust
  "rust_analyzer",
  -- go
  "gopls",
  -- deno
  "denols",
  -- svelte
  "svelte",
}

return {
  -- cmdline tools and lsp servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "deno",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(plugin, opts)
      require("mason").setup(opts)
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end

      -- load lsp config
      local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
      if not lspconfig_status_ok then
        return
      end

      local lsp_opts = {}

      for _, server in pairs(servers) do
        lsp_opts = {
          on_attach = require("plugins.lsp.handlers").on_attach,
          capabilities = require("plugins.lsp.handlers").capabilities,
        }

        server = vim.split(server, "@")[1]

        local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
        if require_ok then
          lsp_opts = vim.tbl_deep_extend("force", conf_opts, opts)
        end

        lspconfig[server].setup(lsp_opts)
      end
    end,
  },
}
