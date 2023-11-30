local function deno_config_exists()
  local current_dir = vim.fn.getcwd()
  local config_file = current_dir .. "/deno.json"
  if vim.fn.filereadable(config_file) == 1 then
    return true
  end

  local jsonc_file = current_dir .. "/deno.jsonc"
  if vim.fn.filereadable(jsonc_file) == 1 then
    return true
  end

  return false
end

-- Helper function to traverse up directory tree and find if a file exists
local function find_upwards(filename)
  local current_dir = vim.fn.expand("%:p:h")
  local search_count = 0

  local max_search = 10 -- search up to parent directories
  while current_dir ~= "/" and search_count < max_search do
    if vim.loop.fs_stat(current_dir .. "/" .. filename) then
      return current_dir
    end
    -- stop find if we reach a git repo
    if vim.loop.fs_stat(current_dir .. "/.git") then
      return nil
    end
    current_dir = vim.fn.fnamemodify(current_dir, ":h")
    search_count = search_count + 1
  end

  return nil
end

local function prettier_config_dir()
  local prettier_files = {
    -- List of possible Prettier config files
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.toml",
    "prettier.config.js",
    "prettier.config.cjs",
    "prettier.config.mjs",
    -- "package.json", ignore package.json for monorepo as the prettier config is usually in the root
  }

  for _, file in ipairs(prettier_files) do
    local dir = find_upwards(file)
    if dir then
      return dir
    end
  end

  return nil
end

local function biome_config_exists()
  local current_dir = vim.fn.getcwd()
  local config_file = current_dir .. "/biome.json"
  if vim.fn.filereadable(config_file) == 1 then
    return true
  end

  return false
end

-- formatters
return {
  { import = "lazyvim.plugins.extras.lsp.none-ls" },
  {
    "nvimtools/none-ls.nvim",
    keys = {
      { "<leader>cn", "<cmd>NullLsInfo<cr>", desc = "NullLs Info" },
    },
    dependencies = {
      "mason.nvim",
      { "davidmh/cspell.nvim" },
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local cspell = require("cspell")
      local none_ls = require("null-ls")
      local b = none_ls.builtins
      local sources = {

        -- spell check
        b.diagnostics.codespell,
        b.diagnostics.misspell,
        -- cspell
        cspell.diagnostics.with({
          -- Set the severity to HINT for unknown words
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity["HINT"]
          end,
          read_config_synchronously = false,
        }),
        cspell.code_actions.with({
          read_config_synchronously = false,
        }),

        -- tailwind
        b.formatting.rustywind.with({
          filetypes = { "html", "css", "javascriptreact", "typescriptreact", "svelte" },
        }),

        -- deno
        b.formatting.deno_fmt.with({
          filetypes = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescriptreact" },
          condition = function()
            return deno_config_exists()
          end,
        }),
        -- prettier
        b.formatting.prettier.with({
          condition = function()
            return not deno_config_exists() and not biome_config_exists() and prettier_config_dir()
          end,
        }),

        -- biome
        b.formatting.biome.with({
          condition = function()
            return biome_config_exists() and not prettier_config_dir() and not deno_config_exists()
          end,
        }),

        -- Lua
        b.formatting.stylua,

        -- proto buf
        b.diagnostics.protolint, -- brew tap yoheimuta/protolint && brew install protolint

        -- Markdown
        b.diagnostics.markdownlint,

        -- Php - comment out as I don't use php much
        -- b.formatting.pint,
      }

      return {
        sources = sources,
        debounce = 200,
        debug = true,
      }
    end,
  },
}
