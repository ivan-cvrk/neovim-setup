return {
    {
        'windwp/nvim-autopairs',
        lazy = true,
        event = "InsertEnter", -- maybe remove
        opts = {}
    },
    { 'windwp/nvim-ts-autotag', lazy = true },
    {
        'nvim-treesitter/playground',
        cmd = 'TSPlaygroundToggle',
        dependencies = { 'nvim-treesitter/nvim-treesitter' }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
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
                autotag = {
                    enable = true,
                    enable_rename = true,
                    enable_close = true,
                    enable_close_on_slash = true,
                },
                autopairs = {
                    enable = true,
                },
            })

        end
    }
}
