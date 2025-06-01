
return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
            dap.adapters.php = {
                type = "executable",
                command = "node",
                args = { os.getenv("HOME") .. "/progs/vscode-php-debug/out/phpDebug.js" }
            }
            dap.configurations.php = {
                {
                    type = "php",
                    request = "launch",
                    name = "Listen for Xdebug",
                    port = 9003,
                    pathMappings = {
                        ["/var/www"] = vim.fn.getcwd() .. "/"
                    }
                }
            }

            vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
            vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
            vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
            vim.keymap.set('n', '<S-F11>', function() require('dap').step_out() end)
            -- F23 == S-F11
            vim.keymap.set('n', '<F23>', function() require('dap').step_out() end)

            vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
            vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
            vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)

            vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
            vim.fn.sign_define('DapStopped', {text='➜', texthl='', linehl='', numhl=''})

            dap.listeners.after.event_stopped['custom_bell'] = function()
                -- Send ASCII bell character to terminal
                vim.fn.chansend(vim.v.stderr, '\007')
            end
        end
    },
    {"rcarriga/nvim-dap-ui",
        dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
        config = function()
            require("dapui").setup({
                mappings = {
                    breakpoints = {
                        open = "<CR>", -- Jump to breakpoint
                        toggle = "t",  -- Toggle breakpoint (optional)
                    },
                },
            })
            vim.keymap.set("n", "<F12>", require("dapui").toggle)
        end
    },
}
