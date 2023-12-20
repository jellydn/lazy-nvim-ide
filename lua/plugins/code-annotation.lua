local neogeo_opts = {}

if not vim.g.vscode then
  neogeo_opts = {
    enabled = true,
    -- Only use luasnip as snippet engine if that is not vscode
    snippet_engine = "luasnip",
  }
end

return {
  -- JsDoc generator
  {
    "heavenshell/vim-jsdoc",
    ft = "javascript,typescript,typescriptreact,svelte",
    cmd = "JsDoc",
    keys = {
      { "<leader>jd", "<cmd>JsDoc<cr>", desc = "JsDoc" },
    },
    -- make sure that you will have lehre install locally on plugin folder, refer https://github.com/heavenshell/vim-jsdoc#manual-installation
    build = "make install",
  },
  {
    -- A better annotation generator. Supports multiple languages and annotation conventions.
    -- <C-n> to jump to next annotation, <C-p> to jump to previous annotation
    "danymat/neogen",
    vscode = true,
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = neogeo_opts,
    cmd = "Neogen",
    keys = {
      { "<leader>ci", "<cmd>Neogen<cr>", desc = "Neogen - Annotation generator" },
    },
  },
}
