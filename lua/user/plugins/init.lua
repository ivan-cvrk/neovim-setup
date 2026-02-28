return {

  ----------------------
  --      Style       --
  ----------------------


  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
      vim.cmd("colorscheme vaporwave")
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = function()
      local spinner = require('user.myplugins.lualine_spinner')

      return {
        options = {
          theme = 'auto',
          disabled_filetypes = { 'dashboard' },
          -- Optional: Add separators to help differentiate windows
          -- component_separators = { left = '│', right = '│' },
          -- section_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_z = {
            {
              require("opencode").statusline,
            },
          }
        }
      }
    end,
  },

  {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = { 'markdown', 'quarto' },
  },

  ----------------------
  -- Code Navigation  --
  ----------------------

  {
    'simrat39/symbols-outline.nvim',
    config = true,
    keys = { { '<F2>', ':SymbolsOutline<CR>', silent = true, mode = 'n', desc = "Symbols outline toggle" } },
    cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen' }
  },

  ----------------------
  --     Editing     ---
  ----------------------

  {
    'danymat/neogen',
    lazy = true,
    opts = {
      snippet_engine = 'luasnip'
    },
    keys = {
      {
        '\\d',
        function()
          vim.schedule_wrap(require('neogen').generate())
        end,
        silent = true, mode = 'n', desc = 'Neogen comment'
      }
    },
  },
}
