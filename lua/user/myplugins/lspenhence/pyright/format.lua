local function format(bufnr)
    local channel = vim.fn.jobstart({ 'autopep8', '--global-config', vim.env.HOME .. "/.config/autopep8.json", '-' }, {
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

local function configure_formatter(bufnr)
    vim.fn.jobstart({ 'sh', '-c', 'command -v autopep8' }, {
        on_exit = function(_, code)
            if code == 0 then
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '', {
                noremap = true,
                callback = function() format(bufnr) end
            })
            else
                vim.notify('Formatting program \'autopep8\' not found.')
            end
        end
    })
end

local function attachformat(bufnr)
    local sysname = vim.loop.os_uname().sysname
    if sysname == 'Linux' then
        configure_formatter(bufnr)
    else
        vim.notify('Pyright enhence not available for system ' .. sysname)
    end
end

local M = {}
M.attachformat = attachformat
return M
