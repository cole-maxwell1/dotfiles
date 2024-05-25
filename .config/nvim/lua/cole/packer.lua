-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        -- or, branch = '0.1.x',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    -- syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- LSP support
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {{'williamboman/mason.nvim'}, {'williamboman/mason-lspconfig.nvim'}, {'neovim/nvim-lspconfig'},
                    {'hrsh7th/nvim-cmp'}, {'hrsh7th/cmp-nvim-lsp'}, {'L3MON4D3/LuaSnip'}}
    }

    use {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim"}

end)

