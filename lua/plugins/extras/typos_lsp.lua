return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ensure typos_lsp is installed, refer https://github.com/tekumara/typos-vscode
        typos_lsp = {
          cmd = {
            "typos-lsp",
          },
          init_options = {},
        },
      },
      setup = {},
    },
  },
}
