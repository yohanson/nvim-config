return
    {
        "olimorris/codecompanion.nvim",
        enabled = false,
        -- `adapters.<adapter_name>` and `adapters.opts` is deprecated, use `adapters.http.<adapter_name>` and `adapters.http.opts` instead.
        opts = {
            adapters = {
                http = {
                    githubmodels = function()
                        return require("codecompanion.adapters").extend("githubmodels")
                    end,
                    -- ollama = function()
                    -- return require("codecompanion.adapters").extend("ollama", {
                    --     schema = {
                    --         model = {
                    --             -- default = "qwen2.5-coder:1.5b",
                    --             default = "dolphin-mistral:7b",
                    --         },
                    --         num_ctx = {
                    --             default = 32768,
                    --         },
                    --         url = "http://127.0.0.1:11434",
                    --     },
                    -- })
                    -- end,
                },
            },
            strategies = {
                -- chat = { adapter = "ollama" },
                -- inline = { adapter = "ollama" },
                -- agent = { adapter = "ollama" },
                -- opts = {
                --     log_level = "DEBUG", -- Useful for troubleshooting
                -- },
                chat = { adapter = "githubmodels" },
                inline = {
                    adapter = "githubmodels",
                    keymaps = {
                        accept_change = {
                            modes = { n = "ga" },
                            description = "Accept the suggested change",
                        },
                        reject_change = {
                            modes = { n = "gr" },
                            description = "Reject the suggested change",
                        },
                    },
                },
                agent = { adapter = "githubmodels" },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    }
