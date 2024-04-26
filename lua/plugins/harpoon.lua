return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    keys = {
      {
        "<leader>hh",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon toggle menu",
      },
      {
        "<leader>ha",
        function()
          local harpoon = require("harpoon")
          harpoon:list():add()
        end,
        desc = "Harpoon Add File",
      },
      {
        "<leader>hj",
        function()
          local harpoon = require("harpoon")
          harpoon:list():next()
        end,
        desc = "Harpoon Next",
      },
      {
        "<leader>hk",
        function()
          local harpoon = require("harpoon")
          harpoon:list():prev()
        end,
        desc = "Harpoon Prev",
      },
    },
    opts = {
      settings = {
        save_on_toggle = false,
        sync_on_ui_close = false,
        key = function()
          -- Use the current working directory as the key
          local cwd = require("lazyvim.util").root.cwd()
          return cwd
        end,
      },
    },
    config = function(_, options)
      local status_ok, harpoon = pcall(require, "harpoon")
      if not status_ok then
        return
      end

      ---@diagnostic disable-next-line: missing-parameter
      harpoon.setup(options)
      for i = 1, 4 do
        vim.keymap.set("n", "<leader>" .. i, function()
          require("harpoon"):list():select(i)
        end, { noremap = true, silent = true, desc = "Harpoon select " .. i })
      end

      -- Telescope integration
      local tele_status_ok, _ = pcall(require, "telescope")
      if not tele_status_ok then
        return
      end

      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        if #file_paths == 0 then
          vim.notify("No mark found", vim.log.levels.INFO, { title = "Harpoon" })
          return
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end

      vim.keymap.set("n", "<leader>fm", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Open harpoon window" })
    end,
  },
}
