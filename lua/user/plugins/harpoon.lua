return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require('harpoon')
    harpoon.setup()

    local harpoon_mark = require('harpoon.mark')
    local harpoon_ui = require('harpoon.ui')
    local harpoon_term = require('harpoon.term')

    vim.keymap.set('n', '<leader>a', function() harpoon_mark.add_file() end)
    vim.keymap.set('n', '<C-e>', function() harpoon_ui.toggle_quick_menu() end)

    vim.keymap.set('n', '<C-h>', function() harpoon_ui.nav_file(1) end)
    vim.keymap.set('n', '<C-m>', function() harpoon_ui.nav_file(2) end)
    vim.keymap.set('n', '<C-s>', function() harpoon_ui.nav_file(3) end)
    vim.keymap.set('n', '<C-t>', function() harpoon_ui.nav_file(4) end)
    vim.keymap.set('n', '<leader><C-h>', function() harpoon_term.gotoTerminal(1) end)
  end
}
