local servers = {
  "lua_ls",
  -- web
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
  -- svelte
  "svelte",
  -- python
  "pyright",
  "ruff_lsp",
}

return {
  -- cmdline tools and lsp servers
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        -- formatters
        "eslint_d",
        "prettierd",
        -- code spell
        "codespell",
        "misspell",
        -- rustywind for tailwindcss
        "rustywind",
        -- python
        "ruff",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
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

        -- load server specific config if exists
        local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
        if require_ok then
          lsp_opts = vim.tbl_deep_extend("force", conf_opts, opts)
        end

        lspconfig[server].setup(lsp_opts)
      end
    end,
  },
}
