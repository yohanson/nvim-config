return {
     'aveplen/ruscmd.nvim',
     config = function()
         require('ruscmd').setup({
            -- provide ex-command abbreviation
            -- example: ':й' -> ':q'
            abbreviations = true, -- default true

            -- provide NORMAL-mode translation
            -- example: 'ц' -> 'w'
            keymaps = false, -- default true
         })
     end
}
