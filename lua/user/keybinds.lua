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

-- Move cursor between tabs
map('n', '<C-H>', '<C-W>h')
map('n', '<C-J>', '<C-W>j')
map('n', '<C-K>', '<C-W>k')
map('n', '<C-L>', '<C-W>l')
map('n', '<C-[>', ':noh<CR>')

-- Escape terminal to normal mode
map('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set('n', '\\x', execdir.execute_nvim_files_in_dir, { remap = false })

