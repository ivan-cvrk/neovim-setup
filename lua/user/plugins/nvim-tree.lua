-- Setup module
local status_ok, ntree = pcall(require, 'nvim-tree')
if not status_ok then
    return
end

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

vim.keymap.set("n", "<leader>mn", require("nvim-tree.api").marks.navigate.next)
vim.keymap.set("n", "<leader>mp", require("nvim-tree.api").marks.navigate.prev)
vim.keymap.set("n", "<leader>ms", require("nvim-tree.api").marks.navigate.select)
