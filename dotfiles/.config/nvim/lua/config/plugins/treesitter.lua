return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local tsAutoInstallGroup = vim.api.nvim_create_augroup("TreesitterAutoInstall", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = tsAutoInstallGroup,
                pattern = { "*" },
                callback = function(event)
                    local ts = require("nvim-treesitter")

                    local lang = vim.treesitter.language.get_lang(event.match)
                    if not vim.tbl_contains(ts.get_available(), lang) then return end

                    if not vim.tbl_contains(ts.get_installed(), lang) then
                        if not ts.install({ lang }) then return end
                    end

                    vim.treesitter.start(event.buf, lang)
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        after = "nvim-treesitter"
    }
}
