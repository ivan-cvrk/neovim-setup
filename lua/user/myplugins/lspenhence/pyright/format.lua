local function format(bufnr)
    vim.notify('Called formatfile!')
    local channel = vim.fn.jobstart({ 'autopep8', '-' }, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data)
            end
        end,
    })
    local bufdata = vim.api.nvim_buf_get_text(bufnr, 0, 0, -1, -1, {})
    table.insert(bufdata, '')
    vim.fn.chansend(channel, bufdata)
    vim.fn.chanclose(channel, 'stdin')
end

local M = {}
M.attachformat = function(bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '', {
        noremap = true,
        callback = function() format(bufnr) end
    })
end

return M
