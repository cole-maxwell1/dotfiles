require("lazy").setup({{
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000
}, {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {'nvim-lua/plenary.nvim'}
}, -- Fuzzy finder
{
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
}, -- syntax highlighting
{
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    dependencies = {{'williamboman/mason.nvim'}, {'williamboman/mason-lspconfig.nvim'}, {'neovim/nvim-lspconfig'},
                    {'hrsh7th/nvim-cmp'}, {'hrsh7th/cmp-nvim-lsp'}, {'L3MON4D3/LuaSnip'}} -- LSP support
}})
