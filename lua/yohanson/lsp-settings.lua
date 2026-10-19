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
    -- ~/ext-repos/phpactor/build/phpactor.phar
    cmd = { os.getenv('HOME') .. '/bin/phpactor', 'language-server' },
    init_options = {
        ["symfony.enabled"] = true,
        ["completion_worse.completor.symfony.enabled"] = true,
        ["completion_worse.completor.doctrine_annotation.enabled"] = true,
        ["language_server.diagnostic_ignore_codes"] = {
            "worse.missing_return_type",
            "worse.docblock_missing_param",
            "worse.docblock_missing_return_type",
        },
        ["language_server_psalm.enabled"] = false,
        ["language_server_psalm.bin"] = "~/bin/psalm",
        ["language_server_psalm.error_level"] = 6,

        ["language_server_phpstan.enabled"] = true,
        ["language_server_phpstan.bin"] = "/usr/bin/phpstan",
        ["language_server_phpstan.level"] = "3",
        ["language_server_phpstan.severity"] = 4,
        -- ["language_server_phpstan.config"] = os.getenv('HOME') .. '/.config/phpstan/phpstan.neon',

        ["console.verbosity"] = 256,
    },
})

vim.lsp.config('docker_compose_language_service',
{
    settings = {
        telemetry = { enable = false },
    },
})

local vue_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
local tsserver_filetypes = {}
local vtsls_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}
local vtsls_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = vtsls_filetypes,
}
local ts_ls_config = {
  -- init_options = {
  --   plugins = {
  --     vue_plugin,
  --   },
  -- },
  filetypes = tsserver_filetypes,
}
local vue_ls_config = {
  on_init = function(client)
    client.handlers['tsserver/request'] = function(_, result, context)
      local ts_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })
      local vtsls_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
      local clients = {}

      -- vim.list_extend(clients, ts_clients)
      vim.list_extend(clients, vtsls_clients)

      if #clients == 0 then
        vim.notify('Could not find `vtsls` or `ts_ls` lsp client, `vue_ls` would not work without it.', vim.log.levels.ERROR)
        return
      end
      local ts_client = clients[1]

      local param = unpack(result)
      local id, command, payload = unpack(param)
      ts_client:exec_cmd({
        title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
        command = 'typescript.tsserverRequest',
        arguments = {
          command,
          payload,
        },
      }, { bufnr = context.bufnr }, function(_, r)
          local response = r and r.body
          -- TODO: handle error or response nil here, e.g. logging
          -- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
          local response_data = { { id, response } }

          ---@diagnostic disable-next-line: param-type-mismatch
          client:notify('tsserver/response', response_data)
        end)
    end
  end,

}
vim.lsp.config('vtsls', vtsls_config)
vim.lsp.config('vue_ls', vue_ls_config)
vim.lsp.config('ts_ls', ts_ls_config)
vim.lsp.enable({'vtsls', 'vue_ls'}) -- If using `ts_ls` replace `vtsls` to `ts_ls`
-- vim.lsp.enable({'ts_ls', 'vue_ls'}) -- If using `ts_ls` replace `vtsls` to `ts_ls`

-- vim.lsp.config('vue_ls',
-- {
--   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
--   -- filetypes = {},
--   -- init_options = {
--     -- typescript = {
--     --   -- Tell Volar where TypeScript lib files are (critical!)
--     --   tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
--     -- },
--     -- vue = {
--     --   hybridMode = false,  -- this activates full takeover mode
--     -- },
--   -- },
-- })
--
-- local vue_typescript_plugin_path = vim.fn.stdpath('data')
--   .. '/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin'
--
-- vim.lsp.config('ts_ls',
-- {
--     init_options = {
--         plugins = {
--             {
--                 name = "@vue/typescript-plugin",
--                 location = vue_typescript_plugin_path,
--                 languages = { 'vue' },
--             },
--         },
--     },
--     -- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
--     filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
-- })

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
    sources = {
        -- { name = "codeium" },
        -- { name = 'nvim_lsp' },
        {
            name = 'nvim_lsp',
            ---@param entry cmp.Entry
            ---@param ctx cmp.Context
            entry_filter = function(entry, ctx)
                -- Check if the buffer type is 'vue'
                if ctx.filetype ~= 'vue' then
                    return true
                end

                -- local item = entry.completion_item
                -- return item.additionalTextEdits and #item.additionalTextEdits > 0
                --     or true

                local cursor_before_line = ctx.cursor_before_line
                -- For events
                if cursor_before_line:sub(-1) == '@' then
                    return entry.completion_item.label:match('^@')
                    -- For props also exclude events with `:on-` prefix
                elseif cursor_before_line:sub(-1) == ':' then
                    return entry.completion_item.label:match('^:') and not entry.completion_item.label:match('^:on%-')
                else
                    return true
                end
            end
        },
        { name = 'luasnip' }, -- For luasnip users.
    },
    -- formatting = {
    --     -- format = function(entry, item)
    --     --     -- if item.additionalTextEdits then
    --     --     --     item.menu = 'hey: ' .. (#entry.completion_item.additionalTextEdits or 0)
    --     --     -- end
    --     --     -- item.menu = 'who'
    --     --     -- return require('nvim-highlight-colors').format(entry, item)
    --     --
    --     --     -- if entry.source.name == 'nvim_lsp' then
    --     --     --     -- item.dup = nil
    --     --     --     pcall(function()
    --     --     --         -- local client_name = entry.source.name
    --     --     --         item.menu = "[" .. #entry.completion_item.additionalTextEdits .. "]"
    --     --     --     end)
    --     --     -- end
    --     --     --
    --     --     return item
    --     end,
    -- },
    -- {
    --     { name = 'buffer' },
    -- }
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
