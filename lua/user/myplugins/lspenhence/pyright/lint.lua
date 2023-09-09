vim.notify('called lint')
local namespace = vim.api.nvim_create_namespace('Flake8NS')

local function extract_report(report)
    local messages = {}
    for _, line in ipairs(report) do
        if line == '' then break end
        local linenr, colnr, mess = line:gmatch('stdin:(%d+):(%d+): (.+)')()
        table.insert(messages, {
            lnum = tonumber(linenr) - 1,
            col = tonumber(colnr) - 1,
            message = mess,
            severity = vim.diagnostic.severity.WARN
        })
    end
    return messages
end

local function display_diagnostic(bufnr, report_data)
    vim.diagnostic.set(namespace, bufnr, report_data, { virtual_text = true })
end

local function runflake8(bufnr)
    local channel = vim.fn.jobstart({ 'flake8', '-' }, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if not data then return end
            display_diagnostic(bufnr, extract_report(data))
        end,
    })
    local bufdata = vim.api.nvim_buf_get_text(bufnr, 0, 0, -1, -1, {})
    vim.fn.chansend(channel, bufdata)
    vim.fn.chanclose(channel, 'stdin')
end

local augroup = vim.api.nvim_create_augroup('PythonDiagnosticPEP8', { clear = true })

local function attachlinting(bufnr)
    vim.api.nvim_create_autocmd('BufWritePost', {
        group = augroup,
        buffer = bufnr,
        callback = function() runflake8(bufnr) end
    })
    runflake8(bufnr)
end

local M = {}
M.attachlinting = attachlinting
return M
