return {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle focus=true<cr>",
            desc = "Diagnostics",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
            desc = "Buffer Diagnostics",
        },
    },
}
