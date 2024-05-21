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
