return {
  {
    "sigmasd/deno-nvim",
    keys = {
      -- add a keymap to browse plugin files
      {
        "<leader>dr",
        function()
          vim.lsp.codelens.refresh()
          vim.lsp.codelens.run()
        end,
        desc = "Deno test with code lens",
      },
    },
    opts = {
      server = {
        root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
        settings = {
          deno = {
            inlayHints = {
              parameterNames = {
                enabled = "all",
              },
              parameterTypes = {
                enabled = true,
              },
              variableTypes = {
                enabled = true,
              },
              propertyDeclarationTypes = {
                enabled = true,
              },
              functionLikeReturnTypes = {
                enabled = true,
              },
              enumMemberValues = {
                enabled = true,
              },
            },
          },
        },
      },
    },
  },
}
