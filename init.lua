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

vim.o.guifont = 'FiraCode Nerd Font Mono:h12:e-antialiasing'
if vim.g.neovide then
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_theme = 'auto'
  vim.g.neovide_cursor_vfx_mode = 'torpedo'
  vim.g.neovide_show_border = true

  vim.g.neovide_text_gamma = 0.0
  vim.g.neovide_text_contrast = 0.5

  vim.g.neovide_floating_blur_amount_x = 3.0
  vim.g.neovide_floating_blur_amount_y = 3.0

  vim.api.nvim_set_option_value('winblend', 20, {scope = 'global'})

  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * (vim.g.neovide_normal_opacity or 0.5)))
  end
  vim.g.neovide_background_color = "#0f1117" .. alpha()

  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5

  vim.g.neovide_opacity = 1.0
  vim.g.neovide_normal_opacity = 1.0

  vim.g.neovide_theme = 'auto'

  vim.g.neovide_refresh_rate = 240
  vim.g.neovide_refresh_rate_idle = 5

  vim.g.neovide_cursor_animation_length = 0.06

  vim.g.neovide_cursor_antialiasing = true
end
