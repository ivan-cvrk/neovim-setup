return {
    'akinsho/bufferline.nvim',
    version = "*",
    event = 'BufAdd',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        local bufferline = require('bufferline')
        bufferline.setup({
            options = {
                style_preset = bufferline.style_preset.default,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "Neovim Tree",
                    }
                },
                separator_style = 'slant',
                always_show_bufferline = false,
            }
        }
        )
        vim.api.nvim_set_keymap('n', '<PageUp>', '',
            {
                callback = function()
                    bufferline.cycle(1)
                end,
                desc = 'Bufferline: cycle next',
                silent = true
            }
        )
        vim.api.nvim_set_keymap('n', '<PageDown>', '',
            {
                callback = function()
                    bufferline.cycle(-1)
                end,
                desc = 'Bufferline: cycle prev',
                silent = true
            }
        )
        vim.api.nvim_set_keymap('n', '\\qs', '',
            {
                callback = function()
                    bufferline.pick()
                end,
                desc = 'Bufferline: select',
                silent = true
            }
        )
        vim.api.nvim_set_keymap('n', '\\qn', '',
            {
                callback = function()
                    bufferline.move(1)
                end,
                desc = 'Bufferline: move next',
                silent = true
            }
        )
        vim.api.nvim_set_keymap('n', '\\qp', '',
            {
                callback = function()
                    bufferline.move(-1)
                end,
                desc = 'Bufferline: move prev',
                silent = true
            }
        )
        vim.api.nvim_set_keymap('n', '\\ql', ':BufferLineTogglePin<CR>',
            {
                desc = 'Bufferline: close current',
                silent = true
            }
        )
        vim.api.nvim_set_keymap('n', '\\qq', '',
            {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    bufferline.cycle(-1)
                    bufferline.unpin_and_close(buffer)
                end,
                desc = 'Bufferline: close current',
                silent = true
            }
        )
        vim.api.nvim_set_keymap('n', '\\qo', '',
            {
                callback = function()
                    bufferline.close_others()
                end,
                desc = 'Bufferline: close others',
                silent = true
            }
        )
        vim.api.nvim_set_keymap('n', '\\qap', '',
            {
                callback = function()
                    bufferline.close_in_direction('left')
                end,
                desc = 'Bufferline: close left',
                silent = true
            }
        )
        vim.api.nvim_set_keymap('n', '\\qan', '',
            {
                callback = function()
                    bufferline.close_in_direction('right')
                end,
                desc = 'Bufferline: close right',
                silent = true
            }
        )
    end
}
