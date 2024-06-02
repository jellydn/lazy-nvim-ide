return {
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, "lspsagaoutline")
    end,
  },
  -- Setup LSP Saga
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    opts = {
      -- Disable lightbulb and symbol in winbar
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        enable = false,
      },
      -- Show LSP server name
      code_action = {
        show_server_name = true,
      },
      -- Open definition with "o" key
      definition = {
        keys = {
          edit = "o",
        },
      },
      callhierarchy = {
        keys = {
          edit = "o",
        },
      },
      -- Set max height for finder
      finder = {
        max_height = 0.6,
        methods = {
          tyd = "textDocument/typeDefinition",
        },
      },
      -- Disable auto preview and detail in outline
      outline = {
        auto_preview = false,
        detail = false,
      },
    },
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    -- Group LspSaga keymap with prefix "gl"
    keys = {
      -- LSP Finder
      { "glf", "<cmd>Lspsaga finder<CR>", desc = "LSP Finder" },
      -- Go to definition
      { "gld", "<cmd>Lspsaga goto_definition<CR>", desc = "Go to Definition" },
      -- Go to type definition
      { "glt", "<cmd>Lspsaga goto_type_definition<CR>", desc = "Go to Type Definition" },
      -- Peek definition
      { "glp", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
      -- Toggle Outline
      { "gls", "<cmd>Lspsaga outline<CR>", desc = "Toggle Outline" },
      -- Hover Doc
      { "glh", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover Doc" },
      -- Incoming call
      { "gli", "<cmd>Lspsaga incoming_calls<CR>", desc = "Incoming Call" },
      -- Outgoing call
      { "glo", "<cmd>Lspsaga outgoing_calls<CR>", desc = "Outgoing Call" },
      -- Code action
      { "gla", "<cmd>Lspsaga code_action<CR>", desc = "Code Action" },
      -- Rename in project
      { "glr", "<cmd>Lspsaga rename<CR>", desc = "Rename" },

      { "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Jump to Next Diagnostic" },
      -- Jump to prev diagnostic
      { "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Jump to Prev Diagnostic" },
      -- Jump to next error
      -- stylua: ignore
      { "]e", function()require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })end, desc = "Jump to Next Error",  },
      -- Jump to next warning
      -- stylua: ignore
      { "]w", function()require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARN })end, desc = "Jump to Next Warning",  },
      -- Jump to next information
      -- stylua: ignore
      { "]i", function()require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.INFO })end, desc = "Jump to Next Information",  },
      -- Jump to next hint
      -- stylua: ignore
      { "]H", function()require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.HINT })end, desc = "Jump to Next Hint",  },
      -- Jump to prev error
      -- stylua: ignore
      { "[e", function()require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })end, desc = "Jump to Prev Error",  },
      -- Jump to prev warning
      -- stylua: ignore
      { "[w", function()require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARN })end, desc = "Jump to Prev Warning",  },
      -- Jump to prev information
      -- stylua: ignore
      { "[i", function()require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.INFO })end, desc = "Jump to Prev Information",  },
      -- Jump to prev hint
      -- stylua: ignore
      { "[H", function()require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.HINT })end, desc = "Jump to Prev Hint",  },
    },
    config = function(_, opts)
      require("lspsaga").setup(opts)

      -- Add which-key mappings
      local wk = require("which-key")
      wk.register({
        g = {
          l = {
            name = "+LSP Saga",
          },
        },
      })
    end,
  },
}
