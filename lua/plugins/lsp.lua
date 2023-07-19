-- disable lsp-inlayhints if that is nightly version, will remove when 0.10.0 is stable
local enabled_inlay_hints = true
if vim.fn.has("nvim-0.10.0") == 1 then
  enabled_inlay_hints = false
end

return {
  {
    "lvimuser/lsp-inlayhints.nvim",
    ft = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescriptreact", "svelte", "go" },
    enabled = enabled_inlay_hints,
    opts = {
      debug_mode = true,
    },
    config = function(_, options)
      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, bufnr)
        end,
      })
      require("lsp-inlayhints").setup(options)
      -- define key map for toggle inlay hints: require('lsp-inlayhints').toggle()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>uh",
        "<cmd>lua require('lsp-inlayhints').toggle()<CR>",
        { noremap = true, silent = true, desc = "Toggle Inlay Hints" }
      )
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = true,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      -- Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = {
      -- LSP finder - Find the symbol's definition
      { "glf", "<cmd>Lspsaga lsp_finder<CR>", desc = "LSP Finder" },
      -- Code action
      { "gla", "<cmd>Lspsaga code_action<CR>", desc = "Code Action" },
      -- Rename all occurrences of the hovered word for the entire file
      { "glr", "<cmd>Lspsaga rename<CR>", desc = "Rename" },
      -- Peek definition
      { "glp", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
      -- Go to definition
      { "gld", "<cmd>Lspsaga goto_definition<CR>", desc = "Go to Definition" },
      -- Go to type definition
      { "glt", "<cmd>Lspsaga goto_type_definition<CR>", desc = "Go to Type Definition" },
      -- Toggle Outline
      { "glo", "<cmd>Lspsaga outline<CR>", desc = "Toggle Outline" },
      -- Hover Doc
      { "glh", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover Doc" },
      { "gh", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover Doc" },
    },
  },
  {
    -- Displaying references and definition infos upon functions like JB's IDEA.
    "VidocqH/lsp-lens.nvim",
    event = "BufRead",
    opts = {
      include_declaration = true, -- Reference include declaration
      sections = { -- Enable / Disable specific request
        definition = false,
        references = true,
        implementation = false,
      },
    },
    keys = {
      {
        -- LspLensToggle
        "<leader>uL",
        "<cmd>LspLensToggle<CR>",
        desc = "LSP Len Toggle",
      },
    },
  },
  {
    -- Dim the unused variables and functions using lsp and treesitter.
    "narutoxy/dim.lua",
    event = "BufRead",
    dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
    config = true,
  },
}
