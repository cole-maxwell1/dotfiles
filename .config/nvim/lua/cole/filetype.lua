-- Register custom filetypes for EDI documents
vim.filetype.add({
    extension = {
        edi = "x12",
        dat = "x12"
    }
})
