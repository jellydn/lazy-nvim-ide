--- Create custom command
---@param cmd string The command name
---@param func function The function to execute
---@param opt table The options
local function create_cmd(cmd, func, opt)
  opt = vim.tbl_extend("force", { desc = "my-lazy-ide " .. cmd }, opt or {})
  vim.api.nvim_create_user_command(cmd, func, opt)
end

return {
  create_cmd = create_cmd,
}
