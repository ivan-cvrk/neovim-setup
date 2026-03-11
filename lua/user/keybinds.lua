local execdir = require('user.myplugins.execdir')

local function map(m, k, v)
    vim.api.nvim_set_keymap(m, k, v, { silent = true, noremap = true })
end

-- Escape terminal to normal mode
map('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set('n', '\\x', execdir.execute_nvim_files_in_dir, { remap = false })

