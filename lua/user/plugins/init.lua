return {
  ----------------------
  --      Style       --
  ----------------------
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = { options = { disabled_filetypes = { 'dashboard' } } },
    event = 'VeryLazy' -- check if correct
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
    dependencies = 'nvim-treesitter/nvim-treesitter',
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

  {
    'folke/which-key.nvim',
    lazy = true,
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
    }
  },

  ----------------------
  --      LaTex      ---
  ----------------------

  {
    'lervag/vimtex',
    lazy = true,
    ft = 'tex',
    init = function()
      vim.g.vimtex_view_method = 'zathura'
    end
  },
}
