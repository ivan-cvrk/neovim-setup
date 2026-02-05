return {
  {
    "github/copilot.vim",
    config = function()
      -- Enable Copilot
      vim.g.copilot_enabled = true
      -- Set Copilot to use inline suggestions
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true

      -- Optional: Customize Copilot settings
      vim.g.copilot_filetypes = {
        -- Disable copilot for csv files
        csv = false,
      }
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp", -- Optional: for completion
      "ravitemer/codecompanion-history.nvim",
      { "MeanderingProgrammer/render-markdown.nvim", -- Enhanced markdown rendering
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        ft = { "markdown", "codecompanion" } },
    }, config = function()
      vim.keymap.set({ "n", "v" }, "<C-c>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
      vim.keymap.set({ "n", "v" }, "\\c", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
      vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd([[cab cc CodeCompanion]])

      require("codecompanion").setup({
        adapter = {
          acp = {
            gemini_cli = function()
              return require("codecompanion.adapters").extend("gemini_cli", {
                defaults = {
                  auth_method = "oauth-personal",
                },
              })
            end,
          }
        },
        interactions = {
          chat = { adapter = "copilot", model = 'gpt-5 mini' },
          inline = { adapter = "copilot", model = 'gpt-5 mini' },
          agent = { adapter = "copilot", model = 'gpt-5 mini' },
          background = {
            chat = {
              adapter = { name = "copilot", model = "gpt-5 mini", },
              callbacks = {
                ["on_ready"] = {
                  actions = {
                    "interactions.background.builtin.chat_make_title",
                  },
                  -- Enable "on_ready" callback which contains the title generation action
                  enabled = true,
                },
              },
              opts = {
                -- Enable background interactions generally
                enabled = true,
              },
            },
          },

          -- chat = {
          --   -- You can specify an adapter by name and model (both ACP and HTTP)
          --   adapter = {
          --     name = "copilot",
          --     model = "gpt-4.1",
          --   },
          -- },
        },
        extensions = {
          history = {
            enabled = true,
            opts = {
              max_items = 100,
              persist = true,
              persist_file = vim.fn.stdpath("data") .. "/codecompanion_history.json",
              picker = "telescope"
            },
          },
        },
      }
      )
    end,
  },

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
          lualine_c = {
            { 'filename', 'codecompanion' },
          },
        }
      }
    end,
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
