local M = {}

function M.execute_nvim_files_in_dir()
    local msg = ''
    for n, t in vim.fs.dir(vim.loop.cwd()) do
        if n:match('nvim') and t == 'file' then
            vim.cmd.source(n)
            msg = msg .. 'Executed script: ' .. n .. '\n'
        end
    end
    vim.notify(msg)
end

return M
