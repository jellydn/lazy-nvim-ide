-- Silent keymap option
local opts = { silent = true }

return {
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, "aerial")
    end,
  },
  {
    "stevearc/aerial.nvim",
    keys = {
      { "<leader>ta", "<cmd>AerialToggle<cr>", desc = "AerialToggle" },
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

      -- Define a custom command to open aerial with telescope
      vim.keymap.set("n", "<leader>fi", "<cmd>Telescope aerial<CR>", {
        desc = "Telescope Aerial",
      })

      telescope.load_extension("aerial")
    end,
  },
}
