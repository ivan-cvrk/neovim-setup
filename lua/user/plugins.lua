local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSRTAP = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end


local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require('packer.util').float { border = 'single' }
        end
    }
}


return packer.startup({
    function(use)
        ---------------------
        -- Package Manager --
        ---------------------

        use('wbthomason/packer.nvim')

        ----------------------
        -- Required plugins --
        ----------------------

        use('nvim-lua/plenary.nvim')

        use('nvim-lua/popup.nvim')

        ----------------------
        --      Style       --
        ----------------------

        use('catppuccin/nvim')

        use {
            'lunarvim/onedarker.nvim',
            branch = 'freeze'
        }

        use('joshdick/onedark.vim')

        use {
            'nvim-lualine/lualine.nvim',
            requires = {
                'nvim-tree/nvim-web-devicons',
            }
        }

        ----------------------
        --    Navigation    --
        ----------------------

        use('simrat39/symbols-outline.nvim')

        use {
            'nvim-tree/nvim-tree.lua',
            requires = {
                'nvim-tree/nvim-web-devicons',
            },
            tag = 'nightly'
        }

        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.x',
            requires = { { 'nvim-lua/plenary.nvim' }, { 'BurntSushi/ripgrep' } }
        }

        use('nvim-telescope/telescope-project.nvim')

        use {
            'glepnir/dashboard-nvim',
            config = function()
                require('user.plugins.dashboard')
            end,
            requires = { 'nvim-tree/nvim-web-devicons' }
        }

        ----------------------
        -- Language Servers --
        ----------------------

        use('neovim/nvim-lspconfig')

        use('hrsh7th/nvim-cmp')

        use('hrsh7th/cmp-nvim-lsp')

        use('hrsh7th/cmp-nvim-lua')

        use('hrsh7th/cmp-path')

        use('hrsh7th/cmp-buffer')

        use('onsails/lspkind.nvim')

        use('L3MON4D3/LuaSnip')

        use('saadparwaiz1/cmp_luasnip')

        ----------------------
        --    Debugging    ---
        ----------------------

        use('mfussenegger/nvim-dap')

        use('rcarriga/nvim-dap-ui')

        use('nvim-telescope/telescope-dap.nvim')

        use('theHamsta/nvim-dap-virtual-text')

        use('mfussenegger/nvim-dap-python')

        ----------------------
        --     Editing     ---
        ----------------------

        use('windwp/nvim-autopairs')

        use('windwp/nvim-ts-autotag')

        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
        }

        use('nvim-treesitter/playground')

        use('HiPhish/nvim-ts-rainbow2')

        use('danymat/neogen')
    end,
})
