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
map('n', '<C-H>', '<C-W>h')
map('n', '<C-J>', '<C-W>j')
map('n', '<C-K>', '<C-W>k')
map('n', '<C-L>', '<C-W>l')
map('n', '<C-[>', ':noh<CR>')


vim.keymap.set('n', '<leader>K', 'K', {noremap=true})

-- Move line up and down in NORMAL and VISUAL modes
-- Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
--map('n', '<C-j>', ':move .+1<CR>')
--map('n', '<C-k>', ':move .-2<CR>')
--map('x', '<C-j>', ":move '>+1<CR>gv=gv")
--map('x', '<C-k>', ":move '<-2<CR>gv=gv")

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
-- map('o', 'A', ':<C-U>normal! mzggVG<CR>`z')
-- map('x', 'A', ':<C-U>normal! ggVG<CR>')

-- Escape terminal to normal mode
map('t', '<Esc>', '<C-\\><C-n>')

-- Symvols-outline
map('n', '<F2>', ':SymbolsOutline<CR>')

-- NvimTree toggles
map('n', '<C-n>', ':NvimTreeToggle<CR>')
map('n', '<C-m>', ':NvimTreeFocus<CR>')

-- Call telescope
map('n', '\\f', ':Telescope find_files<CR>')
map('n', '\\t', ':Telescope builtin include_extensions=true<CR>')
map('n', '\\q', ':Telescope buffers<CR>')
map('n', '\\r', ':Telescope lsp_references<CR>')

-- Neogen create doc
map('n', '\\d', ':lua require\'neogen\'.generate()<CR>')

vim.keymap.set('n', '\\x', myfuncs.execute_nvim_files_in_dir, { remap = false })

