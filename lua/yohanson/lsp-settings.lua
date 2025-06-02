local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    cmp_lsp.default_capabilities()
)

vim.lsp.config('*', {
    capabilities = capabilities,
})

vim.lsp.config('phpactor',
{
    settings = {
        phpactor = {
            language_server = {
                diagnostic_ignore_codes = {
                    "worse.docblock_missing_param",
                    "worse.docblock_missing_return_type",
                }
            }
        }
    }
})

vim.lsp.config('docker_compose_language_service',
{
    settings = {
        telemetry = { enable = false },
    },
})

vim.lsp.config('ts_ls',
{
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = "/usr/lib/node_modules/@vue/language-server",
                languages = { "vue" },
            },
        },
    },
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

vim.lsp.config('lua_ls', {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            format = {
                enable = true,
                -- Put format options here
                -- NOTE: the value should be STRING!!
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                }
            },
        }
    }
})


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<Enter>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = cmp.config.sources({
        { name = "codeium" },
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})

vim.diagnostic.config({
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})
