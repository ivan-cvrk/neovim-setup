local A = vim.api

-- Custom filetypes
vim.filetype.add({
    extension = {
        eslintrc = 'json',
        prettierrc = 'json',
        conf = 'conf',
        mdx = 'markdown',
        mjml = 'html',
        vert = 'glsl',
        frag = 'glsl',
        geom = 'glsl',
        ixx = 'cpp',
    },
    pattern = {
        ['.*%.env.*'] = 'sh',
        ['.*ignore'] = 'conf',
        -- ['.*tmux.*conf$'] = 'tmux',
    },
    filename = {
        ['yup.lock'] = 'yaml',
    },
})

local num_au = A.nvim_create_augroup('MyCustomCommands', { clear = true })

-- Open help vertically and press q to exit
A.nvim_create_autocmd('BufEnter', {
    group = num_au,
    pattern = '*.txt',
    callback = function()
        if vim.bo.buftype == 'help' then
            A.nvim_command('wincmd L')
            vim.keymap.set('n', 'q', '<CMD>q<CR>', { buffer = 0 })
        end
    end,
})

-- Highlight the region on yank
A.nvim_create_autocmd('TextYankPost', {
    group = num_au,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 120 })
    end,
})

A.nvim_create_autocmd('BufEnter', {
    group = num_au,
    desc = 'Use tab in Makefile',
    callback = function(opt)
        if vim.bo[opt.buf].filetype == 'makefile' then
            vim.cmd.setlocal 'noexpandtab'
        end
    end
})

-- Go setup
A.nvim_create_autocmd('BufEnter', {
    group = num_au,
    pattern = '*.go',
    callback = function(opt)
        if vim.bo[opt.buf].filetype == 'go' then
            vim.o.tabstop = 4
            vim.cmd.setlocal 'noexpandtab'
            vim.cmd.setlocal 'listchars+=tab:\\ \\ '
        end
    end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = num_au,
  pattern = 'markdown',
  callback = function(args)
    vim.keymap.set('n', '<leader>f', function()
      vim.cmd('write')
      vim.cmd('silent !prettier --write --print-width 80 --prose-wrap always %')
      vim.cmd('edit')
    end, { buffer = args.buf, noremap = true, desc = 'Format with prettier' })
  end,
})

-- Make dadbod query results window at least half the screen high
vim.api.nvim_create_autocmd('FileType', {
  group = num_au,
  pattern = 'dbout',
  callback = function()
    local half = math.floor(vim.o.lines / 2)
    if vim.api.nvim_win_get_height(0) < half then
      vim.api.nvim_win_set_height(0, half)
    end
  end,
})

-- Jq probe
vim.api.nvim_create_autocmd("FileType", {
  group = num_au,
  pattern = { "json", "jsonl" },

  callback = function(args)
    vim.api.nvim_buf_create_user_command(
      args.buf,
      "Jq",

      function(opts)
        local file = vim.api.nvim_buf_get_name(args.buf)

        if file == "" then
          vim.notify("Current buffer has no file", vim.log.levels.ERROR)
          return
        end

        local tokens = vim.split(vim.trim(opts.args), "%s+")
        local flags = {}

        local i = 1

        while i <= #tokens and tokens[i]:match("^%-%a+$") do
          table.insert(flags, tokens[i])
          i = i + 1
        end

        local query = table.concat(
          vim.list_slice(tokens, i),
          " "
        )

        if query == "" then
          vim.notify(
            "Usage: :Jq [-flags] <jq filter>",
            vim.log.levels.ERROR
          )
          return
        end

        local cmd = { "jq" }

        vim.list_extend(cmd, flags)

        table.insert(cmd, query)
        table.insert(cmd, file)

        local output = vim.fn.system(cmd)

        if vim.v.shell_error ~= 0 then
          vim.notify(output, vim.log.levels.ERROR)
          return
        end

        vim.cmd("vnew")

        local buf = vim.api.nvim_get_current_buf()

        vim.bo[buf].buftype = "nofile"
        vim.bo[buf].bufhidden = "wipe"
        vim.bo[buf].swapfile = false
        vim.bo[buf].filetype = "json"

        local lines = vim.split(output, "\n", { plain = true })

        if lines[#lines] == "" then
          table.remove(lines)
        end

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      end,

      {
        nargs = "*",
      }
    )
  end,
})
