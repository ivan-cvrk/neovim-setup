-- Setup module
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')


-- setup autocomplete
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs( -4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
        ['<C-Space>'] = cmp.mapping.complete(),
--        ['<Tab>'] = cmp.mapping(function(fallback)
--            if cmp.visible() then
--                cmp.select_next_item()
--            elseif luasnip.expand_or_jumpable() then
--                luasnip.expand_or_jump()
--            else
--                fallback()
--            end
--        end, { 'i', 's' }),
--        ['<S-Tab>'] = cmp.mapping(function(fallback)
--            if cmp.visible() then
--                cmp.select_prev_item()
--            elseif luasnip.jumpable( -1) then
--                luasnip.jump( -1)
--            else
--                fallback()
--            end
--        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'buffer',  keyword_length = 5 }
    },
    formatting = {
        format = lspkind.cmp_format {
            with_test = true,
            menu = {
                nvim_lsp = '[LSP]',
                nvim_lua = '[api]',
                path = '[path]',
                luasnip = '[snip]',
                buffer = '[buf]',
            }
        }
    },
    experimental = {
        native_menu = false,
        ghost_text = true
    }
}
