return {
  {
    "heavenshell/vim-jsdoc",
    ft = "javascript,typescript,typescriptreact,svelte",
    cmd = "JsDoc",
    keys = {
      { "<leader>d", "<cmd>JsDoc<cr>", desc = "JsDoc" },
    },
    build = "make install",
    vscode = true,
  },
}
