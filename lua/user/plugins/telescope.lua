return {
    { 'nvim-telescope/telescope-project.nvim', lazy = true },
    { 'benfowler/telescope-luasnip.nvim', lazy = true },
    {
        'nvim-telescope/telescope.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local telescope = require('telescope')

            require('telescope').load_extension('project')
            require('telescope').load_extension('luasnip')

            telescope.setup {
                defaults = {
                    prompt_prefix = ' ',
                    selection_caret = ' ',
                    path_display = { 'smart' },
                },
                pickers = {
                    -- Default configuration for builtin pickers goes here:
                    -- picker_name = {
                    --   picker_config_key = value,
                    --   ...
                    -- }
                    -- Now the picker_config_key will be applied every time you call this
                    -- builtin picker
                },
                extensions = {
                    project = {
                        -- leave everything default
                    },
                    luasnip = {
                        search = function(entry)
                            local lst = require('telescope').extensions.luasnip
                            local luasnip = require('luasnip')

                            return lst.filter_null(entry.context.trigger) .. " " ..
                                lst.filter_null(entry.context.name) .. " " ..
                                entry.ft .. " " ..
                                lst.filter_description(entry.context.name, entry.context.description) ..
                                lst.get_docstring(luasnip, entry.ft, entry.context)[0]
                        end
                    },

                }
            }
        end,
    }
}
