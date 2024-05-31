return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require('harpoon')
    harpoon.setup()

    local harpoon_mark = require('harpoon.mark')
    local harpoon_ui = require('harpoon.ui')
    local harpoon_term = require('harpoon.term')

    vim.keymap.set('n', '<C-e>', function() harpoon_ui.toggle_quick_menu() end)
    local harpoon_au = vim.api.nvim_create_augroup('HarpoonKeymaps', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = harpoon_au,
      pattern = '*',
      callback = function(opt)
        if vim.bo.filetype ~= 'qf' then
          vim.api.nvim_buf_set_keymap(opt.buf, 'n', '<leader>a', '',
            {
              callback = function() harpoon_mark.add_file() end,
              desc = 'Harpoon mark file'
            })

          vim.api.nvim_buf_set_keymap(opt.buf, 'n', '<C-h>', '',
            {
              callback = function() harpoon_ui.nav_file(1) end,
              desc = 'Harpoon jump first'
            })
          vim.api.nvim_buf_set_keymap(opt.buf, 'n', '<C-j>', '',
            {
              callback = function() harpoon_ui.nav_file(2) end,
              desc = 'Harpoon jump first'
            })
          vim.api.nvim_buf_set_keymap(opt.buf, 'n', '<C-m>', '',
            {
              callback = function() harpoon_ui.nav_file(3) end,
              desc = 'Harpoon jump third'
            })
          vim.api.nvim_buf_set_keymap(opt.buf, 'n', '<C-s>', '',
            {
              callback = function() harpoon_ui.nav_file(4) end,
              desc = 'Harpoon jump fourth'
            })
          vim.api.nvim_buf_set_keymap(opt.buf, 'n', '<C-t>', '',
            {
              callback = function() harpoon_term.gotoTerminal(1) end,
              desc = 'Harpoon open terminal'
            })
        end
      end
    })
  end
}
