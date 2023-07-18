return {
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
}
