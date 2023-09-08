-- Setup module
local dashboard = require('dashboard')

vim.api.nvim_set_hl(0, 'DashboardHeader', { link = 'Function' })
vim.api.nvim_set_hl(0, 'DashboardFooter', { link = 'String'} )

dashboard.setup {
  theme = 'doom',
  config = {
    week_header = {
      enable = true,
    },
    center = {
      {
         icon = '  ',
         desc = 'Open      ',
         action = 'exe \'NvimTreeOpen\' | exe \'wincmd p\' | exe \'q\' | lua vim.schedule(function() require(\'user.myfuncs\').execute_nvim_files_in_dir() end)',
         icon_hl = 'Type',
         desc_hl = 'Label',
      },
      {
         icon = '  ',
         desc = 'Find file    ',
         action = 'Telescope find_files',
         icon_hl = 'Type',
         desc_hl = 'Label',
      },
      {
         icon = '  ',
         desc = 'Open project ',
         action = 'Telescope project',
         icon_hl = 'Type',
         desc_hl = 'Label',
      },
      {
         icon = '  ',
         desc = 'Recent files ',
         action = 'Telescope oldfiles',
         icon_hl = 'Type',
         desc_hl = 'Label',
      },
      {
         icon = '  ',
         desc = 'Config    ',
         action = 'edit ' .. vim.fn.stdpath 'config',
         icon_hl = 'Type',
         desc_hl = 'Label',
      },
    },
    footer = {
      [[                                            ]],
      [[ Do one thing, do it well - Unix philosophy ]],
      [[                                            ]],
    }
  }
}

