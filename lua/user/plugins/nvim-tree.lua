return {
  'nvim-tree/nvim-tree.lua',
  version = "*",
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<C-n>', ':NvimTreeToggle<CR>', silent = true, mode = 'n' },
  },
  config = function()
    local ntree = require('nvim-tree')

    local function my_on_attach(bufnr)
      local api = require "nvim-tree.api"

      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true
        }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up folder'))
      vim.keymap.set('n', 'i', function()
        api.tree.change_root_to_node(api.tree.get_node_under_cursor())
      end,
        opts('Enter folder'))
    end

    local HEIGHT_RATIO = 0.8
    local WIDTH_RATIO  = 0.5

    ntree.setup({
      on_attach = my_on_attach,
      filters = {
        dotfiles = true
      },
      select_prompts = true,
      view = {
        centralize_selection = true,
        preserve_window_proportions = false,
        signcolumn = "no",
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2)
                - vim.opt.cmdheight:get()
            return {
              border = "rounded",
              relative = "editor",
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
              style = "minimal",
            }
          end,
        },
      },
    })

    vim.keymap.set("n", "<leader>tn", require("nvim-tree.api").marks.navigate.next, {
      desc = "NvimTree go to next bookmark"
    })
    vim.keymap.set("n", "<leader>tp", require("nvim-tree.api").marks.navigate.prev, {
      desc = "NvimTree go to previous bookmark"
    })
    vim.keymap.set("n", "<leader>ts", require("nvim-tree.api").marks.navigate.select, {
      desc = "NvimTree bookmarks select"
    })
  end,
}
