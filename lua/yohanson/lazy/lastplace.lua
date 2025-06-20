return {
    "pchuan98/nvim-lastplace",
    lazy = false,
    config = function()
        require("nvim-lastplace").setup({
            lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
            lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
            lastplace_open_folds = true,
            ignore_extension = {}
        })
    end
}
