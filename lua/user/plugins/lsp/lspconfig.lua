return {
  'neovim/nvim-lspconfig',
  dependencies = 'hrsh7th/cmp-nvim-lsp',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'

    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap('n', '<space>dd', '', {
      callback = function() vim.diagnostic.enable(false) end,
      desc = 'disable diagnostic'
    })
    vim.keymap.set('n', '<space>d', vim.diagnostic.enable, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<space>p', function() vim.diagnostic.jump({ count = -1 }) end, opts)
    vim.keymap.set('n', '<space>n', function() vim.diagnostic.jump({ count = 1 }) end, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    local lspenhence = require('user.myplugins.lspenhence')

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>m', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.api.nvim_set_keymap('n', '<space>wl', '', {
          callback = print(vim.inspect(vim.lsp.buf.list_workspace_folders())),
          desc = 'lsp show workspace folders'
        })

        if not client then
          return
        end
        lspenhence.enhence(client.name, bufnr)
        if client:supports_method("textDocument/formatting") then
          vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
        end
      end,
    })

    -- Server setups
    -- suggest configs on new language servers
    vim.lsp.config('*', {
      capabilities = capabilities,

    })

    local language_servers = { 'clangd', 'pyright' }
    for _, ls in ipairs(language_servers) do
      vim.lsp.enable(ls)
      -- enforce my configs on language servers
      vim.lsp.config(ls, {
        capabilities = capabilities,
      })
    end

    -- Special requirements, manual setup

    vim.lsp.enable('lua_ls')
    vim.lsp.config('lua_ls', {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath('config') and
              (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths here.
              -- "${3rd}/luv/library",
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        })
      end,
      settings = {
        Lua = {}
      },
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end
}
