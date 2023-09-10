local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { '<-', 'Error' } }
            }
        }
    }
}

vim.keymap.set({ 's', 'i' }, '<C-K>', function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { desc = "Luasnip expand or jump", })
vim.keymap.set({ 's', 'i' }, '<C-J>', function()
    if ls.jumpable( -1) then
        ls.jump( -1)
    end
end, { desc = "Luasnip jump back" })
vim.keymap.set({ 's', 'i' }, '<C-L>', function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { desc = "Luasnip expand or jump" })

ls.filetype_extend('c', { 'c_cpp' })
ls.filetype_extend('cpp', { 'c_cpp' })
require('luasnip.loaders.from_lua').lazy_load({ paths = './luasnippets' })

