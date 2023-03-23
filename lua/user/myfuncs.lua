local M = {}

function M.execute_nvim_files_in_dir()
    local msg = ''
    for n, t in vim.fs.dir(vim.loop.cwd()) do
        if n == '.nvim' and t == 'directory' then
            for fn, ft in vim.fs.dir('.nvim') do
                if ft == 'file' and string.sub(fn, -4, -1) == '.lua' then
                    vim.cmd.source('.nvim/'.. fn)
                    msg = msg .. 'Executed script: ' .. n .. '/' .. fn .. '\n'
                end
            end
        end
    end
    vim.notify(msg)
end

return M
