local root_dir_cache = nil

--- Get the git root directory
---@return string|nil The git root directory
local function get_root_dir()
  if root_dir_cache == nil then
    local root_dir =
      require("plenary.job"):new({ command = "git", args = { "rev-parse", "--show-toplevel" } }):sync()[1]
    if root_dir == nil then
      return vim.uv.cwd()
    end
    root_dir_cache = root_dir
  end

  return root_dir_cache
end

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
          harpoon:list():append()
        end,
        desc = "Harpoon Add File",
      },
    },
    opts = {
      settings = {
        save_on_toggle = false,
        sync_on_ui_close = false,
        key = get_root_dir,
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

      -- Change to current file directory with <leader>cD and reset the root directory cache
      vim.keymap.set("n", "<leader>cD", function()
        root_dir_cache = nil
        vim.cmd("cd " .. get_root_dir())
      end, { noremap = true, silent = true, desc = "Change to current directory" })

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
