return {
  "folke/snacks.nvim",
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
    },

    -- Floating notifications — replaces vim.notify
    notifier = {
      enabled = true,
      timeout = 3000,
      style = "fancy",
    },

    -- Explicitly disable modules we don't need
    bigfile    = { enabled = false },
    dashboard  = { enabled = false },
    explorer   = { enabled = false },
    indent     = { enabled = false },
    lazygit    = { enabled = false },
    quickfile  = { enabled = false },
    scope      = { enabled = false },
    scroll     = { enabled = false },
    statuscolumn = { enabled = false },
    terminal   = { enabled = false },
    words      = { enabled = false },
    zen        = { enabled = false },
  },
}
