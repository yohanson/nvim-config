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

vim.opt.listchars = 'tab:⍿·,trail:⋅'
vim.opt.list = true

vim.o.winborder = 'rounded'

-- trying to enable treesitter indent:
vim.opt.smartindent = false
vim.opt.autoindent = false

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
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = {
        "*/coding/**.s362",
        "*/coding/**.hss",
    },
    callback = function(ev)
        vim.bo.filetype = 'cpp'
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = {
        "**.vue",
        "**.js",
    },
    callback = function(ev)
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.suffixesadd:append(".vue")
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = {
        "**.php",
    },
    callback = function(ev)
        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = {
        "*/coding/**.sql",
    },
    callback = function(ev)
        vim.bo.filetype = 'plsql'
    end,
})

vim.api.nvim_create_autocmd({ "FileReadPost" }, {
    pattern = {
        "*/coding/**",
    },
    callback = function(ev)
        local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
        content = table.concat(content)
        tbl = {stringbyte(str, 1, #str)} -- Note: This is about 15% faster than calling string.byte for every character.
        for i = 1, #tbl do
            c = int(tbl[i] / 16)
            echo(c);
            if (i == 100) then
                break;
            end
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = {
        "docker-compose*.yml",
        "docker-compose*.yaml",
        "compose*.yml",
        "compose*.yaml",
    },
    callback = function(ev)
        vim.bo.filetype = 'yaml.docker-compose'
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    desc = 'SVN commits must be in cp1251',

    pattern = 'svn',
    callback = function (opts)
        vim.bo.fileencoding = 'cp1251';
        vim.bo.endofline = false;
        -- vim.bo.fixeol = true
    end,
})

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
})

