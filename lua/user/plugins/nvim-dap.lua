return {
  { 'mfussenegger/nvim-dap-python', lazy = true },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'rcarriga/nvim-dap-ui', config = true },
      { 'theHamsta/nvim-dap-virtual-text', opts = {} },
      { 'nvim-telescope/telescope-dap.nvim' },
      { 'nvim-neotest/nvim-nio' },
    },
    keys = {
      {
        '<F5>', function() require('dap').continue() end,
        silent = true, mode = 'n', desc = 'Dap continue'
      },
      {
        '\\b',
        function()
          if vim.bo.modifiable then
            require('dap').toggle_breakpoint()
          end
        end,
        silent = true, mode = 'n', desc = 'Dap toggle breakpoint'
      },
      {
        '\\l',
        function()
          if vim.bo.modifiable then
            require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
          end
        end
        , silent = true, mode = 'n', desc = 'Dap log point'
      },
    },
    config = function()
      local dap, dapui, widgets = require('dap'), require('dapui'), require('dap.ui.widgets')

      vim.keymap.set('n', '<F6>', dap.step_over, { desc = 'Dap step over' })
      vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Dap step into' })
      vim.keymap.set('n', '<F8>', dap.step_out, { desc = 'Dap step out' })
      vim.keymap.set('n', '<F9>', dap.terminate, { desc = 'Dap terminate' })
      vim.keymap.set('n', '\\dr', dap.repl.open, { desc = 'Dap open repl' })
      vim.keymap.set('n', '\\dl', dap.run_last, { desc = 'Dap last run' })
      vim.keymap.set('n', '\\dp', dap.pause, { desc = 'Dap pause' })

      vim.keymap.set({ 'n', 'v' }, '\\dh', widgets.hover, { desc = 'Dap widgets hover' })
      vim.keymap.set({ 'n', 'v' }, '\\dp', widgets.preview, { desc = 'Dap widgets preview' })
      vim.keymap.set('n', '\\df',
        function() widgets.centered_float(widgets.frames) end,
        { desc = 'Dap widgets frames' }
      )
      vim.keymap.set('n', '\\ds',
        function() widgets.centered_float(widgets.scopes) end,
        { desc = 'Dap widgets scopes' }
      )
      vim.keymap.set('n', '\\dt',
        function() widgets.centered_float(widgets.threads) end,
        { desc = 'Dap widgets threads' }
      )

      vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#993939' })
      vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef' })
      vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379' })

      vim.fn.sign_define('DapBreakpoint', {
        text = '',
        texthl = 'DapBreakpoint',
        linehl = 'DapBreakpoint',
        numhl = 'DapBreakpoint'
      })
      vim.fn.sign_define('DapBreakpointCondition', {
        text = 'ﳁ',
        texthl = 'DapBreakpoint',
        linehl = 'DapBreakpoint',
        numhl = 'DapBreakpoint'
      })
      vim.fn.sign_define('DapBreakpointRejected', {
        text = '',
        texthl = 'DapBreakpoint',
        linehl = 'DapBreakpoint',
        numhl = 'DapBreakpoint'
      })
      vim.fn.sign_define('DapLogPoint', {
        text = '',
        texthl = 'DapLogPoint',
        linehl = 'DapLogPoint',
        numhl = 'DapLogPoint'
      })
      vim.fn.sign_define('DapStopped', {
        text = '',
        texthl = 'DapStopped',
        linehl = 'DapStopped',
        numhl = 'DapStopped'
      })

      -- Close dap widgets with q
      vim.cmd('autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>')

      -- Start dapui on debugging
      local nvim_tree_open = false
      dap.listeners.after.event_initialized.dapui_config = function()
        nvim_tree_open = require('nvim-tree.view').is_visible()
        require('nvim-tree.api').tree.close()
        dapui.open()
      end

      local on_exit = function()
        dapui.close()
        if nvim_tree_open then
          require('nvim-tree.api').tree.open()
        end
        require 'nvim-dap-virtual-text'.refresh()
      end

      vim.keymap.set('n', '\\du', on_exit, { desc = 'Dap close UI' })

      dap.listeners.before.event_terminated.dapui_config = on_exit
      dap.listeners.before.event_exited.dapui_config = on_exit

      -- telescope extension loaded here since it requires and loads dap
      require 'telescope'.load_extension('dap')

      -- Debuggers

      require 'dap-python'.setup('/usr/bin/python3')

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
      }

      local last_program, last_args = nil, nil
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            last_program = vim.fn.input('Path to executable: ', last_program or vim.fn.getcwd() .. '/', 'file')
            return last_program
          end,
          args = function()
            local input = vim.fn.input('Program arguments: ', table.concat(last_args or {}, " "))
            last_args = vim.split(input, "%s+", { trimempty = true })
            return last_args
          end, -- provide arguments if needed
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = true,
        },
        {
          name = "Select and attach to process",
          type = "gdb",
          request = "attach",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          pid = function()
            local name = vim.fn.input('Executable name (filter): ')
            return require("dap.utils").pick_process({ filter = name })
          end,
          cwd = '${workspaceFolder}'
        },
        {
          name = 'Attach to gdbserver :1234',
          type = 'gdb',
          request = 'attach',
          target = 'localhost:1234',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}'
        }
      }

      dap.configurations.c = dap.configurations.cpp

      -- Golang
      dap.adapters.delve = {
        type = 'server',
        port = '${port}',
        executable = {
          command = 'dlv',
          args = { 'dap', '-l', '127.0.0.1:${port}' },
        }
      }

      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}"
        },
        {
          type = "delve",
          name = "Debug test", -- configuration for debugging test files
          request = "launch",
          mode = "test",
          program = "${file}"
        },
        -- works with go.mod packages and sub packages
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}"
        }
      }
    end
  },
}
