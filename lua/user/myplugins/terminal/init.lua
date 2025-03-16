local M = {}

--- Open terninal and send content to it
---@param command string
function M.toggle_terminal(command)

  local term_buf = nil
  -- Iterate through all buffers and check if it's a terminal buffer
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_get_option_value('buftype', { buf = buf }) == 'terminal' then
      local win = vim.fn.bufwinid(buf)
      if win ~= -1 then
        vim.api.nvim_set_current_win(win)
      else
        vim.api.nvim_set_current_buf(buf)
      end
      vim.cmd('startinsert')

      term_buf = buf
      break
    end
  end

  if term_buf == nil then
    -- If no terminal buffer is found, open a new terminal
    vim.cmd('vsplit')
    vim.cmd('term')

    term_buf = vim.api.nvim_get_current_buf()
  end

  if command ~= nil then
    local term_channel = vim.bo[term_buf].channel
    if term_channel then
      vim.api.nvim_chan_send(term_channel, command)
    end
  end

  vim.cmd('startinsert')
end

function M.add_command(value, callback)
  local harpoon = require('harpoon')
  harpoon:list('cmd'):clear()

  harpoon:list('cmd'):add({
    value = value,
    context = {
      callback = callback
    }
  })
end

return M
