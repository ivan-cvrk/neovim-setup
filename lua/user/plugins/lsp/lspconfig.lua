-- Setup module

-- Lsp configuration
local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
    return
end

-- Additional autocomplete capabilities
local status_cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_cmp_ok then
    return
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>dd', vim.diagnostic.disable, opts)
vim.keymap.set('n', '<space>d', vim.diagnostic.enable, opts)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<C-;>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<C-\'>', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'M', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<space>m', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

-- Server setups

-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- for specific about your langage


-- Standard requirements

-- list of language servers for standard setup

local language_servers = { 'pyright', 'clangd', 'tsserver' }

for _, ls in ipairs(language_servers) do

    lspconfig[ls].setup {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities
    }

end

-- Special requirements, manual setup

lspconfig['sumneko_lua'].setup {
    settings = {

        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },

    },
    on_attach = function(client, bufnr)
        -- first call default on attach
        on_attach(client, bufnr)

        local client_cfg = client.config

        -- If working directory has nvim in name it is considered as nvim lua file
        -- and enviroment for working with vim has to be set.
        if client_cfg.root_dir and client_cfg.root_dir:match('nvim') then

            -- Attach nvim-lua sources for autocompletion
            require('cmp').setup.buffer {
                sources = {
                    { name = 'nvim_lua' },
                }
            }

            -- If neccesary change client settings
            -- change is considered needed when there is no 'vim' global
            if not client_cfg.settings.Lua.diagnostics.globals or
               not vim.tbl_contains(client_cfg.settings.Lua.diagnostics.globals, 'vim')
            then
                local new_settings = vim.tbl_deep_extend('force', client.config.settings, {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                })

                client.config.settings = new_settings
                client.notify('workspace/didChangeConfiguration')
                vim.notify('Lua is now in neovim mode.')
            end

        end
    end,
    flags = lsp_flags,
    capabilities = capabilities,
}
