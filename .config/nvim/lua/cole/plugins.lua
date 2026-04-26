-- Define plugins for Neovim 0.12 native package manager.
vim.pack.add({
    --Theme
    "https://github.com/bluz71/vim-moonfly-colors",
    --File switch
    { src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.5" },
    --Syntax
    "https://github.com/nvim-treesitter/nvim-treesitter",
    --LSP
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    --Auto complete
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/L3MON4D3/LuaSnip",
})