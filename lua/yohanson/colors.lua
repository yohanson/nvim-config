-- Two colorschemes intentionally, result differs from single.
-- vim.cmd.colorscheme("habamax")
vim.cmd.colorscheme("PaperColor")
vim.api.nvim_set_hl(0, "Normal", { ctermbg=235 }) -- a little lighter background
vim.api.nvim_set_hl(0, "Visual", { cterm=reverse, ctermfg=16, ctermbg=103 })

vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultError", { ctermfg='Red', ctermbg='none' })
vim.cmd([[highlight LspSignatureActiveParameter ctermbg=darkgrey]])

vim.cmd([[highlight markdownError guifg=None guibg=None]])
vim.cmd([[highlight htmlError guifg=None guibg=None]])

vim.api.nvim_set_hl(0, '@lsp.type.comment', {})

-- vim.cmd("set notermguicolors")
vim.o.termguicolors = false
