return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim'
        },
        event = 'InsertEnter',
        config = function()

            local cmp = require('cmp')
            local lspkind = require('lspkind')

            if not cmp then
                return
            end

            -- setup autocomplete
            cmp.setup {
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
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
                    { name = 'luasnip' },
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'buffer', keyword_length = 5 }
                },
                formatting = {
                    format = lspkind.cmp_format {
                        with_test = true,
                        menu = {
                            luasnip = '[snip]',
                            nvim_lsp = '[LSP]',
                            nvim_lua = '[api]',
                            path = '[path]',
                            buffer = '[buf]',
                        }
                    }
                },
                experimental = {
                    native_menu = false,
                    ghost_text = true
                }
            }

        end
    },
    {
        'onsails/lspkind.nvim',
        lazy = true,
        config = function()

            -- Setup Module
            local lspkind = require('lspkind')

            lspkind.init({
                -- DEPRECATED (use mode instead): enables text annotations
                --
                -- default: true
                -- with_text = true,

                -- defines how annotations are shown
                -- default: symbol
                -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
                mode = 'symbol_text',

                -- default symbol map
                -- can be either 'default' (requires nerd-fonts font) or
                -- 'codicons' for codicon preset (requires vscode-codicons font)
                --
                -- default: 'default'
                preset = 'codicons',

                -- override preset symbols
                --
                -- default: {}
                symbol_map = {
                    Text = "",
                    Method = "",
                    Function = "ƒ",
                    Constructor = "",
                    Field = "ﰠ",
                    Variable = "",
                    Class = "ﴯ",
                    Interface = "",
                    Module = "",
                    Property = "ﰠ",
                    Unit = "塞",
                    Value = "",
                    Enum = "ℰ",
                    Keyword = "",
                    Snippet = "",
                    Color = "",
                    File = "",
                    Reference = "",
                    Folder = "",
                    EnumMember = "",
                    Constant = "",
                    Struct = "פּ",
                    Event = "",
                    Operator = "",
                    TypeParameter = ""
                },
            })
        end
    },
}
