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
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = { snippet_engine = "luasnip" },
    cmd = "Neogen",
    keys = {
      { "<leader>ng", "<cmd>Neogen<cr>", desc = "Neogen - Annotation generator" },
    },
  },
}
