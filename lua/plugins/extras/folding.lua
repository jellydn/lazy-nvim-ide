--- Show total number of lines in a fold
local folding_handler = function(virtual_text, left_number, end_line_number, width, truncate)
  local new_virtual_text = {}
  local suffix = (" 󰁂 %d "):format(end_line_number - left_number)
  local suffix_width = vim.fn.strdisplaywidth(suffix)
  local target_width = width - suffix_width
  local current_width = 0
  for _, chunk in ipairs(virtual_text) do
    local chunk_text = chunk[1]
    local chunk_width = vim.fn.strdisplaywidth(chunk_text)
    if target_width > current_width + chunk_width then
      table.insert(new_virtual_text, chunk)
    else
      chunk_text = truncate(chunk_text, target_width - current_width)
      local hl_group = chunk[2]
      table.insert(new_virtual_text, { chunk_text, hl_group })
      chunk_width = vim.fn.strdisplaywidth(chunk_text)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if current_width + chunk_width < target_width then
        suffix = suffix .. (" "):rep(target_width - current_width - chunk_width)
      end
      break
    end
    current_width = current_width + chunk_width
  end
  table.insert(new_virtual_text, { suffix, "MoreMsg" })
  return new_virtual_text
end

return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    opts = {
      fold_virt_text_handler = folding_handler,
      -- Use treesitter as a main provider
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },
  },
  -- Folding preview, by default h and l keys are used.
  -- On first press of h key, when cursor is on a closed fold, the preview will be shown.
  -- On second press the preview will be closed and fold will be opened.
  -- When preview is opened, the l key will close it and open fold. In all other cases these keys will work as usual.
  {
    "anuvyklack/fold-preview.nvim",
    event = "BufReadPost",
    dependencies = "anuvyklack/keymap-amend.nvim",
    config = true,
  },
}
