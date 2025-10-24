return {
  ----------------------
  --      Style       --
  ----------------------


  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
      vim.cmd("colorscheme onedark")
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        disabled_filetypes = { 'dashboard' },
      }
    },
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
