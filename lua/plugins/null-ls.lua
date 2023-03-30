local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local b = null_ls.builtins

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

-- formatters
return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "mason.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    local sources = {

      -- spell check
      -- b.code_actions.cspell,
      -- b.diagnostics.cspell,
      b.diagnostics.codespell,
      b.diagnostics.misspell,
      b.diagnostics.write_good,
      b.code_actions.proselint,

      -- webdev stuff
      b.formatting.rustywind.with({
        filetypes = { "html", "css", "javascriptreact", "typescriptreact", "svelte" },
      }),
      b.code_actions.eslint_d.with({
        filetypes = { "javascript", "javascriptreact", "vue", "typescript", "typescriptreact", "svelte" },
        condition = function()
          return eslint_config_exists() and not rome_config_exists()
        end,
      }),
      b.diagnostics.eslint_d.with({
        filetypes = { "javascript", "javascriptreact", "vue", "typescript", "typescriptreact", "svelte" },
        condition = function()
          return eslint_config_exists() and not rome_config_exists()
        end,
      }),
      b.formatting.eslint_d.with({
        filetypes = { "javascript", "javascriptreact", "vue", "typescript", "typescriptreact", "svelte" },
        condition = function()
          return eslint_config_exists() and not rome_config_exists()
        end,
      }),
      b.formatting.deno_fmt.with({
        filetypes = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescriptreact" },
        condition = function()
          return deno_config_exists()
        end,
      }),
      b.formatting.rome.with({
        condition = function()
          return rome_config_exists() and not eslint_config_exists() and not deno_config_exists()
        end,
      }),
      b.formatting.prettierd.with({
        filetypes = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescriptreact", "svelte" },
        condition = function()
          return not rome_config_exists() and not deno_config_exists()
        end,
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
    }
    return {
      sources = sources,
    }
  end,
}
