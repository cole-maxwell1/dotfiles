require("lazy").setup({ -- Fuzzy finder
{
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {'nvim-lua/plenary.nvim'}
}, -- syntax highlighting
{
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
}, -- LSP support
{
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {{'williamboman/mason.nvim'}, {'williamboman/mason-lspconfig.nvim'}, {'neovim/nvim-lspconfig'},
                    {'hrsh7th/nvim-cmp'}, {'hrsh7th/cmp-nvim-lsp'}, {'L3MON4D3/LuaSnip'}}
}})
