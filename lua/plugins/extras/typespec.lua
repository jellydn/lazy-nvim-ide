return {
  -- Need to install with nodejs, e.g: npm install -g @typespec/compiler
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsp_server = {},
      },
    },
  },
}
