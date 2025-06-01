return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            "stevearc/conform.nvim",
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()

            require("mason").setup()
            require("mason-lspconfig").setup()
        end
    },
    {
        -- highlight current arg
        "ray-x/lsp_signature.nvim",
        config = function ()
            local lsp_signature = require('lsp_signature')
            lsp_signature.on_attach({
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                handler_opts = {
                    border = "rounded"
                },
                hint_enable = false,
            }, bufnr)

            vim.keymap.set('n', '<C-k>', function()
                require('lsp_signature').toggle_float_win()
            end, { silent = true, noremap = true, desc = 'toggle signature' })
        end
    },
}
