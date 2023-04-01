local create_cmd = vim.api.nvim_create_user_command

local function setProjectRootByCurrentBuffer()
  -- get path by test file
  local path = vim.fn.expand("%:p:h")
  -- find up to 5 levels to find package.json
  for i = 1, 5 do
    local package_json = path .. "/package.json"
    if vim.fn.filereadable(package_json) == 1 then
      break
    end
    path = vim.fn.fnamemodify(path, ":h")
  end

  -- set project root
  vim.g["test#project_root"] = path
end

-- TODO: find vitest or jest on devDependencies or dependencies package.json and set test#javascript#runner

-- Usage: :TestWithJest when in test file or :TestWithVitest when in test file
-- vim-test plugin has not supported on large project or monorepo yet. A lot of issues on github
-- e.g: "Not a test file" error when running any of the test command
create_cmd("JestRunner", function()
  setProjectRootByCurrentBuffer()
  vim.g["test#javascript#runner"] = "jest"

  -- set npx jest to run test
  vim.g["test#javascript#jest#executable"] = "npx jest"
  vim.g["test#javascript#jest#options"] = "--detectOpenHandles --updateSnapshot"

  vim.cmd("TestNearest")
end, {})

create_cmd("VitestRunner", function()
  setProjectRootByCurrentBuffer()
  vim.g["test#javascript#runner"] = "vitest"

  -- set npx vitest to run test
  vim.g["test#javascript#vitest#executable"] = "npx vitest"
  vim.g["test#javascript#vitest#options"] = "--update"

  vim.cmd("TestNearest")
end, {})

return {
  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite" },
    keys = {
      { "<leader>ct", "<cmd>TestNearest<cr>", desc = "Run Test Nearest" },
      { "<leader>cT", "<cmd>TestFile<cr>", desc = "Run Test File" },
      { "<leader>cS", "<cmd>TestSuite<cr>", desc = "Run Test Suite" },
    },
    config = function()
      local tt = require("toggleterm")
      local ttt = require("toggleterm.terminal")

      vim.g["test#custom_strategies"] = {
        tterm = function(cmd)
          tt.exec(cmd)
        end,

        tterm_close = function(cmd)
          local term_id = 0
          tt.exec(cmd, term_id)
          ttt.get_or_create_term(term_id):close()
        end,
      }

      vim.g["test#strategy"] = "tterm"

      -- add -A to deno test
      vim.g["test#javascript#denotest#options"] = "-A"
    end,
  },
}
