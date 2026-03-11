return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    opts = {
      keymap = {
        preset = 'none',
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-y>'] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.select_and_accept()
              return true
            end

            if vim.fn.exists('*copilot#Accept') == 1 then
              local copilot_keys = vim.fn['copilot#Accept']()
              if copilot_keys ~= '' then
                vim.api.nvim_feedkeys(copilot_keys, 'i', true)
                return true
              end
            end

            return false
          end,
          'fallback',
        },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = {
          auto_show = true,
        },
        ghost_text = {
          enabled = true,
        },
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
      snippets = {
        preset = 'default',
      },
      fuzzy = {
        implementation = 'prefer_rust_with_warning',
      },
    },
    opts_extend = { 'sources.default' },
  },
}
