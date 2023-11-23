return {
  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    opts = {},
    keys = {
      {
        "<leader>tn",
        function()
          require("ts-node-action").node_action()
        end,
        desc = "Trigger TSNodeAction",
      },
    },
  },
}
