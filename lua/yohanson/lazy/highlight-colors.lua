return {
    'brenoprata10/nvim-highlight-colors',
    config = function()
        require('nvim-highlight-colors').setup {
            -- render = 'background',
            render = 'virtual',
            virtual_symbol = '█',
            exclude_filetypes = {
                'text',
                'gitcommit',
                'markdown',
            },
        }
    end,
}
