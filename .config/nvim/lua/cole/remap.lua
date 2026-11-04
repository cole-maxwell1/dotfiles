vim.g.mapleader = " "

local M = {}
local files

function M.find_files(arg)
    if not files then
        local result = vim.system({"rg", "--files"}, {
            text = true
        }):wait()

        if result.code == 0 then
            files = vim.split(result.stdout, "\n", {
                plain = true,
                trimempty = true
            })
        else
            files = vim.fn.globpath(".", "**", false, true)
            files = vim.tbl_filter(function(path)
                return vim.fn.isdirectory(path) == 0
            end, files)
        end
    end

    return arg == "" and files or vim.fn.matchfuzzy(files, arg)
end

vim.opt.findfunc = "v:lua.require'cole.remap'.find_files"
vim.opt.wildmode = "noselect:lastused,full"
vim.opt.wildoptions = "pum"

vim.api.nvim_create_autocmd("CmdlineEnter", {
    pattern = ":",
    callback = function()
        files = nil
    end
})

vim.api.nvim_create_autocmd("CmdlineChanged", {
    pattern = ":",
    callback = function()
        if vim.fn.getcmdline():match("^find%s") then
            vim.fn.wildtrigger()
        end
    end
})

vim.keymap.set("n", "<leader>ff", ":find ", {
    desc = "Find files"
})

return M
