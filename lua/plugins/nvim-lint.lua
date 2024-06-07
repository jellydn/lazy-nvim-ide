-- Run linter manual per buffer
-- @param name The name of the linter to run.
local function run_linter_by(name)
  -- Refer for more details https://github.com/mfussenegger/nvim-lint/issues/22#issuecomment-841415438
  require("lint").try_lint(name)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.cmd(string.format("augroup au_%s_lint_%d", name, bufnr))
  vim.cmd("au!")
  vim.cmd(string.format("au BufWritePost <buffer=%d> lua require'lint'.try_lint('%s')", bufnr, name))
  vim.cmd(string.format("au BufEnter <buffer=%d> lua require'lint'.try_lint('%s')", bufnr, name))
  vim.cmd("augroup end")
end

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- markdown = { "markdownlint" },
        -- Need to install golangci-lint
        -- e.g: brew install golangci-lint
        go = { "golangcilint" },
        python = { "ruff" },
        ["*"] = { "cspell", "codespell" },
        javascript = { "oxlint" },
        typescript = { "oxlint" },
        javascriptreact = { "oxlint" },
        typescriptreact = { "oxlint" },
      },
    },
    keys = {
      {
        -- Run lint by name
        "<leader>rl",
        function()
          local items = {
            -- Github actions
            "actionlint", -- go install github.com/rhysd/actionlint/cmd/actionlint@latest
            -- .env files
            "dotenv_linter", -- brew install dotenv-linter
            -- Markdown and writing
            "write_good", -- npm install -g write-good
          }

          vim.ui.select(items, {
            prompt = "Select Linter to run",
          }, function(choice)
            if choice ~= nil then
              run_linter_by(choice)
            end
          end)
        end,
        desc = "Run Nvim Lint",
      },
      -- Fix .env variables
      {
        "<leader>fv",
        function()
          local file = vim.fn.fnameescape(vim.fn.expand("%:p")) -- Escape file path for shell

          -- Warn user if file is not .env
          if not string.match(file, "%.env") then
            vim.notify("This is not a .env file", vim.log.levels.WARN)
            return
          end

          vim.cmd("silent !dotenv-linter fix " .. file)
        end,
        desc = "dotenv linter - fix",
      },
    },
  },
}
