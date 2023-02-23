-- Setup module
local status_ok, dashboard = pcall(require, 'dashboard')
if not status_ok then
  return
end

dashboard.setup {
  theme = 'doom',
  config = {
    header = {
      [[                                                        ]],
      [[ ██╗    ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗ ]],
      [[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║ ]],
      [[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║ ]],
      [[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ]],
      [[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║ ]],
      [[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ]],
      [[                                                        ]],
    },
    center = {
      {
         icon = '  ',
         desc = 'Open      ',
         action = 'exe \'NvimTreeOpen\' | exe \'wincmd p\' | exe \'q\''
      },
      {
         icon = '  ',
         desc = 'Find file    ',
         action = 'Telescope find_files',
      },
      {
         icon = '  ',
         desc = 'Open project ',
         action = 'Telescope project',
      },
      {
         icon = '  ',
         desc = 'Recent files ',
         action = 'Telescope oldfiles',
      },
      {
         icon = '  ',
         desc = 'Config    ',
         action = 'edit ' .. vim.fn.stdpath 'config',
      },
    },
    footer = {
      [[                                            ]],
      [[ Do one thing, do it well - Unix philosophy ]],
      [[                                            ]],
    }
  }
}

