local ansibleFileTypGroup = vim.api.nvim_create_augroup("AnsibleFileType", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = ansibleFileTypGroup,
    pattern = { "*.ansible" },
    callback = function()
        vim.bo.syntax = "yaml"
        vim.bo.filetype = "yaml.ansible"
    end
})
