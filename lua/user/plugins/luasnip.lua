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

require('luasnip.loaders.from_lua').lazy_load({ paths = './snippets' })

-- This won't work with lazy_load
-- ls.load_snippet_docstrings(ls.get_snippets())

--vim.api.nvim_create_user_command('LuaSnipCompileDocs', function()
--    require('luasnip.loaders.from_lua').load({ paths = './luasnippets' })
--    ls.store_snippet_docstrings(ls.get_snippets())
--end, {})

