-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Formatting
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Scroll settings
vim.opt.scrolloff = 8 -- Always 8 lines above

-- Color scheme
vim.cmd.colorscheme("moonfly")

-- Diff: Muted Red on Crimson
vim.api.nvim_set_hl(0, "DiffAdd", {
    bg = "#1e3a1e",
    fg = "NONE"
}) -- added lines: muted green
vim.api.nvim_set_hl(0, "DiffDelete", {
    bg = "#3d1a1a",
    fg = "#6b3a3a"
}) -- deleted lines: muted red
vim.api.nvim_set_hl(0, "DiffChange", {
    bg = "#3a1c1c",
    fg = "NONE"
}) -- changed lines: light red wash
vim.api.nvim_set_hl(0, "DiffText", {
    bg = "#8b2035",
    fg = "NONE",
    bold = true
}) -- char diff: saturated red (crimson)

-- Dynamic diff window width sizing
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if not vim.wo.diff then
            return
        end

        -- Defer execution to unblock the initial UI render
        vim.schedule(function()
            -- Limit the line check to the first 2000 lines to prevent long startup times on large files
            local max_lines_to_check = 2000
            local line_count = vim.api.nvim_buf_line_count(0)
            local limit = math.min(line_count, max_lines_to_check)
            local lines = vim.api.nvim_buf_get_lines(0, 0, limit, false)
            local max_len = 0

            for _, line in ipairs(lines) do
                local len = vim.api.nvim_strwidth(line)
                if len > max_len then
                    max_len = len
                end
            end

            -- Account for gutter columns (line numbers, sign column, fold column).
            local gutter = 0
            if vim.wo.number or vim.wo.relativenumber then
                gutter = gutter + vim.wo.numberwidth
            end
            if vim.wo.signcolumn ~= "no" then
                gutter = gutter + 2
            end

            local fold_col = tonumber(vim.wo.foldcolumn) or 0
            gutter = gutter + fold_col

            local desired = max_len + gutter + 1 -- +1 for the right edge padding

            -- Cap at exactly half the terminal width.
            local half = math.floor(vim.o.columns / 2)
            local width = math.min(desired, half)

            vim.api.nvim_win_set_width(0, width)
        end)
    end
})
