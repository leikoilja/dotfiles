local M = {}

M.octo_menu = function()
  local buf_num = vim.fn.bufnr()
  local handler
  if octo_buffers[buf_num] then
    local picker = require("github.picker")
    handler = picker.show
  else
    handler = require("octo.commands").actions
  end

  handler()
end

return M
