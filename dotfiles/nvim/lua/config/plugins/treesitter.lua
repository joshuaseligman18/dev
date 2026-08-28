return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")

            local tsAutoInstallGroup = vim.api.nvim_create_augroup("TreesitterAutoInstall", { clear = true })

            vim.api.nvim_create_autocmd("FileType", {
                group = tsAutoInstallGroup,
                callback = function(event)
                    local lang = vim.treesitter.language.get_lang(event.match)
                    if not lang then return end
                    if not vim.tbl_contains(ts.get_available(), lang) then return end

                    if vim.tbl_contains(ts.get_installed(), lang) then
                        vim.treesitter.start(event.buf, lang)
                        return
                    end

                    local install_task = ts.install({ lang })
                    if not install_task then return end
                    install_task:await(function(err)
                        if err then
                            vim.notify(
                                ("Failed to install Treesitter parser for %s: %s"):format(lang, err),
                                vim.log.levels.ERROR
                            )
                            return
                        end

                        if vim.api.nvim_buf_is_valid(event.buf) then vim.treesitter.start(event.buf, lang) end
                    end)
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
    },
}
