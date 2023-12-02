return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint" },
        ["*"] = { "cspell", "codespell" },
      },
    },
    linters = {
      cspell = {
        parser = function(output)
          local efm = "%f:%l:%c - %m"
          local lines = vim.split(output, "\n")
          local qflist = vim.fn.getqflist({ efm = efm, lines = lines })
          local result = {}
          for _, item in pairs(qflist.items) do
            if item.valid == 1 then
              local message = item.text:match("^%s*(.-)%s*$")
              local word = message:match("%(.*%)")
              local lnum = math.max(0, item.lnum - 1)
              local col = math.max(0, item.col - 1)
              local end_lnum = item.end_lnum > 0 and (item.end_lnum - 1) or lnum
              local end_col = col + word:len() - 2 or col
              local diagnostic = {
                lnum = lnum,
                col = col,
                end_lnum = end_lnum,
                end_col = end_col,
                message = message,
                source = "cspell",
                severity = vim.diagnostic.severity.INFO,
              }
              table.insert(result, diagnostic)
            end
          end
          return result
        end,
      },
    },
  },
}
