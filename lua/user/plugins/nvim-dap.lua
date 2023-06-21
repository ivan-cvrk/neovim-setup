-- dapui
local dap, dapui = require('dap'), require('dapui')

vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F6>', function() dap.step_over() end)
vim.keymap.set('n', '<F7>', function() dap.step_into() end)
vim.keymap.set('n', '<F8>', function() dap.step_out() end)
vim.keymap.set('n', '<F9>', function() dap.terminate() end)
vim.keymap.set('n', '\\b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '\\B', function() dap.set_breakpoint() end)
vim.keymap.set('n', '\\lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '\\dr', function() dap.repl.open() end)
vim.keymap.set('n', '\\dl', function() dap.run_last() end)
vim.keymap.set('n', '\\dp', function() dap.pause() end)

local widgets = require('dap.ui.widgets')
vim.keymap.set({ 'n', 'v' }, '\\dh', function()
    widgets.hover()
end)
vim.keymap.set({ 'n', 'v' }, '\\dp', function()
    widgets.preview()
end)
vim.keymap.set('n', '\\df', function()
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '\\ds', function()
    widgets.centered_float(widgets.scopes)
end)
vim.keymap.set('n', '\\dt', function()
    widgets.centered_float(widgets.threads)
end)

vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#993939', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379', bg = '#31353f' })

vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition',
    { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected',
    { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

vim.cmd('autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>')

local nvim_tree_open = false

-- Start dapui on debugging
local function on_exit()
    dapui.close()
    if nvim_tree_open then
        require('nvim-tree.api').tree.open()
    end
    require 'nvim-dap-virtual-text'.refresh()
end

vim.keymap.set('n', '\\du', on_exit)

dap.listeners.after.event_initialized.dapui_config = function()
    nvim_tree_open = require('nvim-tree.view').is_visible()
    require('nvim-tree.api').tree.close()
    dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = on_exit
dap.listeners.before.event_exited.dapui_config = on_exit

dapui.setup()

-- telescope
require 'telescope'.load_extension('dap')

-- virtual text
require 'nvim-dap-virtual-text'.setup({})


-- Debuggers

require 'dap-python'.setup('/usr/bin/python3')

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = vim.fs.normalize('~/dev/microsoft/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7'),
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
}

dap.configurations.c = dap.configurations.cpp

