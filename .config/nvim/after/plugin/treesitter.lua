-- Configure nvim-treesitter with defaults
require("nvim-treesitter").setup()

-- Register the custom x12 parser for the nvim-treesitter main branch API
vim.api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
        require("nvim-treesitter.parsers").x12 = {
            install_info = {
                url = "https://github.com/hugginsio/tree-sitter-x12",
                files = {"src/parser.c"},
                branch = "main",
                generate_requires_npm = false,
                requires_generate_from_grammar = false
            },
            filetype = "x12"
        }
    end
})

-- Explicitly trigger installation for the required parsers
require("nvim-treesitter").install({"bash", "c", "c_sharp", "diff", "go", "html", "javascript", "jsdoc", "json", "lua",
                                    "luadoc", "luap", "markdown", "markdown_inline", "python", "query", "regex", "toml",
                                    "tsx", "typescript", "vim", "vimdoc", "xml", "yaml", "x12"})

-- Automatically enable treesitter features for all buffers
local ts_group = vim.api.nvim_create_augroup("TreesitterStart", {
    clear = true
})
vim.api.nvim_create_autocmd("FileType", {
    group = ts_group,
    callback = function(args)
        -- Bypass treesitter if the file exceeds 200 MiB
        local max_filesize = 200 * 1024 * 1024
        local filepath = vim.api.nvim_buf_get_name(args.buf)
        local ok, stats = pcall(vim.uv.fs_stat, filepath)

        if ok and stats and stats.size > max_filesize then
            return
        end

        -- Start treesitter highlighting
        -- Using pcall prevents errors if a parser is missing for the current filetype
        pcall(vim.treesitter.start, args.buf)
    end
})
