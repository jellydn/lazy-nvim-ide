return {
  -- Rust
  {
    "simrat39/rust-tools.nvim",
    -- lazy-load on filetype
    ft = "rust",
    config = function()
      local rt = require("rust-tools")
      rt.setup({
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set(
              "n",
              "<Leader>ch",
              rt.hover_actions.hover_actions,
              { buffer = bufnr, desc = "Rust - Hover actions" }
            )
          end,
        },
      })
    end,
  },
}
