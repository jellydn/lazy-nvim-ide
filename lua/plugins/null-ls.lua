local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local b = null_ls.builtins
local h = require("null-ls.helpers")
local u = require("null-ls.utils")

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", false, true)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  local current_dir = vim.fn.getcwd()
  local config_file = current_dir .. "/package.json"
  if vim.fn.filereadable(config_file) == 1 then
    if vim.fn.json_decode(vim.fn.readfile(config_file))["eslintConfig"] then
      return true
    end
  end

  return false
end

local function rome_config_exists()
  local current_dir = vim.fn.getcwd()
  local config_file = current_dir .. "/rome.json"
  if vim.fn.filereadable(config_file) == 1 then
    return true
  end

  return false
end

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
      print("Found git repo, stopping search" .. current_dir)
      return nil
    end
    current_dir = vim.fn.fnamemodify(current_dir, ":h")
    search_count = search_count + 1
  end

  print("Reached max search count, stopping search" .. current_dir)
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
    -- "package.json", ignore package.json for monorepo as the prettier config is usually in the root
  }

  for _, file in ipairs(prettier_files) do
    local dir = find_upwards(file)
    if dir then
      print("Found prettier config in " .. dir .. " directory")
      return dir
    end
  end

  return nil
end

-- formatters
return {
  "jose-elias-alvarez/null-ls.nvim",
  keys = {
    { "<leader>cn", "<cmd>NullLsInfo<cr>", desc = "NullLs Info" },
  },
  dependencies = { "mason.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    local sources = {

      -- spell check
      -- b.code_actions.cspell,
      -- b.diagnostics.cspell,
      -- b.diagnostics.write_good,
      b.diagnostics.codespell,
      b.diagnostics.misspell,
      b.code_actions.proselint,

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
      -- romejs
      b.formatting.rome.with({
        condition = function()
          return rome_config_exists() and not eslint_config_exists() and not deno_config_exists()
        end,
      }),
      -- prettier
      b.formatting.prettierd.with({
        filetypes = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescriptreact", "svelte" },
        condition = function()
          return not rome_config_exists() and not deno_config_exists() and prettier_config_dir()
        end,
        generator_opts = {
          cwd = h.cache.by_bufnr(function(params)
            return prettier_config_dir()
              or u.root_pattern(
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
                "package.json"
              )(params.bufname)
          end),
        },
      }),

      -- Lua
      b.formatting.stylua,

      -- rust
      b.formatting.rustfmt.with({
        extra_args = { "--edition", "2018" },
      }),

      -- go
      b.diagnostics.revive,
      b.formatting.gofmt,

      -- proto buf
      b.diagnostics.protolint,

      -- python
      b.diagnostics.ruff,
      b.formatting.ruff,
    }

    return {
      sources = sources,
    }
  end,
}
