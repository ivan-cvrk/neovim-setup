require('user.settings')
require('user.autocmd')
require('user.keybinds')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = 'user.plugins' },
    { import = 'user.plugins.lsp' }
}, { ui = { title = 'Lazy', border = "rounded" } })

if vim.g.neovide then
    vim.o.guifont = 'JetBrainsMonoNL Nerd Font:h12:e-antialiasing'
    vim.g.neovide_cursor_vfx_mode = "torpedo"
end
