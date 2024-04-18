-- [[
-- Use <c-e> or :q! to kill the floating window
-- <up/down> (or <c-n>, <c-p>) to move
-- <c-o> or <CR> to open location or apply code actions. Note: <CR> might be bound in insert mode by other plugins
-- ]]
return {
  {
    "ray-x/navigator.lua",
    event = "LspAttach",
    dependencies = {
      { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
      {
        "neovim/nvim-lspconfig",
      },
    },
    opts = {
      default_mapping = false,
      lsp = {
        disable_lsp = "all",
        hover = {
          enable = false,
        },
      },
    },
    -- Refer more usage on https://raw.githubusercontent.com/ray-x/navigator.lua/master/lua/navigator/lspclient/mapping.lua
    keys = {
      { "<leader>gr", ":lua require'navigator.reference'.async_ref()<cr>", desc = "Navigator - Async reference" },
      { "<leader>gS", ":lua require'navigator.symbols'.document_symbols()<cr>", desc = "Navigator - Document symbols" },
      {
        "<leader>gw",
        ":lua require'navigator.workspace'.workspace_symbol_live()<cr>",
        desc = "Navigator - workspace symbols live",
      },
      { "<leader>gd", ":lua require'navigator.definition'.definition()<cr>", desc = "Navigator - Definition" },
      {
        "<leader>gp",
        ":lua require'navigator.definition'.definition_preview()<cr>",
        desc = "Navigator - Definition preview",
      },
      { "<leader>ga", ":lua require'navigator.codeAction'.code_action()<cr>", desc = "Navigator - Code Action" },
    },
  },
}
