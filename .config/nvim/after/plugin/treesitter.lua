local parsers = {"bash", "c", "c_sharp", "diff", "go", "html", "javascript", "jsdoc", "json", "lua", "luadoc",
                 "luap", "markdown", "markdown_inline", "python", "query", "regex", "toml", "tsx", "typescript",
                 "vim", "vimdoc", "xml", "yaml", "x12"}

vim.api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
        require("nvim-treesitter.parsers").x12 = {
            install_info = {
                url = "https://github.com/hugginsio/tree-sitter-x12",
                branch = "main"
            }
        }
    end
})

require("nvim-treesitter").setup()
require("nvim-treesitter").install(parsers)

local ts_group = vim.api.nvim_create_augroup("TreesitterStart", {
    clear = true
})

vim.api.nvim_create_autocmd("FileType", {
    group = ts_group,
    callback = function(args)
        local max_filesize = 200 * 1024 * 1024
        local filepath = vim.api.nvim_buf_get_name(args.buf)
        local ok, stats = pcall(vim.uv.fs_stat, filepath)

        if ok and stats and stats.size > max_filesize then
            return
        end

        pcall(vim.treesitter.start, args.buf)
    end
})
