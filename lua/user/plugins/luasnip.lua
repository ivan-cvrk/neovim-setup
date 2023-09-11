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

-- Logic with global variables needed for snippet compilation
if _G.LUASNIP_LOAD_DOC == nil then
    _G.LUASNIP_LOAD_DOC = true
end
if _G.LUASNIP_LAYZLOAD == nil or _G.LUASNIP_LAYZLOAD == true then
    require('luasnip.loaders.from_lua').lazy_load({ paths = './snippets' })
else
    require('luasnip.loaders.from_lua').load({ paths = './snippets' })
end

-- This won't work here with lazy_load
-- ls.load_snippet_docstrings(ls.get_snippets())

vim.api.nvim_create_user_command('LuaSnipCompileDocs', function()
    package.loaded['user.plugins.luasnip'] = nil
    _G.LUASNIP_LAYZLOAD = false
    _G.LUASNIP_LOAD_DOC = false
    require('user.plugins.luasnip')
    ls.store_snippet_docstrings(ls.get_snippets())
    package.loaded['user.plugins.luasnip'] = nil
    _G.LUASNIP_LAYZLOAD = true
    _G.LUASNIP_LOAD_DOC = true
    require('user.plugins.luasnip')
end, {})

-- TODO: Check if cache file exists, if not call CompileDocs
