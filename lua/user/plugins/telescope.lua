return {
    { 'benfowler/telescope-luasnip.nvim',        lazy = true },
    { 'nvim-telescope/telescope-ui-select.nvim', lazy = true },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = { 'Telescope' },
        keys = {
            {
                '\\f', ':Telescope find_files<CR>',
                silent = true, mode = 'n'
            },
            {
                '\\t', ':Telescope builtin include_extensions=true<CR>',
                silent = true, mode = 'n'
            },
            {
                '\\q', ':Telescope buffers<CR>',
                silent = true, mode = 'n'
            },
            {
                '\\r', ':Telescope lsp_references<CR>',
                silent = true, mode = 'n'
            },
            {
                '\\g', ':Telescope live_grep<CR>',
                silent = true, mode = 'n'
            },
            {
                '\\o', ':Telescope old_files<CR>',
                silent = true, mode = 'n'
            }
        },
        config = function()
            local telescope = require('telescope')

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
                      hidden_files = true, -- default: false
                      theme = "dropdown",
                      order_by = "asc",
                      search_by = "title",
                      sync_with_nvim_tree = true, -- default false
                      -- default for on_project_selected = find project files
                      on_project_selected = function(prompt_bufnr)
                        -- Do anything you want in here. For example:
                        require("telescope._extensions.project.actions").change_working_directory(prompt_bufnr, false)
                        require("harpoon.ui").nav_file(1)
                      end
                    },
                    dap = {

                    },
                    ['ui-select'] = {
                        require("telescope.themes").get_dropdown {}
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

            require('telescope').load_extension('luasnip')
            require('telescope').load_extension('ui-select')
            require('telescope').load_extension('harpoon')
        end,
    }
}
