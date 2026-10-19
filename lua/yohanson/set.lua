vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.fixeol = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.guicursor = "n-c-sm:block-blinkon500-blinkoff500,v:block-blinkon0,i-ci-ve:ver25,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"

vim.opt.listchars = 'tab:⍿·,trail:⋅'
vim.opt.list = true

vim.o.winborder = 'rounded'

-- trying to enable treesitter indent:
vim.opt.smartindent = false
vim.opt.autoindent = false

-- good for copying files, bad for jumping around
-- vim.g.netrw_keepdir = 0

vim.o.fileencodings = 'ucs-bom,utf-8,cp866,cp1251'
vim.cmd('set title')

--vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--    pattern = {'*'},
--    callback = function(ev)
--        if (vim.bo.filetype == 'diff') then
--            return
--        end;
--        save_cursor = vim.fn.getpos(".")
--        vim.cmd([[%s/\s\+$//e]])
--        vim.fn.setpos(".", save_cursor)
--    end,
--})


vim.api.nvim_create_user_command('ToUtfBom', function()
    vim.cmd("set bomb");
    vim.cmd("set fileencoding=utf-8");
    vim.cmd("noautocmd w");
    vim.cmd("set nobomb");
end, {})

vim.diagnostic.config({
    signs = {
        text = {
            -- ⚠️❌🚨⛔
            -- ⓘℹ️📌🛈

            [vim.diagnostic.severity.ERROR] = '❌',
            [vim.diagnostic.severity.WARN] = '⚠️',
            [vim.diagnostic.severity.INFO] = 'ℹ️',
            [vim.diagnostic.severity.HINT] = '󰌵',
        },
        linehl = {
            -- [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
        },
        numhl = {
            -- [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
    },
    -- virtual_text = true,
    -- virtual_lines = true,
})

-- ~/.config/nvim/init.lua
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.wo.diff then
      local opts = { buffer = true, noremap = true, silent = true }
      vim.keymap.set('n', '<leader>gl', ':diffget //2<CR>', opts)  -- get LOCAL
      vim.keymap.set('n', '<leader>gr', ':diffget //3<CR>', opts)  -- get REMOTE
      vim.keymap.set('n', '<leader>gb', ':diffget //1<CR>', opts)  -- get BASE
      vim.keymap.set('n', '<leader>gp', ':diffput<CR>',         opts)
    end
  end,
})
