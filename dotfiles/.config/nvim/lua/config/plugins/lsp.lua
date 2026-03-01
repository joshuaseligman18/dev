return {
    "neovim/nvim-lspconfig",
    tag = "v2.5.0",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {
                ensure_installed = { "lua_ls" },
                automatic_enable = true,
            },
        },
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        local lspKeymapGroup = vim.api.nvim_create_augroup("LspKeymap", { clear = true })
        vim.api.nvim_create_autocmd("LspAttach", {
            group = lspKeymapGroup,
            callback = function(event)
                local opts = { buffer = event.buf }

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1, float = false }) end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = -1, float = false }) end, opts)
            end,
        })

        vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
            }),
        })

        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        command = "clippy"
                    }
                }
            }
        })

        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = { current_line = false },
            underline = true,
            update_in_insert = true,
            float = false,
        })
    end,
}
