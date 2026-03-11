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
          auto_close = true,
          jump = { close = true },
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
    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = true,
      },
      hover = {
        placement = "center",
      }
    },

    -- Explorer
    explorer = { enabled = true },

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


    -- Mermaid previews
    local mermaid_preview = vim.api.nvim_create_augroup("MermaidPreview", { clear = true })

    local state = {
      active = false,
    }

    local function in_mermaid_block(buf, row)
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local i = row + 1 -- Lua 1-based for easier scanning

      local start_line = nil
      local fence_lang = nil

      -- find nearest opening fence above cursor
      for l = i, 1, -1 do
        local line = lines[l]
        local lang = line:match("^```(%S+)%s*$")
        if lang then
          start_line = l
          fence_lang = lang
          break
        end
        if line:match("^```%s*$") then
          break
        end
      end

      if not start_line or fence_lang ~= "mermaid" then
        return false
      end

      -- find closing fence below opening
      for l = start_line + 1, #lines do
        if lines[l]:match("^```%s*$") then
          return i > start_line and i < l
        end
      end

      return false
    end

    local function open_centered_mermaid_hover()
      if state.active then
        return
      end
      state.active = true

      vim.schedule(function()
        pcall(function()
          Snacks.image.hover({
            -- big centered preview
            relative = "editor",
            width = math.floor(vim.o.columns * 0.75),
            height = math.floor(vim.o.lines * 0.75),
            pos = {
              math.floor(vim.o.lines * 0.125),
              math.floor(vim.o.columns * 0.125),
            },
          })
        end)
      end)
    end

    local function close_mermaid_hover()
      state.active = false
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local ok, cfg = pcall(vim.api.nvim_win_get_config, win)
        if ok and cfg and cfg.relative ~= "" then
          local ok_buf, buf = pcall(vim.api.nvim_win_get_buf, win)
          if ok_buf and vim.bo[buf].filetype == "snacks_image" then
            pcall(vim.api.nvim_win_close, win, true)
          end
        end
      end
    end

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter" }, {
      group = mermaid_preview,
      pattern = { "*.md", "*.markdown" },
      callback = function(args)
        local row = vim.api.nvim_win_get_cursor(0)[1] - 1
        if in_mermaid_block(args.buf, row) then
          open_centered_mermaid_hover()
        else
          close_mermaid_hover()
        end
      end,
    })

    vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
      group = mermaid_preview,
      callback = function()
        close_mermaid_hover()
      end,
    })

  end,
}
