return {
    ----------------------
    --      Style       --
    ----------------------
    {
        'catppuccin/nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'catppuccin'
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        config = true,
        event = 'VeryLazy' -- check if correct
    },

    ----------------------
    --    Navigation    --
    ----------------------

    {
        'simrat39/symbols-outline.nvim',
        config = true,
        cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen' }
    },

    ----------------------
    --    Debugging    ---
    ----------------------

    -- load only when debugging needed

    { 'mfussenegger/nvim-dap', lazy = true },

    { 'rcarriga/nvim-dap-ui', lazy = true },

    { 'nvim-telescope/telescope-dap.nvim', lazy = true },

    { 'theHamsta/nvim-dap-virtual-text', lazy = true },

    { 'mfussenegger/nvim-dap-python', lazy = true },

    ----------------------
    --     Editing     ---
    ----------------------

    {
        'danymat/neogen',
        lazy = true,
        dependencies = 'nvim-treesitter/nvim-treesitter',
        opts = {
            snippet_engine = 'luasnip'
        },
        keys = {
            {
                '\\d',
                function()
                    vim.schedule_wrap(require('neogen').generate())
                end,
                silent = true, mode = 'n'
            }
        },
    }
}
