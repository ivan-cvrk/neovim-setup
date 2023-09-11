require('user.settings')
require('user.autocmd')
require('user.keybinds')

--local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--if not vim.loop.fs_stat(lazypath) then
--  vim.fn.system({
--    "git",
--    "clone",
--    "--filter=blob:none",
--    "https://github.com/folke/lazy.nvim.git",
--    "--branch=stable", -- latest stable release
--    lazypath,
--  })
--end
--vim.opt.rtp:prepend(lazypath)
--
--require("lazy").setup('user.plugins')
--
vim.cmd.colorscheme 'catppuccin'

require('user.plugins.lsp.lspconfig')
require('user.plugins.lsp.autocomplete')

require('user.plugins.treesitter')
require('user.plugins.neogen')
require('user.plugins.lspkind')
require('user.plugins.autopairs')
require('user.plugins.telescope')
require('user.plugins.lualine')
require('user.plugins.nvim-tree')
require('user.plugins.symbols-outline')
require('user.plugins.nvim-dap')
require('user.plugins.luasnip')

