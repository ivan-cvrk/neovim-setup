return {
    'nvim-tree/nvim-tree.lua',
    version = "*",
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    keys = {
        { '<C-n>', ':NvimTreeToggle<CR>', silent = true, mode = 'n' },
        { '<C-m>', ':NvimTreeFocus<CR>',  silent = true, mode = 'n' }
    },
    config = function()
        local ntree = require('nvim-tree')

        local function my_on_attach(bufnr)
            local api = require "nvim-tree.api"

            local function opts(desc)
                return {
                    desc = "nvim-tree: " .. desc,
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true
                }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- custom mappings
            vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up folder'))
            vim.keymap.set('n', 'i', function()
                api.tree.change_root_to_node(api.tree.get_node_under_cursor())
            end,
                opts('Enter folder'))
        end

        ntree.setup({
            on_attach = my_on_attach,
            view = {
                adaptive_size = true,
            },
            filters = {
                dotfiles = true
            }
        })

        vim.keymap.set("n", "<leader>tn", require("nvim-tree.api").marks.navigate.next, {
            desc = "NvimTree go to next bookmark"
        })
        vim.keymap.set("n", "<leader>tp", require("nvim-tree.api").marks.navigate.prev, {
            desc = "NvimTree go to previous bookmark"
        })
        vim.keymap.set("n", "<leader>ts", require("nvim-tree.api").marks.navigate.select, {
            desc = "NvimTree bookmarks select"
        })
    end,
}
