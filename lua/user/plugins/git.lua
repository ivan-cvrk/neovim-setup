return {
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { "folke/snacks.nvim" },
    config = function()
      require('gitsigns').setup {
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            vim.api.nvim_buf_set_keymap(bufnr, mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', '', { desc = 'Next git hunk', callback = function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end })

          map('n', '[c', '', { desc = 'Previous git hunk', callback = function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end })

          -- Actions
          map('n', '<leader>hs', '', { desc = 'Stage hunk', callback = gitsigns.stage_hunk })
          map('n', '<leader>hr', '', { desc = 'Reset hunk', callback = gitsigns.reset_hunk })

          map('v', '<leader>hs', '', { desc = 'Stage hunk (visual)', callback = function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end })

          map('v', '<leader>hr', '', { desc = 'Reset hunk (visual)', callback = function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end })

          map('n', '<leader>hS', '', { desc = 'Stage buffer', callback = gitsigns.stage_buffer })
          map('n', '<leader>hR', '', { desc = 'Reset buffer', callback = gitsigns.reset_buffer })
          map('n', '<leader>hp', '', { desc = 'Preview hunk', callback = gitsigns.preview_hunk })
          map('n', '<leader>hi', '', { desc = 'Preview hunk inline', callback = gitsigns.preview_hunk_inline })

          map('n', '<leader>hb', '', { desc = 'Blame line', callback = function()
            gitsigns.blame_line({ full = true })
          end })

          map('n', '<leader>hd', '', { desc = 'Diff this', callback = gitsigns.diffthis })

          map('n', '<leader>hD', '', { desc = 'Diff this (~)', callback = function()
            gitsigns.diffthis('~')
          end })

          map('n', '<leader>hQ', '', { desc = 'Set qflist all', callback = function() gitsigns.setqflist('all') end })
          map('n', '<leader>hq', '', { desc = 'Set qflist', callback = gitsigns.setqflist })

          -- Toggles
          map('n', '<leader>tb', '', { desc = 'Toggle blame', callback = gitsigns.toggle_current_line_blame })
          map('n', '<leader>tw', '', { desc = 'Toggle word diff', callback = gitsigns.toggle_word_diff })

          -- Text object
          -- map({'o', 'x'}, 'ih', '', { desc = 'Select hunk', callback = gitsigns.select_hunk })
        end
      }

      local function git_actions()
        local gs = require("gitsigns")

        local actions = {
          { label = "Stage hunk", fn = gs.stage_hunk },
          { label = "Reset hunk", fn = gs.reset_hunk },
          { label = "Preview hunk", fn = gs.preview_hunk },
          { label = "Preview hunk inline", fn = gs.preview_hunk_inline },
          { label = "Stage buffer", fn = gs.stage_buffer },
          { label = "Reset buffer", fn = gs.reset_buffer },
          { label = "Blame line", fn = function()
            gs.blame_line({ full = true })
          end },
          { label = "Diff this", fn = gs.diffthis },
          { label = "Diff this (~)", fn = function()
            gs.diffthis("~")
          end },
          { label = "Toggle blame", fn = gs.toggle_current_line_blame },
          { label = "Toggle word diff", fn = gs.toggle_word_diff },
        }

        vim.ui.select(actions, {
          prompt = "Git actions",
          format_item = function(item)
            return item.label
          end,
        }, function(choice)
          if choice then
            choice.fn()
          end
        end)
      end

      vim.keymap.set("n", "\\h", git_actions, { desc = "Git hunk actions" })
    end
  },

  {
    "sindrets/diffview.nvim",
  }
}
