require("mason").setup()

require("mason-tool-installer").setup({
    ensure_installed = {
        "lua-language-server",
        "gopls",
        "typescript-language-server",
        "eslint-lsp",
        "rust-analyzer",
        "roslyn-language-server",
        "json-lsp",
        "bash-language-server"
    },
    integrations = {
        ["mason-lspconfig"] = false,
        ["mason-null-ls"] = false,
        ["mason-nvim-dap"] = false
    }
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

vim.lsp.enable({"lua_ls", "gopls", "ts_ls", "eslint", "rust_analyzer", "roslyn_ls", "jsonls", "bashls"})

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
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.lsp.completion.enable(true, client.id, args.buf, {
                autotrigger = true
            })
        end
    end
})
