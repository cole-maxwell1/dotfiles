local lsp_zero = require('lsp-zero')

-- Attach keybindings on LSP connection
local lsp_attach = function(client, bufnr)
    lsp_zero.default_keymaps({
        buffer = bufnr
    })
end

lsp_zero.extend_lspconfig({
    lsp_attach = lsp_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities()
})

-- Configure diagnostic signs natively for Neovim v0.11+
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '»'
        }
    }
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'lua_ls', 'ts_ls', 'eslint', 'gopls', 'rust_analyzer'},
    handlers = {function(server_name)
        -- Map legacy server names to their modern equivalents
        if server_name == 'tsserver' then
            server_name = 'ts_ls'
        end

        -- Verify the server configuration is accessible to prevent indexing errors
        local has_config, _ = pcall(function()
            return require('lspconfig')[server_name]
        end)
        if has_config then
            require('lspconfig')[server_name].setup({})
        else
            vim.notify("LSP configuration not accessible for: " .. server_name, vim.log.levels.WARN)
        end
    end}
})
