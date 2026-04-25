require("mason").setup()

require("mason-tool-installer").setup({
    ensure_installed = {"lua_ls", "gopls", "ts_ls", "eslint", "rust_analyzer", "jsonls", "bashls", "stylua", "prettier",
                        "goimports", "shfmt"}
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT"
            },
            diagnostics = {
                globals = {"vim"}
            },
            workspace = {
                checkThirdParty = false,
                library = {vim.env.VIMRUNTIME, "${3rd}/luv/library"}
            },
            telemetry = {
                enable = false
            }
        }
    }
})

vim.lsp.config("gopls", {
    settings = {
        gopls = {
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true
        }
    }
})

vim.lsp.config("ts_ls", {
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true
            }
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true
            }
        }
    }
})

vim.lsp.config("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true
            },
            check = {
                command = "clippy"
            }
        }
    }
})

require("mason-lspconfig").setup({
    automatic_enable = {
        exclude = {"ts_ls"}
    }
})

vim.lsp.enable("ts_ls")

vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,

    float = {
        border = "rounded",
        source = "if_many"
    },

    underline = true,

    virtual_text = {
        spacing = 2,
        source = "if_many",
        prefix = "●"
    },

    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.INFO] = "I",
            [vim.diagnostic.severity.HINT] = "H"
        }
    }
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf

        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {
                buffer = bufnr,
                silent = true,
                desc = desc
            })
        end

        map("n", "K", vim.lsp.buf.hover, "LSP hover")
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, "Code action")

        map("n", "<leader>f", function()
            vim.lsp.buf.format({
                async = true
            })
        end, "Format buffer")
    end
})
