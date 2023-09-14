return {
    {
        'windwp/nvim-autopairs',
        lazy = true,
        event = 'InsertEnter',
        opts = {},
        dependencies = 'nvim-treesitter/nvim-treesitter'
    },
    {
        'nvim-treesitter/playground',
        cmd = 'TSPlaygroundToggle',
        dependencies = 'nvim-treesitter/nvim-treesitter'
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { 'c', 'cpp', 'lua', 'python' },
                highlight = {
                    enable = true, -- false will disable the whole extension
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                    disable = { 'html' }
                },
            })
        end
    }
}
