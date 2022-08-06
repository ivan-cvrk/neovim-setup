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


-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerSync',
})


-- Use protected call so we don't error on first use
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


return require('packer').startup({
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
        --     Style        --
        ----------------------

        use {
            'lunarvim/onedarker.nvim',
            branch = 'freeze'
        }

        use('ayu-theme/ayu-vim')

        use('joshdick/onedark.vim')

        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

        ----------------------
        --    Navigation    --
        ----------------------

        use('simrat39/symbols-outline.nvim')

        use {
            'kyazdani42/nvim-tree.lua',
            requires = {
                'kyzdani42/nvim-web-devicons'
            },
            tag = 'nightly'
        }

        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.x',
            requires = { { 'nvim-lua/plenary.nvim' }, { 'BurntSushi/ripgrep' } }
        }

        use('nvim-telescope/telescope-project.nvim')

        use('glepnir/dashboard-nvim')

        ----------------------
        -- Language Servers --
        ----------------------

        use('neovim/nvim-lspconfig')

        use('hrsh7th/nvim-cmp')

        use('hrsh7th/cmp-nvim-lsp')

        use('L3MON4D3/LuaSnip')

        use('saadparwaiz1/cmp_luasnip')

        ----------------------
        --     Editing     ---
        ----------------------

        use('windwp/nvim-autopairs')

        use {
            'nvim-treesitter/nvim-treesitter',
            run = ":TSUpdate",
        }

        use('p00f/nvim-ts-rainbow')

    end,
})
