local logo = [[
      ██╗████████╗    ███╗   ███╗ █████╗ ███╗   ██╗
      ██║╚══██╔══╝    ████╗ ████║██╔══██╗████╗  ██║
      ██║   ██║       ██╔████╔██║███████║██╔██╗ ██║
      ██║   ██║       ██║╚██╔╝██║██╔══██║██║╚██╗██║
      ██║   ██║       ██║ ╚═╝ ██║██║  ██║██║ ╚████║
      ╚═╝   ╚═╝       ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
]]

logo = string.rep("\n", 4) .. logo .. "\n\n"

--- Set the limit of most recent files based on the window height
local function mru_limit_by_win_height()
  local height = vim.fn.winheight(0)
  if height >= 40 then
    return 15
  elseif height >= 30 then
    return 10
  else
    return 5
  end
end

return {
  -- Disable telescope
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
  },
  -- Change dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = {
      theme = "hyper",
      config = {
        packages = { enable = false },
        header = vim.split(logo, "\n"),
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = [[lua require('fzf-lua').files({cwd_prompt = false})]],
            key = "f",
          },
          {
            desc = " Text",
            group = "DiagnosticHint",
            action = [[lua require('fzf-lua').live_grep({cwd_prompt = false})]],
            key = "g",
          },
          {
            desc = " Session",
            group = "Label",
            action = [[lua require("persistence").load()]],
            key = "s",
          },
          {
            desc = " Config",
            group = "Number",
            action = [[lua require('fzf-lua').files({ cwd = '~/.config/nvim' })]],
            key = "c",
          },
          {
            desc = " Extras",
            group = "Label",
            action = "LazyExtras",
            icon = " ",
            key = "x",
          },
        },
        footer = function()
          return { "productsway.com" }
        end,
        project = { enable = false },
        mru = { limit = mru_limit_by_win_height(), cwd_only = true },
      },
    },
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
  -- Setup fzf-lua
  {
    "ibhagwan/fzf-lua", -- NOTE: The github repo is removed, use the gitlab repo
    url = "https://gitlab.com/ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      hls = {
        border = "FloatBorder",
        cursorline = "Visual",
        cursorlinenr = "Visual",
      },
      -- History file
      fzf_opts = {
        ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
        ["--info"] = false,
        ["--border"] = false,
        ["--preview-window"] = false,
      },
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.55,
        preview = {
          layout = "flex",
          flip_columns = 130,
          scrollbar = "float",
        },
      },
      files = {
        git_icons = false,
        file_icons = false,
      },
      grep = {
        debug = false,
      },
      git = {
        status = {
          winopts = {
            preview = { vertical = "down:70%", horizontal = "right:70%" },
          },
        },
        commits = { winopts = { preview = { vertical = "down:60%" } } },
        bcommits = { winopts = { preview = { vertical = "down:60%" } } },
        branches = {
          winopts = {
            preview = { vertical = "down:75%", horizontal = "right:75%" },
          },
        },
      },
      lsp = {
        symbols = {
          path_shorten = 1,
        },
        code_actions = {
          winopts = {
            relative = "cursor",
            row = 1,
            col = 0,
            height = 0.4,
            preview = { vertical = "down:70%" },
          },
        },
      },
    },
    config = function(_, options)
      local fzf_lua = require("fzf-lua")
      fzf_lua.setup(options)

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
      -- Files keymaps
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
        "<leader>fc",
        function()
          require("fzf-lua").files({ cwd = "~/.config/nvim" })
        end,
        desc = "Find Neovim Configs",
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
      -- Resume last fzf command
      {
        "<leader>fR",
        "<cmd> :FzfLua resume<CR>",
        desc = "Resume Fzf",
      },
      -- Live Grep, better for large projects
      {
        "<leader>fl",
        "<cmd> :FzfLua live_grep<CR>",
        desc = "Find Live Grep",
      },
      -- Open files at the current working directory
      {
        "<leader><space>",
        function()
          local cwd = vim.uv.cwd()
          require("fzf-lua").files({ cwd = cwd })
        end,
        desc = "Find Files at project directory",
      },
      {
        "<leader>/",
        function()
          local cwd = vim.fn.expand("%:p:h")
          require("fzf-lua").live_grep({ cwd = cwd })
        end,
        desc = "Grep Files at current buffer directory",
      },
      -- Search in current buffer with grep
      {
        "<leader>sb",
        "<cmd> :FzfLua grep_curbuf<CR>",
        desc = "Search Current Buffer",
      },
      {
        "<leader>sw",
        "<cmd> :FzfLua grep_cword<CR>",
        desc = "Find word under cursor",
      },
      {
        "<leader>fW",
        "<cmd> :FzfLua grep_cWORD<CR>",
        desc = "Search WORD under cursor",
      },
      -- Search in git status
      {
        "<leader>gs",
        "<cmd> :FzfLua git_status<CR>",
        desc = "Git Status",
      },
      {
        "<leader>gc",
        "<cmd> :FzfLua git_commits<CR>",
        desc = "Git Commits",
      },
      {
        "<leader>gb",
        "<cmd> :FzfLua git_branches<CR>",
        desc = "Git Branches",
      },
      {
        "<leader>gB",
        "<cmd> :FzfLua git_bcommits<CR>",
        desc = "Git Buffer Commits",
      },
      -- Search keymaps
      {
        "<leader>sa",
        "<cmd> :FzfLua commands<CR>",
        desc = "Find Actions",
      },
      {
        "<leader>s:",
        "<cmd> :FzfLua command_history<CR>",
        desc = "Find Command History",
      },
      {
        "<leader>ss",
        "<cmd> :FzfLua lsp_document_symbols<CR>",
        desc = "LSP Document Symbols",
      },
      {
        "<leader>sS",
        "<cmd> :FzfLua lsp_workspace_symbols<CR>",
        desc = "LSP Workspace Symbols",
      },
      {
        "<leader>sk",
        "<cmd> :FzfLua keymaps<CR>",
        desc = "Search Keymaps",
      },
      {
        "<leader>sm",
        "<cmd> :FzfLua marks<CR>",
        desc = "Search Marks",
      },
      {
        "<leader>st",
        "<cmd> :FzfLua tmux_buffers<CR>",
        desc = "Search Tmux buffers",
      },
      {
        "<leader>sc",
        "<cmd> :FzfLua colorschemes<CR>",
        desc = "Search colorschemes",
      },
      {
        "<leader>sh",
        "<cmd> :FzfLua help_tags<CR>",
        desc = "Search Help",
      },
      {
        "<leader>sq",
        "<cmd> :FzfLua quickfix<CR>",
        desc = "Search Quickfix",
      },
      -- Search in recent projects
      {
        "<leader>fp",
        function()
          local fzf_lua = require("fzf-lua")

          local ok, _ = pcall(require, "project_nvim")
          if not ok then
            vim.notify("Project.nvim is not installed", vim.log.levels.ERROR, { title = "Fzf Lua" })
            return
          end

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
