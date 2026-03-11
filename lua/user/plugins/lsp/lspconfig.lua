return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'saghen/blink.cmp',
    'folke/lazydev.nvim',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>dd', function() vim.diagnostic.enable(false) end, {
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
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, vim.tbl_extend('force', bufopts, {
          desc = 'lsp show workspace folders'
        }))

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

    -- Lua LS setup (workspace/library handled by lazydev.nvim)
    vim.lsp.enable('lua_ls')
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          telemetry = { enable = false },
        }
      },
      capabilities = capabilities,
    })
  end
}
