vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "J", "mzJ`z")

vim.o.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"


vim.keymap.set("n", "<F6>", ":edit #<CR>")
vim.keymap.set("n", "<F8>", function()
    vim.cmd('normal M')
    if vim.bo.fileencoding == 'cp1251' then
        vim.cmd(':e! ++enc=cp866')
    else
        vim.cmd(':e! ++enc=cp1251')
    end
end)

vim.keymap.set("n", "<F7>", function()
    if vim.bo.filetype == 'typescript' then
        vim.cmd(':!tsc')
    elseif vim.bo.filetype == 'rust' then
        vim.cmd(':!cargo build')
    else
        vim.cmd(':make')
    end
end)

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>]", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>[", vim.diagnostic.goto_prev)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {})
vim.keymap.set('n', '<leader>f6', function()
    builtin.live_grep({additional_args = {'--encoding=cp866'}, file_encoding='cp866'})
end)
vim.keymap.set('n', '<leader>f1', function()
    builtin.live_grep({additional_args = {'--encoding=cp1251'}, file_encoding='cp1251'})
end)

vim.keymap.set('n', '<C-F12>', function()
    if vim.bo.filetype == 'cpp' then
        vim.cmd(':LspClangdSwitchSourceHeader')
    end
end
)
vim.keymap.set('v', '<Leader>bl', [[:<C-U>!git blame -- <C-R>=expand("%:p") <CR> | sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>]])
