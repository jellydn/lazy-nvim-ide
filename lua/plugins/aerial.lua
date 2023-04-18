-- Silent keymap option
local opts = { silent = true }

return {
  "stevearc/aerial.nvim",
  keys = {
    { "<leader>a", "<cmd>AerialToggle<cr>", desc = "AerialToggle" },
    {
      "<leader>fi",
      "<cmd>Telescope aerial<cr>",
      desc = "Telescope Aerial",
    },
  },
  config = function()
    local status_ok, aerial = pcall(require, "aerial")
    if not status_ok then
      return
    end

    aerial.setup({
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })

        vim.keymap.set("n", "<leader>fi", "<cmd>Telescope aerial<CR>", opts)
      end,
    })

    local tele_status_ok, telescope = pcall(require, "telescope")
    if not tele_status_ok then
      return
    end

    telescope.load_extension("aerial")
  end,
}
