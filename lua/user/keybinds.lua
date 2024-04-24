local execdir = require('user.myplugins.execdir')

local function map(m, k, v)
    vim.api.nvim_set_keymap(m, k, v, { silent = true, noremap = true })
end


-- Fix n and N. Keeping cursor in center
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')

-- Mimic shell movements
map('i', '<C-E>', '<ESC>A')
map('i', '<C-A>', '<ESC>I')

-- Escape terminal to normal mode
map('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set('n', '\\x', execdir.execute_nvim_files_in_dir, { remap = false })

