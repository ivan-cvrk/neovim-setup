-- Setup module
local ntree = require('nvim-tree')

ntree.setup({
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = 'u', action = 'dir_up' },
                { key = 'i', action = 'cd' }
            }
        }
    }
})

vim.keymap.set("n", "<leader>mn", require("nvim-tree.api").marks.navigate.next, {
    desc = "NvimTree go to next bookmark"
})
vim.keymap.set("n", "<leader>mp", require("nvim-tree.api").marks.navigate.prev, {
    desc = "NvimTree go to previous bookmark"
})
vim.keymap.set("n", "<leader>ms", require("nvim-tree.api").marks.navigate.select, {
    desc = "NvimTree bookmarks select"
})
