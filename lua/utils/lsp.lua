local Path = require("utils.path")

local M = {}

--- Get the path of the config file in the current directory or the root of the git repo
---@param filename string
---@return string | nil
local function get_config_path(filename)
  local current_dir = vim.fn.getcwd()
  local config_file = current_dir .. "/" .. filename
  if vim.fn.filereadable(config_file) == 1 then
    return current_dir
  end

  -- If the current directory is a git repo, check if the root of the repo
  -- contains a biome.json file
  local git_root = Path.get_git_root()
  if Path.is_git_repo() and git_root ~= current_dir then
    config_file = git_root .. "/" .. filename
    if vim.fn.filereadable(config_file) == 1 then
      return git_root
    end
  end

  return nil
end

M.stop_lsp_client_by_name = function(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in ipairs(clients) do
    if client.name == name then
      vim.lsp.stop_client(client.id, true)
      vim.notify("Stopped LSP client: " .. name)
      return
    end
  end
  vim.notify("No active LSP client with name: " .. name)
end

M.biome_config_path = function()
  return get_config_path("biome.json")
end

M.biome_config_exists = function()
  local has_config = get_config_path("biome.json")
  return has_config ~= nil
end

M.dprint_config_path = function()
  return get_config_path("dprint.json")
end

M.dprint_config_exist = function()
  local has_config = get_config_path("dprint.json")
  return has_config ~= nil
end

M.deno_config_exist = function()
  local has_config = get_config_path("deno.json")
  return has_config ~= nil
end

M.eslint_config_exists = function()
  local current_dir = vim.fn.getcwd()
  local config_files =
    { ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json", ".eslintrc" }

  for _, file in ipairs(config_files) do
    local config_file = current_dir .. "/" .. file
    if vim.fn.filereadable(config_file) == 1 then
      return true
    end
  end

  -- If the current directory is a git repo, check if the root of the repo
  -- contains a eslint config file
  local git_root = Path.get_git_root()
  if Path.is_git_repo() and git_root ~= current_dir then
    for _, file in ipairs(config_files) do
      local config_file = git_root .. "/" .. file
      if vim.fn.filereadable(config_file) == 1 then
        return true
      end
    end
  end

  return false
end

return M
