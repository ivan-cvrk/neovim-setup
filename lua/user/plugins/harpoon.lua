return {
  'ThePrimeagen/harpoon',
  branch = "harpoon2",
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require('harpoon')

    local terminal = require('user.myplugins.terminal')

    harpoon:setup({
      -- Setting up custom behavior for a list named "cmd"
      cmd = {

        -- When you call list:add() this function is called and the return
        -- value will be put in the list at the end.
        --
        -- which means same behavior for prepend except where in the list the
        -- return value is added
        --
        -- @param possible_value string only passed in when you alter the ui manual
        add = function(possible_value)
          -- get the current line idx
          local idx = vim.fn.line(".")

          -- read the current line
          local cmd = vim.api.nvim_buf_get_lines(0, idx - 1, idx, false)[1]
          if cmd == nil then
            return nil
          end

          return {
            value = cmd,
            context = { something = "... any data you want ..." },
          }
        end,

        --- This function gets invoked with the options being passed in from
        --- list:select(index, <...options...>)
        --- @param list_item {value: any, context: any}
        --- @param list { ... }
        --- @param option any
        select = function(list_item, list, option)
          list_item.context.callback()
        end,

        encode = false

      }
    })

    local harpoon_extensions = require("harpoon.extensions")
    harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

    vim.api.nvim_set_keymap('n', '<C-e>', '', {
      callback = function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      desc = 'Harpoon show marked files list',
    })

    vim.api.nvim_set_keymap('n', '<leader>x', '', {
      callback = function() harpoon.ui:toggle_quick_menu(harpoon:list('cmd')) end,
      desc = 'Harpoon show cmd list',
    })

    local harpoon_au = vim.api.nvim_create_augroup('HarpoonKeymaps', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = harpoon_au,
      pattern = '*',
      callback = function(opt)
        if vim.bo.filetype ~= 'qf' then
          vim.api.nvim_buf_set_keymap(opt.buf, 'n', '<leader>a', '',
            {
              callback = function() harpoon:list():add() end,
              desc = 'Harpoon mark file'
            })
          vim.api.nvim_buf_set_keymap(opt.buf, 'n', '<C-h>', '',
            {
              callback = function() harpoon:list():select(1) end,
              desc = 'Harpoon jump first'
            })
          vim.api.nvim_buf_set_keymap(opt.buf, 'n', '<C-j>', '',
            {
              callback = function() harpoon:list():select(2) end,
              desc = 'Harpoon jump first'
            })
          vim.api.nvim_buf_set_keymap(opt.buf, 'n', '<C-m>', '',
            {
              callback = function() harpoon:list():select(3) end,
              desc = 'Harpoon jump third'
            })
          vim.api.nvim_buf_set_keymap(opt.buf, 'n', '<C-s>', '',
            {
              callback = function() harpoon:list():select(4) end,
              desc = 'Harpoon jump fourth'
            })
          vim.api.nvim_buf_set_keymap(opt.buf, 'n', '<C-t>', '',
            {
              callback = terminal.toggle_terminal,
              desc = 'Harpoon open terminal'
            })
        end
      end
    })
  end
}
