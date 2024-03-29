return {
  -- Disable telescope
  { "nvim-telescope/telescope.nvim", enabled = false },
  {
    "ibhagwan/fzf-lua", -- NOTE: The github repo is removed, use the gitlab repo
    url = "https://gitlab.com/ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    event = "VeryLazy",
    config = function()
      local fzf_lua = require("fzf-lua")
      fzf_lua.setup({
        "fzf-native", -- max-perf
        hls = {
          border = "FloatBorder",
        },
        -- History file
        fzf_opts = {
          ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
          ["--info"] = false,
          ["--border"] = false,
          ["--preview-window"] = false,
        },
        -- Max performance
        winopts = {
          preview = { default = "bat_native" },
        },
        files = {
          git_icons = false,
          file_icons = false,
        },
      })

      -- Automatic sizing of height/width of vim.ui.select
      fzf_lua.register_ui_select(function(_, items)
        local min_h, max_h = 0.60, 0.80
        local h = (#items + 4) / vim.o.lines
        if h < min_h then
          h = min_h
        elseif h > max_h then
          h = max_h
        end
        return { winopts = { height = h, width = 0.80, row = 0.40 } }
      end)

      -- Refer https://github.com/ibhagwan/fzf-lua/issues/602
      vim.lsp.handlers["textDocument/codeAction"] = fzf_lua.lsp_code_actions
      vim.lsp.handlers["textDocument/definition"] = fzf_lua.lsp_definitions
      vim.lsp.handlers["textDocument/declaration"] = fzf_lua.lsp_declarations
      vim.lsp.handlers["textDocument/typeDefinition"] = fzf_lua.lsp_typedefs
      vim.lsp.handlers["textDocument/implementation"] = fzf_lua.lsp_implementations
      vim.lsp.handlers["textDocument/references"] = fzf_lua.lsp_references
      vim.lsp.handlers["textDocument/documentSymbol"] = fzf_lua.lsp_document_symbols
      vim.lsp.handlers["workspace/symbol"] = fzf_lua.lsp_workspace_symbols
      vim.lsp.handlers["callHierarchy/incomingCalls"] = fzf_lua.lsp_incoming_calls
      vim.lsp.handlers["callHierarchy/outgoingCalls"] = fzf_lua.lsp_outgoing_calls
    end,
    keys = {
      {
        "<leader>fg",
        "<cmd> :FzfLua grep_project<CR>",
        desc = "Find Grep",
      },
      {
        "<leader>fG",
        "<cmd> :FzfLua grep_project --cmd 'git grep --line-number --column --color=always'<CR>",
        desc = "Find Git Grep",
      },
      {
        "<leader>ff",
        function()
          require("fzf-lua").files({ cwd_prompt = false })
        end,
        desc = "Find Files",
      },
      {
        "<leader>fF",
        "<cmd> :FzfLua git_files<CR>",
        desc = "Find Git Files",
      },
      {
        "<leader>fa",
        "<cmd> :FzfLua commands<CR>",
        desc = "Find Actions",
      },
      {
        "<leader>f;",
        "<cmd> :FzfLua command_history<CR>",
        desc = "Find Command History",
      },
      {
        "<leader>fc",
        function()
          require("fzf-lua").files({ cwd = "~/.config/nvim" })
        end,
        desc = "Find Neovim Configs",
      },
      {
        "<leader>fC",
        "<cmd> :FzfLua git_bcommits<CR>",
        desc = "Find Commits",
      },
      {
        "<leader>fb",
        "<cmd> :FzfLua buffers<CR>",
        desc = "Find Buffers",
      },
      {
        "<leader>fr",
        "<cmd> :FzfLua oldfiles<CR>",
        desc = "Find Recent Files",
      },
      {
        "<leader>fk",
        "<cmd> :FzfLua keymaps<CR>",
        desc = "Find Keymaps",
      },
      {
        "<leader>fm",
        "<cmd> :FzfLua marks<CR>",
        desc = "Find Marks",
      },
      {
        "<leader>fl",
        "<cmd> :FzfLua live_grep<CR>",
        desc = "Find Live Grep",
      },
      {
        "<leader>ft",
        "<cmd> :FzfLua tmux_buffers<CR>",
        desc = "Find Tmux buffers",
      },
      {
        "<leader>fT",
        "<cmd> :FzfLua colorschemes<CR>",
        desc = "Find Theme",
      },
      {
        "<leader>fh",
        "<cmd> :FzfLua help_tags<CR>",
        desc = "Find Help",
      },
      {
        "<leader>fq",
        "<cmd> :FzfLua quickfix<CR>",
        desc = "Find Quickfix",
      },
      {
        "<leader>fw",
        "<cmd> :FzfLua grep_cword<CR>",
        desc = "Find word under cursor",
      },
      {
        "<leader>fW",
        "<cmd> :FzfLua grep_cWORD<CR>",
        desc = "Find WORD under cursor",
      },
      -- Resume last fzf command
      {
        "<leader>fR",
        "<cmd> :FzfLua resume<CR>",
        desc = "Resume Fzf",
      },
      -- Open files at the current working directory
      {
        "<leader><leader>",
        function()
          local cwd = vim.uv.cwd()
          require("fzf-lua").files({ cwd = cwd, cwd_prompt = false })
        end,
        desc = "Find Files at CWD",
      },
      -- Search in current buffer
      {
        "<leader>sb",
        "<cmd> :FzfLua grep_curbuf<CR>",
        desc = "Search Current Buffer",
      },
      -- Search in git status
      {
        "<leader>gs",
        "<cmd> :FzfLua git_status<CR>",
        desc = "Git Status",
      },
      {
        "<leader>ss",
        "<cmd> :FzfLua lsp_document_symbols<CR>",
        desc = "LSP Document Symbols",
      },
      {
        "<leader>sw",
        "<cmd> :FzfLua lsp_workspace_symbols<CR>",
        desc = "LSP Workspace Symbols",
      },
      {
        "<leader>sc",
        "<cmd> :FzfLua lsp_code_actions<CR>",
        desc = "LSP Code Actions",
      },
      -- Search in recent projects
      {
        "<leader>fp",
        function()
          local fzf_lua = require("fzf-lua")
          local history = require("project_nvim.utils.history")
          local results = history.get_recent_projects()
          fzf_lua.fzf_exec(results, {
            actions = {
              ["default"] = {
                function(selected)
                  fzf_lua.files({ cwd = selected[1] })
                end,
              },
            },
          })
        end,
        desc = "Search Recent Projects",
      },
    },
  },
  -- Setup LSP for fzf-lua
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change keymap to use FzfLua
      keys[#keys + 1] = {
        "gr",
        ":lua require('fzf-lua').lsp_references({ ignore_current_line = true, jump_to_single_result = true }) <CR>",
      }
      keys[#keys + 1] = { "gd", "<cmd> FzfLua lsp_definitions <CR>", desc = "Go to definition" }
      keys[#keys + 1] = { "gD", "<cmd> FzfLua lsp_declarations <CR>", desc = "Go to declaration" }
      keys[#keys + 1] = { "gI", "<cmd> FzfLua lsp_implementations <CR>", desc = "Go to implementation" }
      keys[#keys + 1] = { "gT", "<cmd> FzfLua lsp_typedefs <CR>", desc = "Go to type definition" }
      keys[#keys + 1] = { "gF", "<cmd> FzfLua lsp_finder <CR>", desc = "LSP Finder" }
    end,
  },
}
