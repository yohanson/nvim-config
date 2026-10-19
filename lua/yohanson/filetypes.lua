
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
        "docker-compose*.yml",
        "docker-compose*.yaml",
        "compose*.yml",
        "compose*.yaml",
    },
    callback = function(ev)
        vim.bo.filetype = 'yaml.docker-compose'
    end,
})

-- Helm filetype
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'} , {
    pattern = {'*.yaml', '*.yml', '*.tpl'},
    callback = function()
        -- local rootdir = vim.fn.getcwd()
        -- if Chart.yaml is present in root, change filetype to helm:
        local chart_yaml = vim.fn.findfile("Chart.yaml", vim.fn.expand("%:p:h") .. ";")
        if chart_yaml ~= "" and vim.fn.filereadable(chart_yaml) == 1 then
            vim.bo.filetype = "helm"
        end
    end
})

-- vim.filetype.add({
--     extension = {
--         gotmpl = 'gotmpl',
--     },
--     pattern = {
--         [".*/templates/.*%.tpl"] = "helm",
--         [".*/templates/.*%.ya?ml"] = "helm",
--         ["helmfile.*%.ya?ml"] = "helm",
--     },
-- })

vim.api.nvim_create_autocmd('FileType', {
    desc = 'SVN commits must be in cp1251',

    pattern = 'svn',
    callback = function ()
        vim.bo.fileencoding = 'cp1251';
        vim.bo.endofline = false;
        -- vim.bo.fixeol = true
    end,
})


vim.api.nvim_create_autocmd('FileType', {
    desc = "Enable nvim-treesitter and install parser if not installed",
    callback = function(args)
        local treesitter = require('nvim-treesitter')
        local lang = vim.treesitter.language.get_lang(args.match)
        if vim.list_contains(treesitter.get_available(), lang) then
            if not vim.list_contains(treesitter.get_installed(), lang) then
                treesitter.install(lang):wait()
            end
            vim.treesitter.start(args.buf)
        end
    end,
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
