local myfuncs = require('user.myfuncs')

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
map('n', 'H', '<c-w>h')
map('n', 'J', '<c-w>j')
map('n', 'K', '<c-w>k')
map('n', 'L', '<c-w>l')

-- Move line up and down in NORMAL and VISUAL modes
-- Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
map('n', '<C-j>', ':move .+1<CR>')
map('n', '<C-k>', ':move .-2<CR>')
map('x', '<C-j>', ":move '>+1<CR>gv=gv")
map('x', '<C-k>', ":move '<-2<CR>gv=gv")

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
-- map('o', 'A', ':<C-U>normal! mzggVG<CR>`z')
-- map('x', 'A', ':<C-U>normal! ggVG<CR>')

-- Escape terminal to normal mode
map('t', '<Esc>', '<C-\\><C-n>')

-- Symvols-outline
map('n', '<F2>', ':SymbolsOutline<CR>')

-- NvimTree toggles
map('n', '<C-b>', ':NvimTreeToggle<CR>')
map('n', '<C-n>', ':NvimTreeFocus<CR>')

-- Call telescope
map('n', '\\f', ':Telescope find_files<CR>')
map('n', '\\t', ':Telescope<CR>')

-- Neogen create doc
map('n', '\\d', ':lua require\'neogen\'.generate()<CR>')

vim.keymap.set('n', '\\x', myfuncs.execute_nvim_files_in_dir, { remap = false })

