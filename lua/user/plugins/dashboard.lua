return {
    'glepnir/dashboard-nvim',
    -- requires = { 'nvim-tree/nvim-web-devicons' }
    config = function()

        local dashboard = require('dashboard')

        vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#61afef' })
        vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#98c379' })

        vim.api.nvim_set_hl(0, 'DashboardLabel', { fg = '#c678dd' })
        vim.api.nvim_set_hl(0, 'DashboardIcon', { fg = '#e5c07b' })


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
                        action = 'e .',
                        icon_hl = 'DashboardIcon',
                        desc_hl = 'DashboardLabel',
                    },
                    {
                        icon = '  ',
                        desc = 'Find file    ',
                        action = 'Telescope find_files',
                        icon_hl = 'DashboardIcon',
                        desc_hl = 'DashboardLabel',
                    },
--                    {
--                        icon = '  ',
--                        desc = 'Open project ',
--                        action = 'Telescope project',
--                        icon_hl = 'DashboardIcon',
--                        desc_hl = 'DashboardLabel',
--                    },
                    {
                        icon = '  ',
                        desc = 'Recent files ',
                        action = 'Telescope oldfiles',
                        icon_hl = 'DashboardIcon',
                        desc_hl = 'DashboardLabel',
                    },
                    {
                        icon = '  ',
                        desc = 'Config    ',
                        action = 'cd ' .. vim.fn.stdpath 'config' .. ' | lua require(\'nvim-tree.api\').tree.open({ path="' .. vim.fn.stdpath 'config' .. '"})',
                        icon_hl = 'DashboardIcon',
                        desc_hl = 'DashboardLabel',
                    },
                },
                footer = {
                    [[                                            ]],
                    [[ Do one thing, do it well - Unix philosophy ]],
                    [[                                            ]],
                }
            }
        }
    end

}
