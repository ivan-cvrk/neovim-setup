return {
  "folke/snacks.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Floating input window — used by opencode's ask() prompt
    input = {
      enabled = true,
    },

    -- Picker (replaces vim.ui.select) — used by opencode's select(), select_session(), select_server()
    picker = {
      enabled = true,
      sources = {
        pickers = {
          layout = { preset = 'select' }
        },
        explorer = {
          win = {
            list = {
              keys = {
                ["<C-n>"] = "cancel"
              }
            }
          },
          layout = {
            preset = "default", -- or omit this
            layout = {
              width = 0.6,
              height = 0.7,
              zindex = 50,
            },
          },
        },
      }
    },

    -- Floating notifications — replaces vim.notify
    notifier = {
      enabled = true,
      timeout = 3000,
      style = "fancy",
    },

    -- Dashboard
    dashboard = { enabled = true, },

    -- Image
    image = { enabled = true },

    -- Explorer
    explorer     = { enabled = true },

    -- Explicitly disable modules we don't need
    bigfile      = { enabled = false },
    indent       = { enabled = false },
    lazygit      = { enabled = false },
    quickfile    = { enabled = false },
    scope        = { enabled = false },
    scroll       = { enabled = false },
    statuscolumn = { enabled = false },
    terminal     = { enabled = false },
    words        = { enabled = false },
    zen          = { enabled = false },
  },

  keys = {
    { "\\f", function() Snacks.picker.files() end, silent = true, mode = "n", desc = "Find files" },
    { "\\t", function() Snacks.picker.pickers() end, silent = true, mode = "n", desc = "All pickers" },
    { "\\q", function() Snacks.picker.buffers() end, silent = true, mode = "n", desc = "Buffers" },
    { "\\r", function() Snacks.picker.lsp_references() end, silent = true, mode = "n", desc = "LSP references" },
    { "\\g", function() Snacks.picker.grep() end, silent = true, mode = "n", desc = "Live grep" },
    { "\\o", function() Snacks.picker.recent() end, silent = true, mode = "n", desc = "Recent files" },
    { "<C-n>", function() Snacks.picker.explorer() end, silent = true, mode = "n", desc = "File explorer" },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    -- Purple header
    vim.api.nvim_set_hl(0, "SnacksDashboardHeader", {
      fg = "#9D7CD8", -- pick any purple hex
      bold = true,
    })
    -- Re-apply after colorscheme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "SnacksDashboardHeader", {
          fg = "#C678DD",
          bold = true,
        })
      end,
    })
  end,
}
